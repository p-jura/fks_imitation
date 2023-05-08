import 'package:fuksiarz_imitation/source/presentation/bloc/query_data_cubit/query_data_cubit.dart';

import 'presentation/bloc/all_categories_cubit/all_categories_events_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source_impl.dart';
import 'package:fuksiarz_imitation/source/data/repository/data_repository_impl.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_remote.dart';
import 'package:fuksiarz_imitation/source/presentation/bloc/single_category_cubit/single_category_event_cubit.dart';
import 'package:fuksiarz_imitation/core/service/cache_status.dart';
import 'package:fuksiarz_imitation/source/data/data_source/local_data_source.dart';
import 'package:fuksiarz_imitation/source/data/data_source/local_data_source_impl.dart';
import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_events_data_from_local.dart';
import 'package:fuksiarz_imitation/source/domain/service/get_quick_search_data_from_remote.dart';

final injSrv = GetIt.asNewInstance();

Future<void> setUp() async {
  // External
  injSrv.registerLazySingleton(() => http.Client());
  injSrv.registerLazySingleton(() => PathProviderPlatform.instance);
  // Cache serviece
  injSrv.registerFactory<CacheStatus>(
    () => CacheStatusImpl(
      pathProviderPlatform: injSrv<PathProviderPlatform>(),
    ),
  );
  // Data source
  injSrv.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(
      cacheStatus: injSrv<CacheStatus>(),
      pathProvider: injSrv<PathProviderPlatform>(),
    ),
  );
  injSrv.registerLazySingleton<RemoteDataSources>(
    () => RemoteDataSourcesImpl(
      injSrv(),
    ),
  );
  // Repository
  injSrv.registerLazySingleton<DataRepositoryImpl>(
    () => DataRepositoryImpl(
      cacheStatus: injSrv<CacheStatus>(),
      localDataSource: injSrv<LocalDataSource>(),
      remoteDataSources: injSrv<RemoteDataSources>(),
    ),
  );

  // Services
  injSrv.registerFactory<GetEventsDataFromLocal>(
    () => GetEventsDataFromLocal(
      injSrv<DataRepositoryImpl>(),
    ),
  );

  injSrv.registerFactory<GetEventsDataFromRemote>(
    () => GetEventsDataFromRemote(
      injSrv<DataRepositoryImpl>(),
    ),
  );

  injSrv.registerFactory<GetQuickSearchDataFromeRemote>(
    () => GetQuickSearchDataFromeRemote(
      injSrv<DataRepositoryImpl>(),
    ),
  );
  // Bloc
  injSrv.registerSingleton<QueryDataCubit>(
    QueryDataCubit(
      getQuickSearchData: injSrv<GetQuickSearchDataFromeRemote>(),
      getEventsDataFromRemote: injSrv<GetEventsDataFromRemote>(),
    ),
  );
  injSrv.registerSingleton<AllCategoriesEventsCubit>(
    AllCategoriesEventsCubit(
      getEventsData: injSrv<GetEventsDataFromRemote>(),
    ),
  );
  injSrv.registerSingleton<SingleCategoryEventCubit>(
    SingleCategoryEventCubit(
      getEventsData: injSrv<GetEventsDataFromRemote>(),
    ),
  );
}
