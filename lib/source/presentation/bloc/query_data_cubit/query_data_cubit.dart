import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/all_categories_cubit/all_categories_events_cubit_cubit.dart';

part 'query_data_state.dart';

class QueryDataCubit extends Cubit<QueryState> {
  QueryDataCubit({
    required GetQuickSearchDataFromeRemote getQuickSearchData,
    required GetEventsDataFromRemote getEventsDataFromRemote,
  })  : _getQuickSearchData = getQuickSearchData,
        _getEventsDataFromRemote = getEventsDataFromRemote,
        super(InitialQueryState());

  final GetQuickSearchDataFromeRemote _getQuickSearchData;
  final GetEventsDataFromRemote _getEventsDataFromRemote;

  void getQueryData(
    String query,
  ) async {
    emit(LoadingState());
    final queryEitherResponse = await _getQuickSearchData.call(query);
    queryEitherResponse.fold(
      (failure) {
        failure.mapFailuresToLog();
        emit(
          NoDataFoundState(failure.message ?? 'No data found'),
        );
      },
      (quickSearchResponseList) async {
        final EventsDataList eventsDataList = EventsDataList(eventData: []);
        for (var quickSearch in quickSearchResponseList.quickSearchResponse) {
          var result = await _getEventsDataFromRemote
              .call(quickSearch.extras['CATEGORY_ID_1']);
          result.fold(
            (failure) {
              log('no event found');
            },
            (eventList) {
              for (var event in eventList.eventData) {
                if (event.eventId == quickSearch.id) {
                  // gameType = 1 is proper format to show as resoult
                  event.eventGames
                      .removeWhere((element) => element.gameType != 1);
                  if (event.eventGames.isNotEmpty) {
                    eventsDataList.add(event);
                  }
                }
              }
            },
          );
        }

        emit(
          QueryLoadedState(eventsDataList: eventsDataList),
        );
      },
    );
  }

  void resetData() {
    emit(InitialQueryState());
  }
}
