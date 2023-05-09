import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class MainSiteCallender extends StatefulWidget {
  const MainSiteCallender({super.key});

  @override
  State<MainSiteCallender> createState() => _MainSiteCallenderState();
}

class _MainSiteCallenderState extends State<MainSiteCallender> {
  final callender = MAP_OF_CALLENDER_WIDGET_STRINGS.values.toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      color: const Color.fromARGB(255, 148, 148, 148),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 248, 248, 248),
                  blurRadius: 3,
                  offset: Offset(-5, 3),
                ),
              ],
            ),
            child: const SizedBox(
              height: 45,
              width: double.infinity,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 6,
                child: SizedBox(
                  height: 45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: callender.length,
                    itemBuilder: (context, index) {
                      if (callender[index] == 'MOJE') {
                        return Container(
                          decoration: const BoxDecoration(
                            color: constants.WHITE_COLOR,
                            border: Border.symmetric(
                              vertical: BorderSide(
                                color: constants.BORDER_COLOR,
                              ),
                            ),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 7,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 9,
                          ),
                          child: Center(
                            child: Text(
                              callender[index],
                              style: GoogleFonts.montserrat(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        );
                      }
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 7,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 9,
                        ),
                        child: Center(
                          child: callender[index] == 'LIVE'
                              ? Row(
                                  children: [
                                    CallenderTextWidget(
                                      callender: callender,
                                      index: index,
                                    ),
                                    const Text(
                                      ' 🟢',
                                      style: TextStyle(
                                        fontSize: 5,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                )
                              : CallenderTextWidget(
                                  callender: callender,
                                  index: index,
                                ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  height: 45,
                  color: constants.BACKGROUND_COLOR,
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Image.asset(
                      constants.CALLENDER_ICON_IMAGE_PATH,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CallenderTextWidget extends StatelessWidget {
  const CallenderTextWidget({
    required this.callender,
    required this.index,
    super.key,
  });
  final int index;
  final List<String> callender;

  @override
  Widget build(BuildContext context) {
    return Text(
      callender[index],
      style: GoogleFonts.montserrat(
        fontSize: 10,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
