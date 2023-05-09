import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class HotContainerWidget extends StatelessWidget {
  const HotContainerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      height: 12,
      padding: const EdgeInsets.symmetric(
        vertical: 1,
        horizontal: 4,
      ),
      decoration: const BoxDecoration(
        color: constants.DEEP_BACKGROUND_COLOR,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 7,
            child: Image.asset(
              constants.HOT_ICON_IMAGE_PATH,
              fit: BoxFit.scaleDown,
            ),
          ),
          const SizedBox(width: 3),
          const Text(
            constants.HOT,
            style: TextStyle(
              fontSize: 6,
              fontWeight: FontWeight.bold,
              color: constants.WHITE_COLOR,
            ),
          ),
        ],
      ),
    );
  }
}
