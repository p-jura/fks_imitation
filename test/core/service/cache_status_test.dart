import 'package:fuksiarz_imitation/core/service/cache_status.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';


const String fTempPath = 'temporaryPath';
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockPathProviderPlatform mockPathProviderPlatform;
  late CacheStatusImpl cacheStatusImpl;

  setUp(() {
    mockPathProviderPlatform = MockPathProviderPlatform();
    cacheStatusImpl =
        CacheStatusImpl(pathProviderPlatform: mockPathProviderPlatform);
  });
  test(
    'MockPathProviderPlatform',
    () async {
      final result = await mockPathProviderPlatform.getTemporaryPath();
      expect(
        result,
        equals(fTempPath),
      );
    },
  );
  group(
    'CacheStatusImpl()',
    () {
      const int tParam = 1;
      const path = '$fTempPath/$tParam.json';
      test(
        'should path should be eqal to provided',
        () async {
          await cacheStatusImpl.isDataStored(tParam);
          final result = cacheStatusImpl.path;
          expect(
            result,
            equals(path),
          );
        },
      );
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
