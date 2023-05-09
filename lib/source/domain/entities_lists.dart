import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';

@immutable
class EventsDataList extends Equatable {
  final List<EventData> eventData;

  const EventsDataList({required this.eventData});

  @override
  List<Object?> get props => [eventData];

  void add(EventData event) {
    eventData.add(event);
  }
}

class EventGamesList extends Equatable {
  final List<EventGame> gameEvents;

  const EventGamesList(this.gameEvents);

  @override
  List<Object?> get props => [gameEvents];
}

class OutcomesList extends Equatable {
  final List<Outcome> outcomeList;

  const OutcomesList(this.outcomeList);

  @override
  List<Object?> get props => [outcomeList];
}

class QuickSearchResponseList extends Equatable {
  final List<QuickSearchResponse> quickSearchResponse;

  const QuickSearchResponseList({required this.quickSearchResponse});
  @override
  List<Object?> get props => [quickSearchResponse];
}
