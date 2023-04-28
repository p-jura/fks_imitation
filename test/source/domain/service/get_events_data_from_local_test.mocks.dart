// Mocks generated by Mockito 5.4.0 from annotations
// in fuksiarz_imitation/test/source/domain/service/get_events_data_from_local_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:dartz/dartz.dart' as _i2;
import 'package:fuksiarz_imitation/core/errors/failure.dart' as _i5;
import 'package:fuksiarz_imitation/source/domain/entities_lists.dart' as _i6;
import 'package:fuksiarz_imitation/source/domain/repository/data_repository.dart'
    as _i3;
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

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DataRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDataFromLocalRepo extends _i1.Mock implements _i3.DataRepository {
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.EventsDataList>>
      getEventsDataFromRemote([int? params]) => (super.noSuchMethod(
            Invocation.method(
              #getEventsDataFromRemote,
              [params],
            ),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i6.EventsDataList>>.value(
                    _FakeEither_0<_i5.Failure, _i6.EventsDataList>(
              this,
              Invocation.method(
                #getEventsDataFromRemote,
                [params],
              ),
            )),
            returnValueForMissingStub:
                _i4.Future<_i2.Either<_i5.Failure, _i6.EventsDataList>>.value(
                    _FakeEither_0<_i5.Failure, _i6.EventsDataList>(
              this,
              Invocation.method(
                #getEventsDataFromRemote,
                [params],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, _i6.EventsDataList>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.QuickSearchResponseList>>
      getQuickSearchDataFromeRemote(String? params) => (super.noSuchMethod(
            Invocation.method(
              #getQuickSearchDataFromeRemote,
              [params],
            ),
            returnValue: _i4.Future<
                    _i2.Either<_i5.Failure, _i6.QuickSearchResponseList>>.value(
                _FakeEither_0<_i5.Failure, _i6.QuickSearchResponseList>(
              this,
              Invocation.method(
                #getQuickSearchDataFromeRemote,
                [params],
              ),
            )),
            returnValueForMissingStub: _i4.Future<
                    _i2.Either<_i5.Failure, _i6.QuickSearchResponseList>>.value(
                _FakeEither_0<_i5.Failure, _i6.QuickSearchResponseList>(
              this,
              Invocation.method(
                #getQuickSearchDataFromeRemote,
                [params],
              ),
            )),
          ) as _i4
              .Future<_i2.Either<_i5.Failure, _i6.QuickSearchResponseList>>);
  @override
  _i4.Future<_i2.Either<_i5.Failure, _i6.EventsDataList>>
      getEventsDataFromLocal([int? params]) => (super.noSuchMethod(
            Invocation.method(
              #getEventsDataFromLocal,
              [params],
            ),
            returnValue:
                _i4.Future<_i2.Either<_i5.Failure, _i6.EventsDataList>>.value(
                    _FakeEither_0<_i5.Failure, _i6.EventsDataList>(
              this,
              Invocation.method(
                #getEventsDataFromLocal,
                [params],
              ),
            )),
            returnValueForMissingStub:
                _i4.Future<_i2.Either<_i5.Failure, _i6.EventsDataList>>.value(
                    _FakeEither_0<_i5.Failure, _i6.EventsDataList>(
              this,
              Invocation.method(
                #getEventsDataFromLocal,
                [params],
              ),
            )),
          ) as _i4.Future<_i2.Either<_i5.Failure, _i6.EventsDataList>>);
}
