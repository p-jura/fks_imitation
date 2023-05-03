import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc_state.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/expanded_list_element.dart';

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
            return const Text(
              'No data found: Check your internet connection and reload application:MainSiteEventsViewWidget',
            );
          }
        },
      ),
    );
  }
}
