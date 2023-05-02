import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site_header_widget.dart';

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
      backgroundColor: const Color.fromARGB(255, 198, 40, 40),
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
                color: Color.fromARGB(255, 248, 248, 248),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 40,
                      horizontal: 20,
                    ),
                    child: TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        iconColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 227, 232, 238),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 227, 232, 238),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        label: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Color.fromARGB(255, 227, 232, 238),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
