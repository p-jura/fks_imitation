import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/cubit/single_category_event_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_state.dart';
import 'package:google_fonts/google_fonts.dart';

class MainSiteEventsViewWidget extends StatelessWidget {
  const MainSiteEventsViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<EventsDataBloc, EventsDataBlocState>(
        bloc: injSrv<EventsDataBloc>(),
        builder: (blctx, state) {
          if (state is LoadingState) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AllCategoriesEventsLoadedState) {
            List<Map<String, dynamic>> itemCount =
                state.mappedCatWithEventsCount;
            itemCount.removeAt(0);
            return ListView.builder(
              itemCount: itemCount.length,
              itemBuilder: (context, index) {
                return ExpandedListElement(
                  itemCount: itemCount,
                  index: index,
                );
              },
            );
          } else {
            return const Text(
              'No data found: Check your internet connection and reload application:MainSiteEventsViewWidget',
            );
          }
        },
      ),
    );
  }
}

class ExpandedListElement extends StatelessWidget {
  const ExpandedListElement({
    required this.itemCount,
    required this.index,
    super.key,
  });

  final List<Map<String, dynamic>> itemCount;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleCategoryEventCubit, SingleCategoryEventState>(
      bloc: injSrv<SingleCategoryEventCubit>(),
      builder: (ctx, state) {
        // initial cubit state
        if (state is SingleCategoryEventInitial) {
          return NarrowedListElement(
            itemCount: itemCount,
            index: index,
          );
        }
        if (state is SingleCategoryLoadingState) {
          print(state.toString());
          return const LinearProgressIndicator();
        }
        if (state is SingleCategoryEventsLoadedState) {
          print(state.toString());
          var dataList = state.eventsDataList;
          var cat2Name = dataList.eventData[index].category2Name.toString();
          var cat3Name = dataList.eventData[index].category3Name.toString();
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                NarrowedListElement(
                  index: index,
                  itemCount: itemCount,
                ),
                Container(
                  height: 41,
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: const [
                        SizedBoxWinneExtension(
                          text: 'ZWYCIĘZCA MECZU',
                          width: 130,
                          isActive: true,
                        ),
                        SizedBoxWinneExtension(
                          text: 'ZWYCIĘZCA PIERWSZEJ POŁOWY MECZU',
                          width: 240,
                          isActive: false,
                        ),
                        SizedBoxWinneExtension(
                          text: 'ZWYCIĘZCA TURNIEJU',
                          width: 140,
                          isActive: false,
                        ),
                      ],
                    ),
                  ),
                ),
                // events category 2 and 3 level
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        child: Row(
                          children: [
                            Text(
                              cat2Name,
                              style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              cat3Name,
                              style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.expand_more)
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Text(
          'No data found: Check your internet connection and reload application',
        );
      },
    );
  }
}

class SizedBoxWinneExtension extends StatelessWidget {
  const SizedBoxWinneExtension({
    super.key,
    required this.text,
    required this.width,
    required this.isActive,
  });
  final bool isActive;
  final String text;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: width,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: width,
            child: Divider(
              thickness: 2.0,
              color: isActive
                  ? const Color.fromARGB(255, 156, 179, 202)
                  : Colors.white,
            ),
          ),
        ],
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
        border: Border(
          top: BorderSide(
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
              print(index);
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
