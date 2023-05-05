import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_state.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class MainSiteFilters extends StatelessWidget {
  const MainSiteFilters({super.key});

  @override
  Widget build(BuildContext context) {
    // categoires ammount lisetd in assignment
    BlocProvider.of<EventsDataBloc>(context)
        .add(GetAllCategoriesEventsData(12));
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            height: 24,
            width: 24,
            child: Image.asset('assets/images/icons/filter.png'),
          ),
          Expanded(
            child: BlocBuilder<EventsDataBloc, EventsDataBlocState>(
              builder: (ctx, state) {
                // circular progres indicator
                if (state is LoadingState) {
                  return const LinearProgressIndicator();
                  // loaded data
                } else if (state is AllCategoriesEventsLoadedState) {
                  final Map<int, Map<String, dynamic>>
                      filterCategoriesWithEvents = state.categoriesWithEvents;
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: filterCategoriesWithEvents.values
                        .map(
                          (e) => CategoriesFilterElement(
                            catWithEventsCount: e,
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return const Text(
                    'No data found: Check your internet connection and reload application',
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesFilterElement extends StatelessWidget {
  final Map<String, dynamic> catWithEventsCount;

  const CategoriesFilterElement({
    required this.catWithEventsCount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: catWithEventsCount['isActive'] != null
              ? constants.ACTIVE_COMPONENT_COLOR
              : constants.BACKGROUND_COLOR,
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(255, 227, 232, 238),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(
              30,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 5),
                child: Text(
                  catWithEventsCount['categoryName'],
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Text(
                '${catWithEventsCount['categoryEventsCount']}',
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
