import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_state.dart';

class EventsDataBloc extends Bloc<EventsDataBlocEvent, EventsDataBlocState> {
  final GetEventsDataFromRemote getEventsData;
  final GetQuickSearchDataFromeRemote getQuickSearchData;

  EventsDataBloc({
    required this.getEventsData,
    required this.getQuickSearchData,
  }) : super(EmptyState()) {
    on<GetEventsFromRemoteAllCategories>(_getAllCategoriesEventData);
    on<GetQueryFromRemote>(_getQueryData);
  }

  void _getAllCategoriesEventData(
    GetEventsFromRemoteAllCategories event,
    Emitter<EventsDataBlocState> emit,
  ) async {
    int allCatEventsCount = 0;
    final List<EventsDataList> allCategoriesEventsList = [];
    final List<Map<String, dynamic>> listOfMappedCatWithEventsCount = [
      {
        'categoryName': 'WSZYSTKO',
        'categoryEventsCount': allCatEventsCount,
        'isActive': true,
      }
    ];

    emit(LoadingState());

    for (var catId = 1; catId <= event.categoiresAmmount!; catId++) {
      var eventEitherResponse = await getEventsData.call(catId);
      eventEitherResponse.fold(
        // logs - if [catId] has no data, or [ServerError] appear
        (failure) => failure.mapFailuresToLog(),

        (eventsDataList) {
          allCategoriesEventsList.add(eventsDataList);
          var sumOfAllGames = eventsDataList.eventData.addAllGamesInList();
          listOfMappedCatWithEventsCount.add({
            'categoryName':
                eventsDataList.eventData.first.category1Name?.toUpperCase(),
            'categoryEventsCount': sumOfAllGames,
          });
          // adds all events ammount into category 'WSZYSTKO'
          allCatEventsCount = allCatEventsCount + sumOfAllGames;
          listOfMappedCatWithEventsCount.first['categoryEventsCount'] =
              allCatEventsCount;
        },
      );
    }
    emit(
      AllCategoriesEventsLoadedState(
        allCategoriesEventsList: [...allCategoriesEventsList],
        listOfMappedCatWithEventsCount: [...listOfMappedCatWithEventsCount],
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
        log('NoDataFoundFailure - $message : $errorCode');
        break;
    }
  }
}

extension SumOfAllGamesCountFields on List<EventData> {
  /// Adds all "gamesCount" fields of [EventData] within List<EventData>
  int addAllGamesInList() {
    int result = 0;
    for (EventData a in this) {
      result = result + a.gamesCount!;
    }
    return result;
  }
}
