import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class EventData extends Equatable {
  final int eventId;
  final String? eventName;
  final int category1Id;
  final int category2Id;
  final int category3Id;
  final String? category1Name;
  final String? category2Name;
  final String? category3Name;
  final int? eventCodeId;
  final DateTime? eventStart;
  final int? eventType;
  final int? gamesCount;
  final int? remoteId;
  final Map<String, dynamic>? eventExtendedData;
  final List<EventGame> eventGames;

  const EventData({
    required this.eventId,
    required this.eventName,
    required this.category1Id,
    required this.category2Id,
    required this.category3Id,
    required this.category1Name,
    required this.category2Name,
    required this.category3Name,
    required this.eventCodeId,
    required this.eventStart,
    required this.eventType,
    required this.gamesCount,
    required this.remoteId,
    required this.eventExtendedData,
    required this.eventGames,
  });

  List<Object?> toList() {
    return [
      eventId,
      eventName,
      category1Id,
      category2Id,
      category3Id,
      category1Name,
      category2Name,
      category3Name,
      eventCodeId,
      eventStart,
      eventType,
      gamesCount,
      remoteId,
      eventExtendedData,
      eventGames,
    ];
  }

  @override
  List<Object?> get props => [
        eventId,
        eventName,
        category1Id,
        category2Id,
        category3Id,
        category1Name,
        category2Name,
        category3Name,
        eventCodeId,
        eventStart,
        eventType,
        gamesCount,
        remoteId,
        eventExtendedData,
        eventGames,
      ];
}

@immutable
class EventGame extends Equatable {
  final int gameId;
  final String? gameName;
  final int gameType;
  final int gameCode;
  final double argument;
  final int combinationType;
  final List marketTypes;
  final int gameLayout;
  final int eventLayout;
  final List<Outcome>? outcomes;

  const EventGame({
    required this.gameId,
    required this.gameName,
    required this.gameType,
    required this.gameCode,
    required this.argument,
    required this.combinationType,
    required this.marketTypes,
    required this.gameLayout,
    required this.eventLayout,
    required this.outcomes,
  });

  factory EventGame.fromJson(Map<String, dynamic> json) => EventGame(
        gameId: json['gameId'],
        gameName: json['gameName'],
        gameType: json['gameType'],
        gameCode: json['gameCode'],
        argument: json['argument'],
        combinationType: json['combinationType'],
        marketTypes: json['marketTypes'],
        gameLayout: json['gameLayout'],
        eventLayout: json['eventLayout'],
        outcomes: json['outcomes'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gameId'] = gameId;
    data['gameName'] = gameName;
    data['gameType'] = gameType;
    data['gameCode'] = gameCode;
    data['argument'] = argument;
    data['combinationType'] = combinationType;
    data['marketTypes'] = marketTypes;
    data['gameLayout'] = gameLayout;
    data['eventLayout'] = eventLayout;
    data['outcomes'] = outcomes;
    return data;
  }

  @override
  List<Object?> get props => [
        gameId,
        gameName,
        gameType,
        gameCode,
        argument,
        combinationType,
        marketTypes,
        gameLayout,
        eventLayout,
        outcomes,
      ];
}

@immutable
class Outcome extends Equatable {
  final int outcomeId;
  final String? outcomeName;
  final double outcomeOdds;
  final int status;

  const Outcome({
    required this.outcomeId,
    required this.outcomeName,
    required this.outcomeOdds,
    required this.status,
  });
  factory Outcome.fromJson(Map<String, dynamic> json) => Outcome(
        outcomeId: json['outcomeId'],
        outcomeName: json['outcomeName'],
        outcomeOdds: json['outcomeOdds'],
        status: json['status'],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['outcomeId'] = outcomeId;
    data['outcomeName'] = outcomeName;
    data['outcomeOdds'] = outcomeOdds;
    data['status'] = status;
    return data;
  }

  @override
  List<Object?> get props => [
        outcomeId,
        outcomeName,
        outcomeOdds,
        status,
      ];
}

@immutable
class QuickSearchResponse extends Equatable {
  final String area;
  final String name;
  final int id;
  final double score;
  final DateTime eventStart;
  final Map<String, dynamic> extras;

  const QuickSearchResponse({
    required this.area,
    required this.name,
    required this.id,
    required this.score,
    required this.eventStart,
    required this.extras,
  });
  factory QuickSearchResponse.fromJson(Map<String, dynamic> json) =>
      QuickSearchResponse(
        area: json['area'],
        name: json['name'],
        id: json['id'],
        score: json['score'],
        extras: json['extras'],
        eventStart: DateTime.fromMillisecondsSinceEpoch(json['eventStart']),
      );
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    data['name'] = name;
    data['id'] = id;
    data['score'] = score;
    data['extras'] = extras;
    data['eventStart'] = eventStart.millisecondsSinceEpoch;
    return data;
  }

  @override
  List<Object?> get props => [area, name, id, score, extras];

  EventData qsResponseToEventData() => EventData(
        eventId: id,
        eventName: name,
        category1Id: extras['CATEGORY_ID_1'],
        category2Id: extras['CATEGORY_ID_2'],
        category3Id: extras['CATEGORY_ID_3'],
        category1Name: extras['CATEGORY_NAME_1'],
        category2Name: extras['CATEGORY_NAME_2'],
        category3Name: extras['CATEGORY_NAME_3'],
        eventCodeId: id,
        eventStart: eventStart,
        eventType: extras['SPORT_ID'],
        gamesCount: null,
        remoteId: null,
        eventExtendedData: null,
        eventGames: const [],
      );
}
