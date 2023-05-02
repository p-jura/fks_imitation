import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart';
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
    on<GetEventsFromRemoteAllCategories>(_getAllCategoriesEventData);
    on<GetQueryFromRemote>(_getQueryData);
  }

  void _getAllCategoriesEventData(
    GetEventsFromRemoteAllCategories event,
    Emitter<EventsDataBlocState> emit,
  ) async {
    int allEventsGamesCount = 0;
    final Map<int, Map<String, dynamic>> categoriesWithEvents = {
      0: {
        'categoryName': 'WSZYSTKO',
        'categoryEventsCount': allEventsGamesCount,
        'isActive': true,
      }
    };
    emit(LoadingState());
    if (event.categoiresAmmount != null) {
      for (var catId in mapOfCategories.keys) {
        var eventEitherResponse = await getEventsData.call(catId);
        eventEitherResponse.fold(
          // logs - if [catId] has no data, or [ServerError] appear
          (failure) => failure.mapFailuresToLog(),

          (eventsDataList) {
            var eventGamesCount = eventsDataList.eventData.length;

            categoriesWithEvents[catId] = {
              'categoryName':
                  eventsDataList.eventData.first.category1Name?.toUpperCase(),
              'categoryEventsCount': eventGamesCount,
            };
            // adds all events ammount into category 'WSZYSTKO'
            allEventsGamesCount = allEventsGamesCount + eventGamesCount;
          },
        );
        categoriesWithEvents.update(
          0,
          (map) => {
            'categoryName': 'WSZYSTKO',
            'categoryEventsCount': allEventsGamesCount,
            'isActive': true,
          },
        );
      }
    }
    emit(
      AllCategoriesEventsLoadedState(
        categoriesWithEvents: categoriesWithEvents,
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
