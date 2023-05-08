import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/all_categories_cubit/all_categories_events_cubit_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/expanded_list_element.dart';

class MainSiteEventsViewWidget extends StatelessWidget {
  const MainSiteEventsViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AllCategoriesEventsCubit, AllCategoriesEventsState>(
        bloc: injSrv<AllCategoriesEventsCubit>(),
        builder: (blctx, state) {
          if (state is AllCategoriesEventsLoading) {
            return const Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is AllCategoriesEventsLoadedState) {
            Map<int, Map<String, dynamic>> categoriesMappedWithEvents =
                state.categoriesWithEvents;
            categoriesMappedWithEvents.remove(0);
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: categoriesMappedWithEvents.length,
              itemBuilder: (context, index) {
                return ExpandedListElement(
                  categoriesMappedWithEvents: categoriesMappedWithEvents,
                  categories: categoriesMappedWithEvents.keys.toList()[index],
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'No data found: Reload application',
              ),
            );
          }
        },
      ),
    );
  }
}
