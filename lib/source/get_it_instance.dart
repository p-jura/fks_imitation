import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source_impl.dart';
import 'package:fuksiarz_imitation/source/data/repository/data_repository_impl.dart';
import 'package:fuksiarz_imitation/source/domain/repository/data_repository.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/events_data_bloc.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/cubit/single_category_event_cubit.dart';

final injSrv = GetIt.asNewInstance();

Future<void> setUp() async {
  // External
  injSrv.registerLazySingleton(() => http.Client());
  // Data source
  injSrv.registerLazySingleton<RemoteDataSources>(
    () => RemoteDataSourcesImpl(
      injSrv(),
    ),
  );
  // Repository
  // injSrv.registerLazySingleton<DataFromRemoteRepository>(
  //   () => DataFromRemoteRepositoryImpl(
  //     dataSource: injSrv(),
  //   ),
  // );

  // Services

  injSrv.registerFactory<GetEventsDataFromRemote>(
    () => GetEventsDataFromRemote(
      injSrv(),
    ),
  );

  injSrv.registerFactory<GetQuickSearchDataFromeRemote>(
    () => GetQuickSearchDataFromeRemote(
      injSrv(),
    ),
  );
  // Bloc
  injSrv.registerSingleton<EventsDataBloc>(
    EventsDataBloc(
      getEventsData: injSrv<GetEventsDataFromRemote>(),
      getQuickSearchData: injSrv(),
    ),
  );
  injSrv.registerSingleton<SingleCategoryEventCubit>(
    SingleCategoryEventCubit(
      getEventsData: injSrv<GetEventsDataFromRemote>(),
    ),
  );
}
