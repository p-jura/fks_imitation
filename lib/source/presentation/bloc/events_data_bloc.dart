import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
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
  }
  void _getData(
    GetEventsFromRemote event,
    Emitter<EventsDataBlocState> emit,
  ) async {
    emit(LoadingState());
    final eventEitherResponse = await getEventsData.call(event.catalogId);
    eventEitherResponse.fold(
      (_) => null,
      (eventsDataList) {
        emit(
          LoadedState(
            eventsDataList: eventsDataList,
          ),
        );
      },
    );
  }
}
