import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<GetEventsFromRemoteSingleCategory>(_getData);
    on<GetEventsFromRemoteAllCategories>(_getAllCategoriesEventData);
    on<GetQueryFromRemote>(_getQueryData);
  }
  void _getData(
    GetEventsFromRemoteSingleCategory event,
    Emitter<EventsDataBlocState> emit,
  ) async {
    emit(LoadingState());
    final eventEitherResponse = await getEventsData.call(event.catalogId);
    eventEitherResponse.fold(
      (failure) {
        failure.mapFailuresToLog();
        emit(
          SingleCategoryEventsLoadedState(
            eventsDataList: const EventsDataList(
              eventData: [],
            ),
          ),
        );
      },
      (eventsDataList) {
        emit(
          SingleCategoryEventsLoadedState(
            eventsDataList: eventsDataList,
          ),
        );
      },
    );
  }

  void _getAllCategoriesEventData(
    GetEventsFromRemoteAllCategories event,
    Emitter<EventsDataBlocState> emit,
  ) async {
    final List<EventsDataList> allCategoriesEventsList = [];
    final List<Map<String, dynamic>> listOfMappedCatWithEventsCount = [];
    emit(LoadingState());

    for (var catId = 1; catId <= event.categoiresAmmount!; catId++) {
      var eventEitherResponse = await getEventsData.call(catId);
      log('eventEitherResponse has data');
      eventEitherResponse.fold(
        (failure) => failure.mapFailuresToLog(),
        (eventsDataList) {
          allCategoriesEventsList.add(eventsDataList);
          listOfMappedCatWithEventsCount.add({
            'categoryName': eventsDataList.eventData.first.category1Name?.toUpperCase(),
            'categoryEventsCount': eventsDataList.eventData.first.gamesCount
          });
        },
      );
    }
    emit(
      AllCategoriesEventsLoadedState(
        allCategoriesEventsList: allCategoriesEventsList,
        listOfMappedCatWithEventsCount: listOfMappedCatWithEventsCount,
      ),
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
        log('ServerOrClientError -  $errorCode: $message');
        break;
      case NoDataFoundFailure:
        log('NoDataFoundFailure - $message');
        break;
    }
  }
}
