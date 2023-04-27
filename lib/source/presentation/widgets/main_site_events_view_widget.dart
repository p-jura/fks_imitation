import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/cubit/single_category_event_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_state.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSiteEventsViewWidget extends StatelessWidget {
  const MainSiteEventsViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<EventsDataBloc, EventsDataBlocState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AllCategoriesEventsLoadedState) {
            var allEvents = state.allEventsDataList;
            List<Map<String, dynamic>> itemCount =
                state.mappedCatWithEventsCount;
            itemCount.removeAt(0);
            return ListView.builder(
              itemCount: itemCount.length,
              itemBuilder: (context, index) {
                return ExpandedListElement(
                  itemCount: itemCount,
                  index: index,
                  allEvents: allEvents,
                );
              },
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

class NarrowedListElement extends StatelessWidget {
  const NarrowedListElement({
    required this.itemCount,
    required this.index,
    super.key,
  });

  final List<Map<String, dynamic>> itemCount;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(
            width: 0.0,
            color: Color.fromARGB(255, 227, 232, 238),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            child: Row(
              children: [
                Text(
                  itemCount[index]['categoryName'],
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 227, 232, 238),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color.fromARGB(255, 227, 232, 238),
                    ),
                  ),
                  child: Text(
                    itemCount[index]['categoryEventsCount'].toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              BlocProvider.of<SingleCategoryEventCubit>(context).getData(index);
            },
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 227, 232, 238),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.expand_less,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpandedListElement extends StatelessWidget {
  const ExpandedListElement({
    required this.itemCount,
    required this.index,
    required this.allEvents,
    super.key,
  });

  final List<Map<String, dynamic>> itemCount;
  final int index;
  final List<EventsDataList> allEvents;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: injSrv<SingleCategoryEventCubit>(),
      builder: (context, state) {
        // initial cubit state
        if (state is SingleCategoryEventInitial) {
          return NarrowedListElement(
            itemCount: itemCount,
            index: index,
          );
        }
        if (state is SingleCategoryLoadingState) {
          return const LinearProgressIndicator();
        }
        if (state is SingleCategoryEventsLoadedState) {
          print('newState');
          var dataList = state.eventsDataList;
          return Column(
            children: [
              NarrowedListElement(
                index: index,
                itemCount: itemCount,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      Text(
                        dataList.eventData[index].eventStart.toString(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }
        return const Text(
          'No data found: Check your internet connection and reload application',
        );
      },
    );
  }
}
