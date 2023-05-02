import 'package:bloc/bloc.dart';
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_event.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_state.dart';

class QueryDataBloc extends Bloc<QueryDataEvent, QueryState> {
  final GetQuickSearchDataFromeRemote getQuickSearchData;

  QueryDataBloc({
    required this.getQuickSearchData,
  }) : super(InitialQueryState()) {
    on<GetQueryFromRemote>(_getQueryData);
  }
  void _getQueryData(
    GetQueryFromRemote event,
    Emitter<QueryState> emit,
  ) async {
    emit(LoadingState());
    final queryEitherResponse = await getQuickSearchData.call(event.query);
    queryEitherResponse.fold(
      (failure) {
        failure.mapFailuresToLog();
        emit(
          QueryLoadedState(
            qickSearchEventList: const QuickSearchResponseList(
              quickSearchResponse: [],
            ),
          ),
        );
      },
      (quickSearchResponseList) => emit(
        QueryLoadedState(
          qickSearchEventList: quickSearchResponseList,
        ),
      ),
    );
  }
}
