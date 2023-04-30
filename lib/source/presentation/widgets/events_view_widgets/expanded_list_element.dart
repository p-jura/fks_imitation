import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/cubit/single_category_event_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/events_view_widgets/category_extension_row.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/events_view_widgets/match_winner_row.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/events_view_widgets/narrowed_list_element.dart';
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
                    mainAxisSize: MainAxisSize.min,
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
  MachParticipantsExtension(
      {super.key, required this.dataList, required this.index});
  final EventsDataList dataList;
  final int index;

  final List<String> _opponents = [];

  void disassembleOponents() {
    // creates _opponents List from String eventName
    var oponents = dataList.eventData[index].eventName;
    if (oponents != null) {
      var paternIndex = oponents.indexOf('-');
      _opponents.add(
        oponents.substring(0, paternIndex).trim().toUpperCase(),
      );
      _opponents.add(oponents
          .substring(paternIndex + 1, oponents.length)
          .trim()
          .toUpperCase());
    }
  }

  @override
  Widget build(BuildContext context) {
    disassembleOponents();
    var event = dataList.eventData[index];
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: event.eventGames.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: SizedBox(
          height: 106,
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                          '${event.category3Name?.toUpperCase()} ${DateFormat('dd.MM').format(event.eventStart!)}',
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // event, date and HOT icon
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 6),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 198, 40, 40),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset(
                                'assets/images/icons/hot.png',
                                fit: BoxFit.fitHeight,
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                'HOT',
                                style: TextStyle(
                                    fontSize: 6,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // event progress bar
                    Row(
                      children: [
                        Text(
                          DateFormat('H:mm').format(event.eventStart!),
                          style: const TextStyle(
                              fontSize: 8, fontWeight: FontWeight.w600),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color.fromARGB(255, 227, 232, 238),
                            indent: 10,
                            endIndent: 10,
                            thickness: 1,
                          ),
                        ),
                        Text(
                          '+ ${event.eventStart!.difference(DateTime.now()).inHours}',
                          style: const TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 198, 40, 40),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // event opponents
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _opponents.first,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              Text(
                                _opponents.last,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // odds
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 227, 232, 238),
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                '1',
                                style: TextStyle(
                                    fontSize: 8, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                event.eventGames.first.outcomes!.first
                                    .outcomeName!
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
