import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/event_strat_time_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/hot_container_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/odds_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class MachParticipantsExtension extends StatelessWidget {
  const MachParticipantsExtension({
    super.key,
    required this.dataList,
  });
  final EventsDataList dataList;

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

        var counter = -1;
        final List<dynamic> oddsType = [1, 'X', 2];

        var highOdd = 0.0;
        outcomes?.forEach(
          (element) {
            element.outcomeOdds > highOdd
                ? highOdd = element.outcomeOdds
                : null;
          },
        );

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
                          constraints: const BoxConstraints(maxWidth: 150),
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
                        LayoutBuilder(
                          builder: (ctx, constraints) => SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: constraints.maxWidth,
                                minWidth: constraints.minWidth,
                              ),
                              child: Row(
                                children: [
                                  ...outcomes.map(
                                    (outcom) {
                                      //
                                      if (counter < 2) {
                                        counter = counter + 1;
                                      } else {
                                        counter = 0;
                                      }
                                      return Container(
                                        margin: const EdgeInsets.only(left: 6),
                                        child: OddsWidget(
                                          txt: outcomes.length > 2
                                              ? oddsType[counter].toString()
                                              : (counter + 1).toString(),
                                          color: outcom.outcomeOdds == highOdd
                                              ? constants.DEEP_BACKGROUND_COLOR
                                              : null,
                                          odds: outcomes[counter]
                                              .outcomeOdds
                                              .toString(),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
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
