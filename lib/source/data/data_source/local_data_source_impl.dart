import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:fuksiarz_imitation/core/errors/failure.dart';
import 'package:fuksiarz_imitation/core/service/cache_status.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart'
    as ppi;
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:fuksiarz_imitation/source/data/data_source/local_data_source.dart';

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
        final data = await tempFile.readAsString();
        return EventsDataDto.fromJson(json.decode(data));
      }
      throw NoDataCached(
        'getLocalData failed: no file found in directory $tempDir/$category',
      );
    } else {
      throw NoDataCached(
        'getLocalData failed: no file with givent param $category',
      );
    }
  }
}
