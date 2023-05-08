import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart'
    as get_it_instance;
import 'package:fuksiarz_imitation/source/presentation/bloc/all_categories_cubit/all_categories_events_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/loading_widget.dart';

import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/main_site_callender.dart';

import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/main_site_events_widget.dart';
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
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          // Main part of site
          BlocBuilder<AllCategoriesEventsCubit, AllCategoriesEventsState>(
            builder: (_, state) {
              if (state is AllCategoriesEventsLoading) {
                return Flexible(
                  flex: 20,
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: constants.BACKGROUND_COLOR,
                    ),
                    child: const LoadingWidget(),
                  ),
                );
              } else if (state is AllCategoriesEventsLoadedState) {
                final Map<int, Map<String, dynamic>>
                    categoriesMappedWithEvents = state.categoriesWithEvents;
                return Flexible(
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
                      children: [
                        const HeaderWidget(),
                        const Divider(
                          color: constants.BORDER_COLOR,
                          height: 1.50,
                        ),
                        const QuickSearchWidget(),
                        const Divider(
                          color: constants.BORDER_COLOR,
                          height: 1.50,
                        ),
                        const MainSiteCallender(),
                        const Divider(
                          color: constants.BORDER_COLOR,
                          height: 1.50,
                        ),
                        MainSiteFilters(
                          categoriesMappedWithEvents:
                              categoriesMappedWithEvents,
                        ),
                        const Divider(
                          color: constants.BORDER_COLOR,
                          height: 1.50,
                        ),
                        MainSiteEventsWidget(
                          categoriesMappedWithEvents:
                              categoriesMappedWithEvents,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Text(constants.RELOAD_APPLICATION),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
