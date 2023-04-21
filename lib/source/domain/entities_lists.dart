import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';

@immutable
class EventsDataList extends Equatable {
  final List<EventData> eventDataModels;

  const EventsDataList({required this.eventDataModels});

  factory EventsDataList.fromJson(Map<String, dynamic> json) {
    final List jsonList = json['data'];

    List<EventData> eventList = [];

    for (var dynamicListElement in jsonList) {
      eventList.add(
        EventData(
          eventId: dynamicListElement['eventId'],
          eventName: dynamicListElement['eventName'],
          category1Id: dynamicListElement['category1Id'],
          category2Id: dynamicListElement['category2Id'],
          category3Id: dynamicListElement['category3Id'],
          category1Name: dynamicListElement['category1Name'],
          category2Name: dynamicListElement['category2Name'],
          category3Name: dynamicListElement['category3Name'],
          eventCodeId: dynamicListElement['eventCodeId'],
          eventStart: DateTime.fromMillisecondsSinceEpoch(
            dynamicListElement['eventStart'],
          ),
          eventType: dynamicListElement['eventType'],
          gamesCount: dynamicListElement['gamesCount'],
          remoteId: dynamicListElement['remoteId'],
          eventExtendedData: (dynamicListElement['eventExtendedData'] as List)
              .map((element) => element as Map<String, dynamic>)
              .toList(),
          eventGames: EventGamesList.eventGamesToList(
            (dynamicListElement['eventGames'] as List)
                .map((element) => element as Map<String, dynamic>)
                .toList(),
          ).list,
        ),
      );
    }
    return EventsDataList(eventDataModels: eventList);
  }
  List<EventData> get list => [...eventDataModels];

  @override
  List<Object?> get props => [eventDataModels];
}

class EventGamesList extends Equatable {
  final List<EventGame> gameEvents;

  const EventGamesList(this.gameEvents);
  factory EventGamesList.eventGamesToList(
    List<Map<String, dynamic>> eventGames,
  ) {
    List<EventGame> result = [];
    for (var eventElement in eventGames) {
      result.add(
        EventGame(
          gameId: eventElement['gameId'],
          gameName: eventElement['gameName'],
          gameType: eventElement['gameType'],
          gameCode: eventElement['gameCode'],
          argument: eventElement['argument'],
          combinationType: eventElement['combinationType'],
          marketTypes: eventElement['marketTypes'],
          gameLayout: eventElement['gameLayout'],
          eventLayout: eventElement['eventLayout'],
          outcomes: OutcomesList.outcomesToList(
            (eventElement['outcomes'] as List)
                .map((element) => element as Map<String, dynamic>)
                .toList(),
          ).list,
        ),
      );
    }
    return EventGamesList(result);
  }
  List<EventGame> get list => [...gameEvents];

  @override
  List<Object?> get props => [gameEvents];
}

class OutcomesList extends Equatable {
  final List<Outcome> outcomeList;

  const OutcomesList(this.outcomeList);
  factory OutcomesList.outcomesToList(List<Map<String, dynamic>> outcomes) {
    List<Outcome> result = [];
    for (var outcome in outcomes) {
      result.add(
        Outcome(
          outcomeId: outcome['outcomeId'],
          outcomeName: outcome['outcomeName'],
          outcomeOdds: outcome['outcomeOdds'],
          status: outcome['status'],
        ),
      );
    }
    return OutcomesList(result);
  }
  List<Outcome> get list => [...outcomeList];

  @override
  List<Object?> get props => [outcomeList];
}

