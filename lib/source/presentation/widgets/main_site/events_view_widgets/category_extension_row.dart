import 'package:flutter/material.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesExtensionRow extends StatelessWidget {
  const CategoriesExtensionRow({
    super.key,
    required this.dataList,
    required this.index,
  });
  final EventsDataList dataList;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  dataList.eventData[index].category2Name
                      .toString()
                      .toUpperCase(),
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
                  dataList.eventData[index].category3Name
                      .toString()
                      .toUpperCase(),
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 3.0),
            child: Icon(Icons.expand_more),
          )
        ],
      ),
    );
  }
}
