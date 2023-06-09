import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 80,
            height: 20,
            child: Image.asset(
              constants.LOGO_IMAGE_PATH,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(30)),
              border: Border.all(
                color: constants.BORDER_COLOR,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                const Icon(
                  Icons.add_circle,
                  size: 24,
                  color: constants.DEEP_BACKGROUND_COLOR,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  constants.PRICE,
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
