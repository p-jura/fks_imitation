import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/single_category_cubit/single_category_event_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/loading_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/category_extension_row.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/match_participants.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/match_winner_row.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/narrowed_list_element.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class MainSiteEventsWidget extends StatefulWidget {
  const MainSiteEventsWidget({
    required this.categoriesMappedWithEvents,
    super.key,
  });

  final Map<int, Map<String, dynamic>> categoriesMappedWithEvents;

  @override
  State<MainSiteEventsWidget> createState() => _MainSiteEventsWidgetState();
}

class _MainSiteEventsWidgetState extends State<MainSiteEventsWidget> {
  bool isExpanded = false;
  void expandWidget() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // removes category "WSZYSTKIE" from map of categories
    widget.categoriesMappedWithEvents.remove(0);
    final List<int> categoriesId =
        widget.categoriesMappedWithEvents.keys.toList();

    return BlocBuilder<SingleCategoryEventCubit, SingleCategoryEventState>(
      bloc: injSrv<SingleCategoryEventCubit>(),
      builder: (_, singleCategoryState) {
        // initial cubit state
        if (singleCategoryState is SingleCategoryEventInitial) {
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: categoriesId.length,
              itemBuilder: (_, index) => NarrowedListElement(
                categoriesMappedWithEvents: widget.categoriesMappedWithEvents,
                categoryInex: categoriesId[index],
                isExpanded: isExpanded,
                expandWidgetFunction: expandWidget,
              ),
            ),
          );
        } else if (singleCategoryState is SingleCategoryLoadingState) {
          return const Expanded(
            child: LoadingWidget(),
          );
        } else if (singleCategoryState is SingleCategoryEventsLoadedState) {
          var dataList = singleCategoryState.eventsDataList;
          return Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: categoriesId.length,
              itemBuilder: (_, index) =>
                  singleCategoryState.categoryId == categoriesId[index]
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            NarrowedListElement(
                              categoryInex: categoriesId[index],
                              categoriesMappedWithEvents:
                                  widget.categoriesMappedWithEvents,
                              isExpanded: isExpanded,
                              expandWidgetFunction: expandWidget,
                            ),
                            // winner extension
                            const MatchWinnerRow(),
                            // events category 2 and 3 level
                            CategoriesExtensionRow(
                              dataList: dataList,
                              index: categoriesId[index],
                            ),
                            MachParticipantsExtension(
                              dataList: dataList,
                            ),
                          ],
                        )
                      : NarrowedListElement(
                          categoryInex: categoriesId[index],
                          categoriesMappedWithEvents:
                              widget.categoriesMappedWithEvents,
                          isExpanded: isExpanded,
                          expandWidgetFunction: expandWidget,
                        ),
            ),
          );
        }
        return const Center(
          child: Text(
            constants.RELOAD_APPLICATION,
          ),
        );
      },
    );
  }
}
