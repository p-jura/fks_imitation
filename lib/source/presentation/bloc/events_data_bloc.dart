import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';

import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_state.dart';

class EventsDataBloc extends Bloc<EventsDataBlocEvent, EventsDataBlocState> {
  final GetEventsDataFromRemote getEventsData;

  EventsDataBloc({
    required this.getEventsData,
  }) : super(EmptyState()) {
    on<GetAllCategoriesEventsData>(_getAllCategoriesEventData);
    on<GetSingleCategoryEventsData>(_getSingleCategoryData);
  }

  void _getAllCategoriesEventData(
    GetAllCategoriesEventsData event,
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

    for (var catId in MAP_OF_CATEGORIES.keys) {
      var eventEitherResponse = await getEventsData.call(catId);
      eventEitherResponse.fold(
        // logs - if [catId] has no data, or [ServerError] appear
        (failure) => failure.mapFailuresToLog(),

        (eventsDataList) {
          var eventGamesCount = eventsDataList.eventData.first.gamesCount ?? 0;

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

    emit(
      AllCategoriesEventsLoadedState(
        categoriesWithEvents: categoriesWithEvents,
      ),
    );
  }

  void _getSingleCategoryData(
    GetSingleCategoryEventsData event,
    Emitter<EventsDataBlocState> emit,
  ) async {
    emit(LoadingState());
    final eventEitherResponse = await getEventsData.call(event.categoryId);
    eventEitherResponse.fold(
      (failure) {
        failure.mapFailuresToLog();
      },
      (eventsDataList) {
        emit(
          SingleCategoryEventsLoadedState(
            eventsDataList: eventsDataList,
            categoryId: event.categoryId,
          ),
        );
      },
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
