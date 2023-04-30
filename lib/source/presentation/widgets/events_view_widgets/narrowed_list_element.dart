import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/cubit/single_category_event_cubit.dart';
import 'package:google_fonts/google_fonts.dart';


class NarrowedListElement extends StatelessWidget {
  const NarrowedListElement({
    required this.itemCount,
    required this.index,
    required Function expandWidgetFunction,
    required bool isExpanded,
    super.key,
  })  : _expandWidget = expandWidgetFunction,
        _isExpanded = isExpanded;

  final Function _expandWidget;
  final bool _isExpanded;
  final List<Map<String, dynamic>> itemCount;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        // color: Colors.white,
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
              _isExpanded
                  ? BlocProvider.of<SingleCategoryEventCubit>(context)
                      .resetCubitState()
                  : BlocProvider.of<SingleCategoryEventCubit>(context)
                      .getData(index);
              _expandWidget();
            },
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 227, 232, 238),
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