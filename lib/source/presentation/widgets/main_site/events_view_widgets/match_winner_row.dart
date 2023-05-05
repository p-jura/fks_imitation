import 'package:flutter/material.dart';

import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:google_fonts/google_fonts.dart';

class MatchWinnerRow extends StatelessWidget {
  const MatchWinnerRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 41,
      padding: const EdgeInsets.only(top: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: const [
            WinnerBoxExtension(
              text: 'ZWYCIĘZCA MECZU',
              width: 130,
              isActive: true,
            ),
            WinnerBoxExtension(
              text: 'ZWYCIĘZCA PIERWSZEJ POŁOWY MECZU',
              width: 240,
              isActive: false,
            ),
            WinnerBoxExtension(
              text: 'ZWYCIĘZCA TURNIEJU',
              width: 140,
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}

class WinnerBoxExtension extends StatelessWidget {
  const WinnerBoxExtension({
    super.key,
    required this.text,
    required this.width,
    required this.isActive,
  });
  final bool isActive;
  final String text;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: width,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: width,
            child: Divider(
                thickness: 2.0,
                color: isActive
                    ? constants.ISACTIVE_COMPONENT_COLOR
                    : constants.BACKGROUND_COLOR,),
          ),
        ],
      ),
    );
  }
}
