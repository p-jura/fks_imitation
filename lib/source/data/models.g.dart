// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventsDataDto _$EventsDataDtoFromJson(Map<String, dynamic> json) =>
    EventsDataDto(
      code: json['code'] as int?,
      description: json['description'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Data.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventsDataDtoToJson(EventsDataDto instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      eventId: json['eventId'] as int,
      eventName: json['eventName'] as String?,
      category1Id: json['category1Id'] as int,
      category2Id: json['category2Id'] as int,
      category3Id: json['category3Id'] as int,
      category1Name: json['category1Name'] as String?,
      category2Name: json['category2Name'] as String?,
      category3Name: json['category3Name'] as String?,
      eventCodeId: json['eventCodeId'] as int,
      dataEventStarts: Data._dataTimeInMilliseconds(json['eventStart'] as int),
      eventType: json['eventType'] as int?,
      gamesCount: json['gamesCount'] as int?,
      remoteId: json['remoteId'] as int?,
      eventExtendedData: json['eventExtendedData'] as Map<String, dynamic>?,
      dataEventGames: (json['eventGames'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataToJson(Data instance) {
  final val = <String, dynamic>{
    'eventId': instance.eventId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('eventName', instance.eventName);
  val['category1Id'] = instance.category1Id;
  val['category2Id'] = instance.category2Id;
  val['category3Id'] = instance.category3Id;
  writeNotNull('category1Name', instance.category1Name);
  writeNotNull('category2Name', instance.category2Name);
  writeNotNull('category3Name', instance.category3Name);
  val['eventCodeId'] = instance.eventCodeId;
  writeNotNull('eventType', instance.eventType);
  writeNotNull('gamesCount', instance.gamesCount);
  writeNotNull('remoteId', instance.remoteId);
  writeNotNull('eventExtendedData', instance.eventExtendedData);
  val['eventGames'] = instance.dataEventGames;
  val['eventStart'] = instance.dataEventStarts.toIso8601String();
  return val;
}

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      gameId: json['gameId'] as int,
      gameName: json['gameName'] as String?,
      gameType: json['gameType'] as int,
      gameCode: json['gameCode'] as int,
      argument: (json['argument'] as num).toDouble(),
      combinationType: json['combinationType'] as int,
      marketTypes: json['marketTypes'] as List<dynamic>,
      gameLayout: json['gameLayout'] as int,
      eventLayout: json['eventLayout'] as int,
      outcome: (json['outcomes'] as List<dynamic>)
          .map((e) => OutcomeData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) {
  final val = <String, dynamic>{
    'gameId': instance.gameId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('gameName', instance.gameName);
  val['gameType'] = instance.gameType;
  val['gameCode'] = instance.gameCode;
  val['argument'] = instance.argument;
  val['combinationType'] = instance.combinationType;
  val['marketTypes'] = instance.marketTypes;
  val['gameLayout'] = instance.gameLayout;
  val['eventLayout'] = instance.eventLayout;
  val['outcomes'] = instance.outcome;
  return val;
}

OutcomeData _$OutcomeDataFromJson(Map<String, dynamic> json) => OutcomeData(
      outcomeId: json['outcomeId'] as int,
      outcomeName: json['outcomeName'] as String?,
      outcomeOdds: (json['outcomeOdds'] as num).toDouble(),
      status: json['status'] as int,
    );

Map<String, dynamic> _$OutcomeDataToJson(OutcomeData instance) {
  final val = <String, dynamic>{
    'outcomeId': instance.outcomeId,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('outcomeName', instance.outcomeName);
  val['outcomeOdds'] = instance.outcomeOdds;
  val['status'] = instance.status;
  return val;
}
