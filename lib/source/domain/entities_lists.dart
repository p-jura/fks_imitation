import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';

@immutable
class EventsDataList extends Equatable {
  final List<EventData> eventDataModels;

  const EventsDataList({required this.eventDataModels});
  List<EventData> get list => [...eventDataModels];

  @override
  List<Object?> get props => [eventDataModels];
}

class EventGamesList extends Equatable {
  final List<EventGame> gameEvents;

  const EventGamesList(this.gameEvents);
  List<EventGame> get list => [...gameEvents];

  @override
  List<Object?> get props => [gameEvents];
}

class OutcomesList extends Equatable {
  final List<Outcome> outcomeList;

  const OutcomesList(this.outcomeList);
  List<Outcome> get list => [...outcomeList];

  @override
  List<Object?> get props => [outcomeList];
}
