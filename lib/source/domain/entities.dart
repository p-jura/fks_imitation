import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class EventData extends Equatable {
  final int eventId;
  final String eventName;
  final int category1Id;
  final int category2Id;
  final int category3Id;
  final String category1Name;
  final String category2Name;
  final String category3Name;
  final int eventCodeId;
  final DateTime eventStart;
  final int eventType;
  final int gamesCount;
  final int remoteId;
  final List<Map<String, dynamic>> eventExtendedData;
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
  final String gameName;
  final int gameType;
  final int gameCode;
  final double argument;
  final int combinationType;
  final List<int> marketTypes;
  final int gameLayout;
  final int eventLayout;
  final List<Outcome> outcomes;

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
  final String outcomeName;
  final double outcomeOdds;
  final int status;

  const Outcome({
    required this.outcomeId,
    required this.outcomeName,
    required this.outcomeOdds,
    required this.status,
  });

  @override
  List<Object?> get props => [
        outcomeId,
        outcomeName,
        outcomeOdds,
        status,
      ];
}

@immutable
class QuickSearchBody {}

@immutable
class QuickSearchResponseBody {}
