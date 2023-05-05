import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_state.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/loading_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/no_data_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/quick_search_form_field.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/recomended_view_widget.dart';

class QuerySite extends StatelessWidget {
  QuerySite({super.key});

  static const routName = '/quick_search';

  final TextEditingController _controller = TextEditingController();

  void _searchDataBase(BuildContext ctx) {
    if (_controller.text.length >= 3) {
      BlocProvider.of<QueryDataBloc>(ctx).add(
        GetQueryFromRemote(query: _controller.text),
      );
    } else if (_controller.text.length < 3) {
      BlocProvider.of<QueryDataBloc>(ctx).add(
        ResetQuery(),
      );
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
                child: BlocBuilder<QueryDataBloc, QueryState>(
                  bloc: injSrv<QueryDataBloc>(),
                  builder: (context, state) {
                    if (state is InitialQueryState) {
                      return Column(
                        children: [
                          Expanded(
                            child: QuickSearchTextFieldWidget(
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
                        state.qickSearchEventList.quickSearchResponse
                            .isNotEmpty) {
                      var data = state.qickSearchEventList;
                      return Column(
                        children: [
                          QuickSearchTextFieldWidget(
                            controller: _controller,
                            searchFunction: _searchDataBase,
                          ),
                          const SizedBox(height: 30),
                          ContentTableWidget(data: data),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          Expanded(
                            child: QuickSearchTextFieldWidget(
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

class ContentTableWidget extends StatelessWidget {
  const ContentTableWidget({super.key, required this.data});
  final QuickSearchResponseList data;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      height: 80,
      width: 80,
      child: Column(
        children: [Text(data.quickSearchResponse.length.toString())],
      ),
    );
  }
}
