// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/all_categories_cubit/all_categories_events_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/single_category_cubit/single_category_event_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class MainSiteFilters extends StatefulWidget {
  const MainSiteFilters({
    required this.categoriesMappedWithEvents,
    super.key,
  });

  final Map categoriesMappedWithEvents;

  @override
  State<MainSiteFilters> createState() => _MainSiteFiltersState();
}

class _MainSiteFiltersState extends State<MainSiteFilters> {
  void setCategory(int categoryId) {
    setState(() {
      //
      // gets data and sets state for filters
      if (categoryId != 0) {
        widget.categoriesMappedWithEvents[categoryId]['isActive'] =
            !widget.categoriesMappedWithEvents[categoryId]['isActive'];
        BlocProvider.of<SingleCategoryEventCubit>(context).getData(categoryId);
        widget.categoriesMappedWithEvents[0]['isActive'] = false;
      } else {
        widget.categoriesMappedWithEvents.forEach((key, value) {
          value['isActive'] = false;
        });
        widget.categoriesMappedWithEvents[0]['isActive'] = true;
        BlocProvider.of<SingleCategoryEventCubit>(context).getData(categoryId);
      }
    });
  }

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
            child: Image.asset(constants.FILTER_ICON_IMAGE_PATH),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.categoriesMappedWithEvents.length,
              itemBuilder: (context, index) {
                final List categoriesId =
                    widget.categoriesMappedWithEvents.keys.toList();
                final List catNamesWithEventsCount =
                    widget.categoriesMappedWithEvents.values.toList();

                return CategoriesFilterElement(
                  catNameWithEventCount: catNamesWithEventsCount[index],
                  categoryId: categoriesId[index],
                  setCategory: setCategory,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CategoriesFilterElement extends StatelessWidget {
  final int categoryId;
  final Map<String, dynamic> catNameWithEventCount;
  final Function setCategory;
  const CategoriesFilterElement({
    required this.catNameWithEventCount,
    super.key,
    required this.categoryId,
    required this.setCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {
          setCategory(categoryId);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: catNameWithEventCount['isActive'] == true
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
                    catNameWithEventCount['categoryName'],
                    style: GoogleFonts.montserrat(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  '${catNameWithEventCount['categoryEventsCount']}',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
