import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_state.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/event_strat_time_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/hot_container_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/main_site/events_view_widgets/match_participants.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/loading_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/no_data_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/quick_search_form_field.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/query_site/recomended_view_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
                          Expanded(
                            child: ContentTableWidget(data: data),
                          ),
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
    return ListView(
      children: [
        ...data.quickSearchResponse
            .map(
              (quickSarch) =>
                  ContentWidget(event: quickSarch.qsResponseToEventData()),
            )
            .toList(),
      ],
    );
  }
}

class ContentWidget extends StatelessWidget {
  const ContentWidget({super.key, required this.event});
  final EventData event;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: constants.BORDER_COLOR,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${event.category1Name}  ${DateFormat('dd.MM').format(event.eventStart!)}',
                style:
                    const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 25,
                    height: 12,
                    child: Image.asset(constants.TV_FULL_IMAGE_PATH),
                  ),
                  const HotContainerWidget(),
                ],
              )
            ],
          ),
          EventStartTimeWidget(event: event),
          ParticipantsWithOdds(event: event),
        ],
      ),
    );
  }
}

class ParticipantsWithOdds extends StatelessWidget {
  const ParticipantsWithOdds({super.key, required this.event});
  final EventData event;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 200),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.eventName!.toUpperCase().toString(),
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 7,
                ),
                // Text(
                //   outcomes.last.outcomeName!.toUpperCase().toString(),
                //   style: GoogleFonts.montserrat(
                //     fontSize: 10,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
          ),
          // odds
          // Row(
          //   children: [
          //     OddsWidget(
          //       txt: '1',
          //       color: event > outcomes.last.outcomeOdds
          //           ? constants.DEEP_BACKGROUND_COLOR
          //           : null,
          //       odds: outcomes.first.outcomeOdds.toString(),
          //     ),
          //     const SizedBox(width: 6),
          //     OddsWidget(
          //       txt: '2',
          //       color: outcomes.last.outcomeOdds > outcomes.first.outcomeOdds
          //           ? constants.DEEP_BACKGROUND_COLOR
          //           : null,
          //       odds: outcomes.last.outcomeOdds.toString(),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
