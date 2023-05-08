import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/all_categories_cubit/all_categories_events_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class MainSiteFilters extends StatelessWidget {
  const MainSiteFilters({
    required this.categoriesMappedWithEvents,
    super.key,
  });

  final Map categoriesMappedWithEvents;

  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categoriesMappedWithEvents.values
                  .map(
                    (e) => CategoriesFilterElement(
                      catWithEventsCount: e,
                    ),
                  )
                  .toList(),
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
