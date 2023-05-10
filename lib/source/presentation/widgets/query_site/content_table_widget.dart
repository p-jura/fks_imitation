import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/source/presentation/widgets/event_strat_time_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/hot_container_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/participants_with_odds_widget.dart';
import 'package:intl/intl.dart';

class ContentTableWidget extends StatelessWidget {
  const ContentTableWidget({
    super.key,
    required this.eventList,
  });

  final EventsDataList eventList;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ...eventList.eventData
            .map(
              (event) => ContentWidget(
                event: event,
              ),
            )
            .toList(),
      ],
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key, required this.event});
  final EventData event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: constants.BORDER_COLOR,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${event.category3Name}  ${DateFormat('dd.MM').format(event.eventStart!)}',
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                    height: 12,
                    child: Image.asset(constants.TV_FULL_IMAGE_PATH),
                  ),
                  const HotContainerWidget(),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          EventStartTimeWidget(event: event),
          ParticipantsWithOdds(event: event),
        ],
      ),
    );
  }
}
