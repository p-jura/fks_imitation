import 'dart:developer';
import 'dart:io';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

abstract class CacheStatus {
  Future<bool> isDataStored([int? param]);
}

class CacheStatusImpl implements CacheStatus {
  final PathProviderPlatform _pathProviderPlatform;

  CacheStatusImpl({required pathProviderPlatform})
      : _pathProviderPlatform = pathProviderPlatform;

  // for tests purpus
  String _path = 'no path yet';

  String get path => _path;

  @override
  Future<bool> isDataStored([int? param]) async {
    final path = await _pathProviderPlatform.getTemporaryPath();
    if (path != null) {
      final String filePath = '$path/$param.json';
      _path = filePath;
      return await File(filePath).exists();
    } else {
      log('path not exists');
      return false;
    }
  }
}
