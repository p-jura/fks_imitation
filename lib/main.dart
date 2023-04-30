import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/presentation/screens/main_site.dart';
import 'package:google_fonts/google_fonts.dart';
import 'source/get_it_instance.dart' as get_it_instance;

void main() async {
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.windows) {
    await get_it_instance.setUp();
    runApp(const AppRootWidget());
  }
}

class AppRootWidget extends StatelessWidget {
  const AppRootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainSite(),
    );
  }
}
