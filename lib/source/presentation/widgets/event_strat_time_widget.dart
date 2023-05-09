import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:intl/intl.dart';

import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class EventStartTimeWidget extends StatelessWidget {
  const EventStartTimeWidget({
    super.key,
    required this.event,
  });

  final EventData event;

  @override
  Widget build(BuildContext context) {
    var timeDiference = event.eventStart!.difference(DateTime.now()).inHours;
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: Text(
            DateFormat('H:mm').format(event.eventStart!),
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              const Divider(
                color: constants.BORDER_COLOR,
                indent: 10,
                endIndent: 10,
                thickness: 1,
              ),
              timeDiference <= 0 && timeDiference >= -2
                  ? Divider(
                      color: constants.MATCH_ACTIVE_STATUS_BAR_COLOR,
                      endIndent: timeDiference * (-100),
                    )
                  : const Divider(
                      color: constants.BORDER_COLOR,
                      indent: 10,
                      endIndent: 10,
                      thickness: 1,
                    ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            '+ ${event.eventStart!.difference(DateTime.now()).inDays}',
            style: const TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: constants.DEEP_BACKGROUND_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}
