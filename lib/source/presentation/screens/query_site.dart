import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/single_entities.dart';
import 'package:fuksiarz_imitation/source/get_it_instance.dart';

import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_cubit/query_data_cubit.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/event_strat_time_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/hot_container_widget.dart';
import 'package:fuksiarz_imitation/source/presentation/widgets/odds_widget.dart';
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

class ContentTableWidget extends StatelessWidget {
  const ContentTableWidget({
    super.key,
    required this.eventList,
  });

  final EventsDataList eventList;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ...eventList.eventData
            .map(
              (event) => ContentWidget(
                event: event,
              ),
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
                '${event.category3Name}  ${DateFormat('dd.MM').format(event.eventStart!)}',
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
    var counter = -1;
    final List<dynamic> oddsType = [1, 'X', 2];

    final outcomes = event.eventGames.first.outcomes;
    var highOdd = 0.0;
    outcomes?.forEach(
      (element) {
        element.outcomeOdds > highOdd ? highOdd = element.outcomeOdds : null;
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 200),
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                outcomes!.first.outcomeName!.toUpperCase().toString(),
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
              Text(
                outcomes.last.outcomeName!.toUpperCase().toString(),
                style: GoogleFonts.montserrat(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // odds
        Row(
          children: [
            ...outcomes.map(
              (outcom) {
                counter = counter + 1;
                return Container(
                  margin: const EdgeInsets.only(left: 6),
                  child: OddsWidget(
                    txt: outcomes.length>2? oddsType[counter].toString(): counter.toString(),
                    color: outcom.outcomeOdds == highOdd
                        ? constants.DEEP_BACKGROUND_COLOR
                        : null,
                    odds: outcomes[counter].outcomeOdds.toString(),
                  ),
                );
              },
            ),
          ],
        )
      ],
    );
  }
}
