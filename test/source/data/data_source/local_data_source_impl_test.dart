import 'dart:io';

import 'package:fuksiarz_imitation/source/data/data_source/local_data_source_impl.dart';
import 'package:fuksiarz_imitation/source/data/models.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

const String fTempPath = 'test/fixtures';
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late MockPathProviderPlatform mockPathProviderPlatform;
  late LocalDataSourceImpl localDataSourceImpl;

  const tParam = 1;
  const tEventDataDto = EventsDataDto(code: 200, description: 'OK.', data: []);

  setUp(() {
    mockPathProviderPlatform = MockPathProviderPlatform();

    localDataSourceImpl = LocalDataSourceImpl(
      pathProvider: mockPathProviderPlatform,
    );
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
    'local data source implementation cacheData()',
    () {
      File tFile = File('$fTempPath/1.json');
      setUp(
        () {
          if (tFile.existsSync()) {
            tFile.deleteSync();
          }
        },
      );
      test(
        'Should return true if temporary directory exists and file was created',
        () async {
          final result = await localDataSourceImpl.cashData(
            data: tEventDataDto,
            params: tParam,
          );
          expect(result, true);
        },
      );
    },
  );
  group(
    'local data source implementation getLocalData()',
    () {
      test(
        'Should return EventsDataDto when file exists',
        () async {
          final result = await localDataSourceImpl.getLocalData(tParam);

          expect(result, equals(tEventDataDto));
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
