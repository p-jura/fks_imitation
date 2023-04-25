import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_state.dart';

class EventsDataBloc extends Bloc<EventsDataBlocEvent, EventsDataBlocState> {
  final GetEventsDataFromRemote getEventsData;
  final GetQuickSearchDataFromeRemote getQuickSearchData;

  EventsDataBloc({
    required this.getEventsData,
    required this.getQuickSearchData,
  }) : super(EmptyState()) {
    on<GetEventsFromRemote>(_getData);
    on<GetQueryFromRemote>(_getQueryData);
  }
  void _getData(
    GetEventsFromRemote event,
    Emitter<EventsDataBlocState> emit,
  ) async {
    emit(LoadingState());
    final eventEitherResponse = await getEventsData.call(event.catalogId);
    eventEitherResponse.fold(
      (failure) {
        failure.mapFailuresToLog();
        emit(
          EventLoadedState(
            eventsDataList: const EventsDataList(
              eventDataModels: [],
            ),
          ),
        );
      },
      (eventsDataList) {
        emit(
          EventLoadedState(
            eventsDataList: eventsDataList,
          ),
        );
      },
    );
  }

  void _getQueryData(
    GetQueryFromRemote event,
    Emitter<EventsDataBlocState> emit,
  ) async {
    emit(LoadingState());
    final queryEitherResponse = await getQuickSearchData.call(event.query);
    queryEitherResponse.fold(
      (failure) {
        failure.mapFailuresToLog();
        emit(
          QueryLoadedState(
            qickSearchEventList: const QuickSearchResponseList(
              quickSearchResponse: [],
            ),
          ),
        );
      },
      (quickSearchResponseList) => emit(
        QueryLoadedState(
          qickSearchEventList: quickSearchResponseList,
        ),
      ),
    );
  }
}

extension MapFailures on Failure {
  void mapFailuresToLog() {
    switch (runtimeType) {
      case ServerOrClientError:
        log('$errorCode: $message');
        break;
      case NoDataFoundFailure:
        log(message!);
        break;
    }
  }
}
