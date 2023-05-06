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
    return Row(
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
    );
  }
}