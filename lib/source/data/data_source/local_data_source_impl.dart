import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart'
    as ppi;

import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:fuksiarz_imitation/source/data/data_source/local_data_source.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/core/service/cache_status.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final ppi.PathProviderPlatform _pathProvider;
  final CacheStatus _cacheStatus;

  LocalDataSourceImpl({
    required ppi.PathProviderPlatform pathProvider,
    required CacheStatus cacheStatus,
  })  : _pathProvider = pathProvider,
        _cacheStatus = cacheStatus;

  @override
  Future<bool> cashData({required EventsDataDto data, int? params}) async {
    int category = params ?? 0;
    final bool isDataStored = await _cacheStatus.isDataStored(category);
    if (!isDataStored) {
      final String? tempDir = await _pathProvider.getTemporaryPath();
      if (tempDir != null) {
        log('creating cache file');
        File tempFile = File('$tempDir/$category.json');

        // if tempFile exists clear cache
        if (tempFile.existsSync()) {
          log('cashData');
          clearCacheIfDurationIsOver(
            timeToClearCache: 10,
            cachedFile: tempFile,
          );
        }

        await tempFile.writeAsString(
          json.encode(
            data.toJson(),
          ),
          encoding: utf8,
          flush: true,
          mode: FileMode.append,
        );
        log('file created');
        return true;
      }
      return false;
    }
    log('thers no TemporaryPath');
    return false;
  }

  @override
  Future<EventsDataDto> getLocalData([int? params]) async {
    int category = params ?? 0;

    bool dataExist = await _cacheStatus.isDataStored(category);
    if (dataExist) {
      final String? tempDir = await _pathProvider.getTemporaryPath();
      final File tempFile = File('$tempDir/$category.json');
      if (tempFile.existsSync()) {
        log('getLocalData');
        clearCacheIfDurationIsOver(
          timeToClearCache: 10,
          cachedFile: tempFile,
        );

        final data = await tempFile.readAsString(encoding: utf8);
        return EventsDataDto.fromJson(json.decode(data));
      }
      throw NoDataCached(
        '${constants.GET_LOCAL_FAILED_MESSAGE} $tempDir/$category',
      );
    } else {
      throw NoDataCached(
        '${constants.GET_LOCAL_FAILED_WITH_PARAM_MESSAGE} $category',
      );
    }
  }

  void clearCacheIfDurationIsOver({
    required int timeToClearCache,
    required File cachedFile,
  }) async {
    final durationIsOver =
        DateTime.now().difference(cachedFile.lastModifiedSync()) >
            Duration(minutes: timeToClearCache);
    if (durationIsOver) {
      await cachedFile.delete();
    }
  }
}
