import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site_header_widget.dart';

const Color BORDERCOLOR = Color.fromARGB(255, 227, 232, 238);
const Color BACKGROUNDCOLOR = Color.fromARGB(255, 248, 248, 248);
const Color DEEPBORDERCOLOR = Color.fromARGB(255, 196, 196, 196);
const Color DEEPBACKGROUND = Color.fromARGB(255, 198, 40, 40);

const String EARLYPAYOUT = 'EARLY PAYOUT';
const String POLECANE = 'POLECANE:';
const String POKAZWSZYSTKIE = 'POKAŻ WSZYSTKIE';

const String FIRSTIMAGEPATH = 'assets/images/first_image.png';
const String SECONDIMAGEPATH = 'assets/images/second_image.png';
const String THIRDIMAGEPATH = 'assets/images/third_image.png';
const String FOURTHIMAGEPATH = 'assets/images/fourth_image.png';
const String FIFTHIMAGEPATH = 'assets/images/fifth_image.png';

class QuerySite extends StatefulWidget {
  const QuerySite({super.key});

  static const routName = '/quick_search';

  @override
  State<QuerySite> createState() => _QuerySiteState();
}

TextEditingController _controller = TextEditingController();

class _QuerySiteState extends State<QuerySite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DEEPBACKGROUND,
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          // Main part of site
          Flexible(
            flex: 20,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: BACKGROUNDCOLOR,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: BORDERCOLOR,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: BORDERCOLOR,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        prefixIcon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: DEEPBORDERCOLOR,
                          size: 13,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          POLECANE,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          POKAZWSZYSTKIE,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: DEEPBACKGROUND),
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
                            FIRSTIMAGEPATH,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Image.asset(
                            SECONDIMAGEPATH,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Image.asset(
                            THIRDIMAGEPATH,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Image.asset(
                            FOURTHIMAGEPATH,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          child: Image.asset(
                            FIFTHIMAGEPATH,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
