import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart'
    as ppi;

import 'package:fuksiarz_imitation/core/fixtures/fixtures.dart' as constants;
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:fuksiarz_imitation/source/data/data_source/local_data_source.dart';
import 'package:fuksiarz_imitation/core/errors/failure.dart';

class LocalDataSourceImpl implements LocalDataSource {
  final ppi.PathProviderPlatform _pathProvider;

  LocalDataSourceImpl({
    required ppi.PathProviderPlatform pathProvider,
  }) : _pathProvider = pathProvider;

  @override
  Future<bool> cashData({required EventsDataDto data, int? params}) async {
    int category = params ?? 0;
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
      return true;
    } else {}
    return false;
  }

  @override
  Future<EventsDataDto> getLocalData([int? params]) async {
    int category = params ?? 0;

    final String? tempDir = await _pathProvider.getTemporaryPath();
    final File tempFile = File('$tempDir/$category.json');
    if (tempFile.existsSync()) {
      final data = await tempFile.readAsString(encoding: utf8);
      return EventsDataDto.fromJson(json.decode(data));
    }
    throw NoDataCached(
      '${constants.GET_LOCAL_FAILED_MESSAGE} $tempDir/$category',
    );
  }
}
