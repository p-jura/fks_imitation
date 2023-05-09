import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_cubit/query_data_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/content_table_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/no_data_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/quick_search_form_field.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/recomended_view_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/loading_widget.dart';

class QuerySite extends StatelessWidget {
  QuerySite({super.key});

  static const routName = '/quick_search';

  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _searchDataBase(BuildContext ctx) {
    if (_controller.text.length >= 3) {
      BlocProvider.of<QueryDataCubit>(ctx).getQueryData(_controller.text);
    } else if (_controller.text.length < 3) {
      BlocProvider.of<QueryDataCubit>(ctx).resetData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: constants.DEEP_BACKGROUND_COLOR,
      body: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          // Main part of site
          Flexible(
            flex: 20,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: constants.BACKGROUND_COLOR,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 20,
                ),
                child: BlocBuilder<QueryDataCubit, QueryState>(
                  bloc: injSrv<QueryDataCubit>(),
                  builder: (context, state) {
                    if (state is InitialQueryState) {
                      return Column(
                        children: [
                          Expanded(
                            child: QuickSearchTextFieldWidget(
                              formKey: _formKey,
                              controller: _controller,
                              searchFunction: _searchDataBase,
                            ),
                          ),
                          const Flexible(
                            flex: 2,
                            child: RecomendedViewWidget(),
                          ),
                        ],
                      );
                    } else if (state is LoadingState) {
                      return Column(
                        children: [
                          Expanded(
                            child: QuickSearchTextFieldWidget(
                              formKey: _formKey,
                              controller: _controller,
                              searchFunction: _searchDataBase,
                            ),
                          ),
                          const Flexible(
                            flex: 2,
                            child: LoadingWidget(),
                          ),
                        ],
                      );
                    } else if (state is QueryLoadedState &&
                        state.eventsDataList.eventData.isNotEmpty) {
                      final EventsDataList eventList = state.eventsDataList;
                      return Column(
                        children: [
                          QuickSearchTextFieldWidget(
                            formKey: _formKey,
                            controller: _controller,
                            searchFunction: _searchDataBase,
                          ),
                          Expanded(
                            child: ContentTableWidget(eventList: eventList),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: QuickSearchTextFieldWidget(
                              formKey: _formKey,
                              controller: _controller,
                              searchFunction: _searchDataBase,
                            ),
                          ),
                          const Flexible(
                            flex: 2,
                            child: NoDataWidget(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
