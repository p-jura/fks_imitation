import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart' as get_it_instance;
import 'package:fuksiarz_imitation/source/presentation/bloc/all_categories_cubit/all_categories_events_cubit_cubit.dart';

import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/main_site_callender.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/main_site_events_view_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/main_site_filters_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/main_site_header_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/main_site_quick_search_widget.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class MainSite extends StatelessWidget {
  const MainSite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.DEEP_BACKGROUND_COLOR,
      body: BlocProvider(
        create: (_) => get_it_instance.injSrv<AllCategoriesEventsCubit>(),
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
                  color: constants.BACKGROUND_COLOR,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    HeaderWidget(),
                    Divider(
                      color: constants.BORDER_COLOR,
                      height: 1.50,
                    ),
                    QuickSearchWidget(),
                    Divider(
                      color: constants.BORDER_COLOR,
                      height: 1.50,
                    ),
                    MainSiteCallender(),
                    Divider(
                      color: constants.BORDER_COLOR,
                      height: 1.50,
                    ),
                    MainSiteFilters(),
                    Divider(
                      color: constants.BORDER_COLOR,
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
