import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_cubit/query_data_cubit.dart';

import 'package:fuksiarz_imitation/source/presentation/screens/main_site.dart';
import 'package:google_fonts/google_fonts.dart';
import 'source/get_it_instance.dart' as get_it_instance;
import 'source/presentation/bloc/all_categories_cubit/all_categories_events_cubit_cubit.dart';
import 'source/presentation/bloc/single_category_cubit/single_category_event_cubit.dart';
import 'source/presentation/screens/query_site.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => get_it_instance.injSrv<SingleCategoryEventCubit>(),
        ),
        BlocProvider(
          create: (_) => get_it_instance.injSrv<QueryDataCubit>(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const MainSite(),
          '/quick_search': (context) => QuerySite(),
        },
      ),
    );
  }
}
