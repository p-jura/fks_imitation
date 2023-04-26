import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSiteCallender extends StatefulWidget {
  const MainSiteCallender({super.key});

  @override
  State<MainSiteCallender> createState() => _MainSiteCallenderState();
}

class _MainSiteCallenderState extends State<MainSiteCallender> {
  final callender = mapOfCallenderWidget.values.toList();

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
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 7,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 15,
                        ),
                        child: Text(
                          callender[index],
                          style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
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
                  color: const Color.fromARGB(255, 248, 248, 248),
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Image.asset('assets/images/icons/callender.png'),
                    // Icon(
                    //   Icons.calendar_month_outlined,
                    //   size: 24,
                    //   color: Color.fromARGB(255, 50, 50, 50),
                    // ),
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
