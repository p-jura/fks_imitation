import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/odds_widget.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class ParticipantsWithOdds extends StatelessWidget {
  const ParticipantsWithOdds({super.key, required this.event});
  final EventData event;
  @override
  Widget build(BuildContext context) {
    final List<dynamic> oddsType = [1, 'X', 2];
    final outcomes = event.eventGames.first.outcomes;

    // counter is oddType index used to display proper information in widget
    var counter = -1;
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
                    txt: outcomes.length > 2
                        ? oddsType[counter].toString()
                        : counter.toString(),
                    color: outcom.outcomeOdds == highOdd
                        ? constants.DEEP_BACKGROUND_COLOR
                        : null,
                    odds: outcomes[counter].outcomeOdds.toString(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
