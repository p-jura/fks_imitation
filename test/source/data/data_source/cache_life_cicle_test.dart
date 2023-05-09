import 'dart:io';

import 'package:fuksiarz_imitation/source/data/data_source/cache_life_cicle.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

const String fTempPath = 'test/fixtures';
void main() {
  late CacheLifeCicleImpl tCacheLifeCicleImpl;
  late MockPathProviderPlatform mockPathProvider;
  const String tCategory = '2';
  File file;
  setUp(() {
    mockPathProvider = MockPathProviderPlatform();
    tCacheLifeCicleImpl = CacheLifeCicleImpl(mockPathProvider);
  });
  test(
    'Should return true if file exists and delete it',
    () async {
      // create file
      file =
          File('${await mockPathProvider.getTemporaryPath()}/$tCategory.json');
      await file.writeAsString('contents');
      // act
      final result = await tCacheLifeCicleImpl.clearCache(tCategory);
      // result
      expect(result, true);
    },
  );
  test(
    'Should return false if file lastModification time is shorter than 5 min',
    () async {
      // create file
      file =
          File('${await mockPathProvider.getTemporaryPath()}/$tCategory.json');
      await file.writeAsString('contents');

      // act
      final result =
          await tCacheLifeCicleImpl.shouldOverrideData(int.parse(tCategory));
      expect(result, false);
    },
  );
}

class MockPathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return fTempPath;
  }
}
