import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:google_fonts/google_fonts.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with TickerProviderStateMixin {
  double turns = 0;

  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 2,
    ),
  );
  late final Animation<double> _animation =
      CurvedAnimation(parent: _animationController, curve: Curves.linear);

  @override
  void initState() {
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          RotationTransition(
            turns: _animation,
            child: SizedBox(
                height: 84,
                width: 84,
                child: Image.asset(constants.QUICKSEARCH_PROGRESS_INDICATOR),),
          ),
          Container(
            margin: const EdgeInsets.all(5),
            child: Text(
              constants.GIVE_US_A_MOMENT,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            constants.SEACKING_THROU_DATABASE,
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
