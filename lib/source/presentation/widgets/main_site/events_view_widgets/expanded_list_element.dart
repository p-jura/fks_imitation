import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/single_category_cubit/single_category_event_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/category_extension_row.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/match_participants.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/match_winner_row.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/narrowed_list_element.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class ExpandedListElement extends StatefulWidget {
  const ExpandedListElement({
    required this.categoriesMappedWithEvents,
    required this.categories,
    super.key,
  });

  final Map<int, Map<String, dynamic>> categoriesMappedWithEvents;
  final int categories;

  @override
  State<ExpandedListElement> createState() => _ExpandedListElementState();
}

class _ExpandedListElementState extends State<ExpandedListElement> {
  bool isExpanded = false;
  void expandWidget() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleCategoryEventCubit, SingleCategoryEventState>(
      bloc: injSrv<SingleCategoryEventCubit>(),
      builder: (_, singleCategoryState) {
        // initial cubit state
        if (singleCategoryState is SingleCategoryEventInitial) {
          if (widget.categoriesMappedWithEvents[widget.categories] != null) {
            return NarrowedListElement(
              categoriesMappedWithEvents: widget.categoriesMappedWithEvents,
              categoryInex: widget.categories,
              isExpanded: isExpanded,
              expandWidgetFunction: expandWidget,
            );
          }
        } else if (singleCategoryState is SingleCategoryLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (singleCategoryState is SingleCategoryEventsLoadedState) {
          var dataList = singleCategoryState.eventsDataList;
          return singleCategoryState.categoryId == widget.categories
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NarrowedListElement(
                      categoryInex: widget.categories,
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
                      index: widget.categories,
                    ),
                    MachParticipantsExtension(
                      dataList: dataList,
                    ),
                  ],
                )
              : NarrowedListElement(
                  categoryInex: widget.categories,
                  categoriesMappedWithEvents: widget.categoriesMappedWithEvents,
                  isExpanded: isExpanded,
                  expandWidgetFunction: expandWidget,
                );
        }
        return const Center(
          child:  Text(
            constants.RELOAD_APPLICATION,
          ),
        );
      },
    );
  }
}
