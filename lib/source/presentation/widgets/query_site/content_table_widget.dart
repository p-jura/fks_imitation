
import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/source/presentation/widgets/event_strat_time_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/hot_container_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/odds_widget.dart';
import 'package:google_fonts/google_fonts.dart';
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
          EventStartTimeWidget(event: event),
          ParticipantsWithOdds(event: event),
        ],
      ),
    );
  }
}

class ParticipantsWithOdds extends StatelessWidget {
  const ParticipantsWithOdds({super.key, required this.event});
  final EventData event;
  @override
  Widget build(BuildContext context) {
    var counter = -1;
    final List<dynamic> oddsType = [1, 'X', 2];

    final outcomes = event.eventGames.first.outcomes;
    var highOdd = 0.0;
    outcomes?.forEach(
      (element) {
        element.outcomeOdds > highOdd ? highOdd = element.outcomeOdds : null;
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                outcomes!.first.outcomeName!.toUpperCase().toString(),
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                outcomes.last.outcomeName!.toUpperCase().toString(),
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // odds
        Row(
          children: [
            ...outcomes.map(
              (outcom) {
                counter = counter + 1;
                return Container(
                  margin: const EdgeInsets.only(left: 6),
                  child: OddsWidget(
                    txt: outcomes.length>2? oddsType[counter].toString(): counter.toString(),
                    color: outcom.outcomeOdds == highOdd
                        ? constants.DEEP_BACKGROUND_COLOR
                        : null,
                    odds: outcomes[counter].outcomeOdds.toString(),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
