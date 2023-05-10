import 'dart:developer';
import 'dart:io';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart'
    as ppi;

abstract class CacheLifeCicle {
  Future<bool> shouldOverrideData(int? params);
  Future<bool> clearCache(String? category);
}

class CacheLifeCicleImpl implements CacheLifeCicle {
  final ppi.PathProviderPlatform pathProvider;

  CacheLifeCicleImpl(this.pathProvider);

  @override
  Future<bool> clearCache(String? category) async {
    final path = await pathProvider.getTemporaryPath();
    File file = File('$path/$category.json');

    if (file.existsSync()) {
      file.delete();
      return true;
    }
    return false;
  }

  @override
  Future<bool> shouldOverrideData(int? params) async {
    final path = await pathProvider.getTemporaryPath();
    File file = File('$path/$params.json');

    if (file.existsSync() &&
        file.lastModifiedSync().difference(DateTime.now()).inMinutes < -5) {
      log('Override data - duration of file ${file.lastModifiedSync().difference(DateTime.now()).inMinutes}');

      return true;
    }
    return false;
  }
}
