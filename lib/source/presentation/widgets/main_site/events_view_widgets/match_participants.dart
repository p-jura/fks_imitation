import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/event_strat_time_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/hot_container_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class MachParticipantsExtension extends StatelessWidget {
  const MachParticipantsExtension({
    super.key,
    required this.dataList,
    required this.index,
  });
  final EventsDataList dataList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // only first of games events is actual event
      itemCount: dataList.eventData.length,
      itemBuilder: (context, gamesIndexes) {
        var event = dataList.eventData[gamesIndexes];
        var outcomes = event.eventGames.first.outcomes;
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
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
                          '${event.category3Name?.toUpperCase()} ${DateFormat('dd.MM').format(event.eventStart!)}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // event, date and HOT icon
                        event.eventStart!.difference(DateTime.now()) <
                                const Duration(hours: 4)
                            ? const HotContainerWidget()
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // event progress bar
                    EventStartTimeWidget(event: event),
                    const SizedBox(
                      height: 10,
                    ),
                    // event opponents
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          constraints: const BoxConstraints(maxWidth: 200),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                outcomes!.first.outcomeName!
                                    .toUpperCase()
                                    .toString(),
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                outcomes.last.outcomeName!
                                    .toUpperCase()
                                    .toString(),
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
                            OddsWidget(
                              txt: '1',
                              color: outcomes.first.outcomeOdds >
                                      outcomes.last.outcomeOdds
                                  ? constants.DEEP_BACKGROUND_COLOR
                                  : null,
                              odds: outcomes.first.outcomeOdds.toString(),
                            ),
                            const SizedBox(width: 6),
                            OddsWidget(
                              txt: '2',
                              color: outcomes.last.outcomeOdds >
                                      outcomes.first.outcomeOdds
                                  ? constants.DEEP_BACKGROUND_COLOR
                                  : null,
                              odds: outcomes.last.outcomeOdds.toString(),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OddsWidget extends StatelessWidget {
  const OddsWidget({
    super.key,
    required this.odds,
    this.color,
    required this.txt,
  });
  final String txt;
  final String odds;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 49,
      height: 45,
      padding: const EdgeInsets.symmetric(
        vertical: 9,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: color ?? constants.BORDER_COLOR,
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Column(
        children: [
          Text(
            txt,
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: color != null ? constants.WHITE_COLOR : null,
            ),
          ),
          Text(
            odds.length < 4
                ? '${odds}0'
                : odds.length > 4
                    ? odds.substring(0, 3)
                    : odds,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color != null ? constants.WHITE_COLOR : null,
            ),
          ),
        ],
      ),
    );
  }
}
