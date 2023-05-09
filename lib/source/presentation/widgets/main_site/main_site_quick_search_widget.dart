import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class QuickSearchWidget extends StatelessWidget {
  const QuickSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: const BoxDecoration(
        color: constants.BACKGROUND_COLOR,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed('/quick_search');
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: constants.WHITE_COLOR,
            border: Border.all(
              color: constants.BORDER_COLOR,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Row(
            children: const [
              Icon(
                Icons.search_rounded,
                size: 18,
                color: constants.SEARCH_ICON_COLOR,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                constants.WHAT_ARE_YOU_LOOKING_FOR,
                style: TextStyle(
                  color: constants.SEARCH_ICON_COLOR,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
