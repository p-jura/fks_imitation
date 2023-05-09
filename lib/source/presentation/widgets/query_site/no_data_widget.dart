import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:google_fonts/google_fonts.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            width: 84,
            height: 84,
            child: Image.asset(constants.NO_DATA_IMAGE_PATH),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              constants.NO_RESULTS,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            constants.TRY_ANOTHER_QUERY,
            style: GoogleFonts.montserrat(
              color: constants.DEEP_BORDER_COLOR,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
