import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class RecomendedViewWidget extends StatelessWidget {
  const RecomendedViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              constants.RECOMENDED,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              constants.SHOW_ALL,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: constants.DEEP_BACKGROUND_COLOR,),
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 80,
              child: Image.asset(
                constants.FIRST_IMAGE_PATH,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 80,
              child: Image.asset(
                constants.SECOND_IMAGE_PATH,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 80,
              child: Image.asset(
                constants.THIRD_IMAGE_PATH,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 80,
              child: Image.asset(
                constants.FOURTH_IMAGE_PATH,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 80,
              child: Image.asset(
                constants.FIFTH_IMAGE_PATH,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
