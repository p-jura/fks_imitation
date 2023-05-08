import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

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
