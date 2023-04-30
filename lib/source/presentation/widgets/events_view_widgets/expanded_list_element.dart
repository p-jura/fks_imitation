import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/cubit/single_category_event_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/events_view_widgets/category_extension_row.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/events_view_widgets/match_winner_row.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/events_view_widgets/narrowed_list_element.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ExpandedListElement extends StatefulWidget {
  const ExpandedListElement({
    required this.itemCount,
    required this.index,
    super.key,
  });

  final List<Map<String, dynamic>> itemCount;
  final int index;

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
    return Container(
      color: Colors.white,
      child: BlocBuilder<SingleCategoryEventCubit, SingleCategoryEventState>(
        bloc: injSrv<SingleCategoryEventCubit>(),
        builder: (ctx, state) {
          // initial cubit state
          if (state is SingleCategoryEventInitial) {
            return NarrowedListElement(
              itemCount: widget.itemCount,
              index: widget.index,
              isExpanded: isExpanded,
              expandWidgetFunction: expandWidget,
            );
          }
          if (state is SingleCategoryLoadingState) {
            return Container();
          }
          if (state is SingleCategoryEventsLoadedState) {
            var dataList = state.eventsDataList;
            var stateCatId = state.categoryId;
            return stateCatId == widget.index
                ? Column(
                    children: [
                      NarrowedListElement(
                        index: widget.index,
                        itemCount: widget.itemCount,
                        isExpanded: isExpanded,
                        expandWidgetFunction: expandWidget,
                      ),
                      // winner extension
                      const MatchWinnerRow(),
                      // events category 2 and 3 level
                      CategoriesExtensionRow(
                        dataList: dataList,
                        index: widget.index,
                      ),
                      MachParticipantsExtension(
                        dataList: dataList,
                        index: widget.index,
                      ),
                    ],
                  )
                : NarrowedListElement(
                    index: widget.index,
                    itemCount: widget.itemCount,
                    isExpanded: isExpanded,
                    expandWidgetFunction: expandWidget,
                  );
          }
          return const Text(
            'No data found: Check your internet connection and reload application',
          );
        },
      ),
    );
  }
}

class MachParticipantsExtension extends StatelessWidget {
  const MachParticipantsExtension(
      {super.key, required this.dataList, required this.index});
  final EventsDataList dataList;
  final int index;

  @override
  Widget build(BuildContext context) {
    var event = dataList.eventData[index];
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 227, 232, 238),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${event.category3Name} ${DateFormat('MM.dd').format(event.eventStart!)}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
