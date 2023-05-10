import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';

part 'all_categories_events_state.dart';

class AllCategoriesEventsCubit extends Cubit<AllCategoriesEventsState> {
  AllCategoriesEventsCubit({
    required GetEventsDataFromRemote getEventsData,
  })  : _getEventsData = getEventsData,
        super(AllCategoriesEventsInitial());

  final GetEventsDataFromRemote _getEventsData;

  void getAllCategoriesEventData() async {
    int allEventsGamesCount = 0;
    final Map<int, Map<String, dynamic>> categoriesWithEvents = {
      0: {
        'categoryName': 'WSZYSTKO',
        'categoryEventsCount': allEventsGamesCount,
        'isActive': true,
      }
    };

    emit(AllCategoriesEventsLoading());

    for (var catId in constants.MAP_OF_CATEGORIES.keys) {
      var eventEitherResponse = await _getEventsData.call(catId);
      eventEitherResponse.fold(
        // logs - if [catId] has no data, or [ServerError] appear
        (failure) => failure.mapFailuresToLog(),

        (eventsDataList) {
          var eventGamesCount = eventsDataList.eventData.first.gamesCount ?? 0;

          categoriesWithEvents[catId] = {
            'categoryName':
                eventsDataList.eventData.first.category1Name?.toUpperCase(),
            'categoryEventsCount': eventGamesCount,
            'isActive': false,
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
