import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/single_category_cubit/single_category_event_cubit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;

class NarrowedListElement extends StatelessWidget {
  const NarrowedListElement({
    required this.categoriesMappedWithEvents,
    required this.categoryInex,
    required Function expandWidgetFunction,
    required bool isExpanded,
    super.key,
  })  : _expandWidget = expandWidgetFunction,
        _isExpanded = isExpanded;

  final Function _expandWidget;
  final bool _isExpanded;
  final Map<int, Map<String, dynamic>> categoriesMappedWithEvents;
  final int categoryInex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        // color: Colors.white,
        border: Border(
          top: BorderSide(
            width: 0.0,
            color: constants.BORDER_COLOR,
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
                  categoriesMappedWithEvents[categoryInex]?['categoryName'],
                  style: GoogleFonts.montserrat(
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
                    color: constants.BORDER_COLOR,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: constants.BORDER_COLOR,
                    ),
                  ),
                  child: Text(
                    categoriesMappedWithEvents[categoryInex]![
                            'categoryEventsCount']
                        .toString(),
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
              // id cant be 0 otherwise it pick wrong file to
              _isExpanded
                  ? BlocProvider.of<SingleCategoryEventCubit>(context)
                      .resetCubitState()
                  : BlocProvider.of<SingleCategoryEventCubit>(context)
                      .getData(categoryInex);
              _expandWidget();
            },
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: constants.BORDER_COLOR,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: _isExpanded
                  ? const Icon(
                      Icons.expand_more,
                      size: 24,
                    )
                  : const Icon(
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
