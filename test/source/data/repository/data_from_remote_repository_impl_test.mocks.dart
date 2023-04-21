// Mocks generated by Mockito 5.4.0 from annotations
// in fuksiarz_imitation/test/source/data/repository/data_from_remote_repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:fuksiarz_imitation/source/data/data_source/remote_data_source.dart'
    as _i3;
import 'package:fuksiarz_imitation/source/data/models.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEventsDataDto_0 extends _i1.SmartFake implements _i2.EventsDataDto {
  _FakeEventsDataDto_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [RemoteDataSources].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteDataSources extends _i1.Mock implements _i3.RemoteDataSources {
  @override
  _i4.Future<_i2.EventsDataDto> getListOfEventsData() => (super.noSuchMethod(
        Invocation.method(
          #getListOfEventsData,
          [],
        ),
        returnValue: _i4.Future<_i2.EventsDataDto>.value(_FakeEventsDataDto_0(
          this,
          Invocation.method(
            #getListOfEventsData,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i4.Future<_i2.EventsDataDto>.value(_FakeEventsDataDto_0(
          this,
          Invocation.method(
            #getListOfEventsData,
            [],
          ),
        )),
      ) as _i4.Future<_i2.EventsDataDto>);
}
