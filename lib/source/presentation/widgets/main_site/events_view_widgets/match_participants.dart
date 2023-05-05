import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
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
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 3,
                                  horizontal: 6,
                                ),
                                decoration: const BoxDecoration(
                                  color: constants.DEEP_BACKGROUND_COLOR,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/icons/hot.png',
                                      fit: BoxFit.fitHeight,
                                    ),
                                    const SizedBox(width: 2),
                                    const Text(
                                      'HOT',
                                      style: TextStyle(
                                        fontSize: 6,
                                        fontWeight: FontWeight.bold,
                                        color: constants.WHITE_COLOR,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // event progress bar
                    Row(
                      children: [
                        Text(
                          DateFormat('H:mm').format(event.eventStart!),
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: constants.BORDER_COLOR,
                            indent: 10,
                            endIndent: 10,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          '+ ${event.eventStart!.difference(DateTime.now()).inHours}',
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: constants.DEEP_BACKGROUND_COLOR,
                          ),
                        ),
                      ],
                    ),
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
                                style: const TextStyle(
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
                                style: const TextStyle(
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
