import 'package:flutter/material.dart';

import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/expanded_list_element.dart';

class MainSiteEventsViewWidget extends StatelessWidget {
  const MainSiteEventsViewWidget({
    required this.categoriesMappedWithEvents,
    super.key,
  });
  final Map<int, Map<String, dynamic>> categoriesMappedWithEvents;
  @override
  Widget build(BuildContext context) {
    categoriesMappedWithEvents.remove(0);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: categoriesMappedWithEvents.length,
        itemBuilder: (_, index) {
          return ExpandedListElement(
            categoriesMappedWithEvents: categoriesMappedWithEvents,
            categories: categoriesMappedWithEvents.keys.toList()[index],
          );
        },
      ),
    );
  }
}
