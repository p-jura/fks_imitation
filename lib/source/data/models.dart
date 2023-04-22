import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';

part 'models.g.dart';

@JsonSerializable()
class EventsDataDto extends Equatable {
  final int? code;
  final String? description;
  final List<Data>? data;

  const EventsDataDto({
    required this.code,
    required this.description,
    required this.data,
  });
  factory EventsDataDto.fromJson(Map<String, dynamic> json) =>
      _$EventsDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EventsDataDtoToJson(this);

  @override
  List<Object?> get props => [code, description, data];
}

@JsonSerializable(includeIfNull: false)
class Data extends EventData {
  @JsonKey(name: 'eventGames')
  final List<Event> dataEventGames;

  @JsonKey(
    name: 'eventStart',
    fromJson: _dataTimeInMilliseconds,
  )
  final DateTime dataEventStarts;
  const Data({
    required super.eventId,
    required super.eventName,
    required super.category1Id,
    required super.category2Id,
    required super.category3Id,
    required super.category1Name,
    required super.category2Name,
    required super.category3Name,
    required super.eventCodeId,
    required this.dataEventStarts,
    required super.eventType,
    required super.gamesCount,
    required super.remoteId,
    required super.eventExtendedData,
    required this.dataEventGames,
  }) : super(eventGames: dataEventGames, eventStart: dataEventStarts);
  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);

  static DateTime _dataTimeInMilliseconds(int milliseconds) {
    return DateTime.fromMillisecondsSinceEpoch(milliseconds);
  }
}

@JsonSerializable(includeIfNull: false)
class Event extends EventGame {

  @JsonKey(name: 'outcomes')
  final List<OutcomeData> outcome;

  const Event({
    required super.gameId,
    required super.gameName,
    required super.gameType,
    required super.gameCode,
    required super.argument,
    required super.combinationType,
    required super.marketTypes,
    required super.gameLayout,
    required super.eventLayout,
    required this.outcome,
  }) : super(outcomes: outcome);
  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EventToJson(this);
}

@JsonSerializable(includeIfNull: false)
class OutcomeData extends Outcome {
  const OutcomeData({
    required super.outcomeId,
    required super.outcomeName,
    required super.outcomeOdds,
    required super.status,
  });
  factory OutcomeData.fromJson(Map<String, dynamic> json) =>
      _$OutcomeDataFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OutcomeDataToJson(this);
}
