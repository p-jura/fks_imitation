import 'dart:io';

String readFixture(String name, [String? catalog]) => catalog != null
    ? File('test/fixtures/$catalog/$name').readAsStringSync()
    : File('test/fixtures/$name').readAsStringSync();
