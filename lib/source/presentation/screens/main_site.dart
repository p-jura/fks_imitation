import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/single_category_cubit/single_category_event_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site_callender.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site_events_view_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site_filters_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site_header_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site_quick_search_widget.dart';

class MainSite extends StatelessWidget {
  const MainSite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 198, 40, 40),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => injSrv<EventsDataBloc>(),
          ),
          BlocProvider(
            create: (_) => injSrv<SingleCategoryEventCubit>(),
          ),
        ],
        child: Column(
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
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    HeaderWidget(),
                    Divider(
                      color: Color.fromARGB(255, 227, 232, 238),
                      height: 1.50,
                    ),
                    QuickSearchWidget(),
                    Divider(
                      color: Color.fromARGB(255, 227, 232, 238),
                      height: 1.50,
                    ),
                    MainSiteCallender(),
                    Divider(
                      color: Color.fromARGB(255, 227, 232, 238),
                      height: 1.50,
                    ),
                    MainSiteFilters(),
                    Divider(
                      color: Color.fromARGB(255, 227, 232, 238),
                      height: 1.50,
                    ),
                    MainSiteEventsViewWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
