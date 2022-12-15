// Mocks generated by Mockito 5.0.17 from annotations
// in series/test/helpers/bloc_test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as i5;

import 'package:core/utils/failure.dart' as i6;
import 'package:series/domain/entities/series.dart' as i9;
import 'package:series/domain/entities/series_detail.dart' as i7;
import 'package:series/domain/repositories/series_repository.dart' as i2;
import 'package:series/domain/usecases/get_series_detail.dart' as i4;
import 'package:series/domain/usecases/get_series_recommendations.dart' as i8;
import 'package:series/domain/usecases/get_now_playing_series.dart' as i10;
import 'package:series/domain/usecases/get_popular_series.dart' as i11;
import 'package:series/domain/usecases/get_top_rated_series.dart' as i12;
import 'package:series/domain/usecases/get_watchlist_series.dart' as i14;
import 'package:series/domain/usecases/get_watchlist_series_status.dart' as i13;
import 'package:series/domain/usecases/remove_watchlist_series.dart' as i16;
import 'package:series/domain/usecases/save_watchlist_series.dart' as i15;
import 'package:dartz/dartz.dart' as i3;
import 'package:mockito/mockito.dart' as i1;
import 'package:series/domain/entities/series.dart' as i7;
import 'package:series/domain/usecases/search_series.dart' as i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeSeriesRepository extends i1.Fake implements i2.SeriesRepository {}

class _FakeEither<L, R> extends i1.Fake implements i3.Either<L, R> {}

/// A class which mocks [GetSeriesDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesDetail extends i1.Mock implements i4.GetSeriesDetail {
  MockGetSeriesDetail() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<i3.Either<i6.Failure, i7.SeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<i3.Either<i6.Failure, i7.SeriesDetail>>.value(
                  _FakeEither<i6.Failure, i7.SeriesDetail>()))
          as i5.Future<i3.Either<i6.Failure, i7.SeriesDetail>>);
}

/// A class which mocks [GetSeriesRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetSeriesRecommendations extends i1.Mock
    implements i8.GetSeriesRecommendations {
  MockGetSeriesRecommendations() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Series>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Series>>>.value(
                  _FakeEither<i6.Failure, List<i9.Series>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Series>>>);
}

/// A class which mocks [GetNowPlayingSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingSeries extends i1.Mock
    implements i10.GetNowPlayingSeries {
  MockGetNowPlayingSeries() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Series>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Series>>>.value(
                  _FakeEither<i6.Failure, List<i9.Series>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Series>>>);
}

/// A class which mocks [GetPopularSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularSeries extends i1.Mock implements i11.GetPopularSeries {
  MockGetPopularSeries() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Series>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Series>>>.value(
                  _FakeEither<i6.Failure, List<i9.Series>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Series>>>);
}

/// A class which mocks [GetTopRatedSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedSeries extends i1.Mock implements i12.GetTopRatedSeries {
  MockGetTopRatedSeries() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Series>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Series>>>.value(
                  _FakeEither<i6.Failure, List<i9.Series>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Series>>>);
}

/// A class which mocks [GetWatchListStatusSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusSeries extends i1.Mock
    implements i13.GetWatchListSeriesStatus {
  MockGetWatchListStatusSeries() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as i5.Future<bool>);
}

/// A class which mocks [GetWatchlistSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistSeries extends i1.Mock implements i14.GetWatchlistSeries {
  MockGetWatchlistSeries() {
    i1.throwOnMissingStub(this);
  }

  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Series>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Series>>>.value(
                  _FakeEither<i6.Failure, List<i9.Series>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Series>>>);
}

/// A class which mocks [SaveWatchlistSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistSeries extends i1.Mock
    implements i15.SaveWatchlistSeries {
  MockSaveWatchlistSeries() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<i3.Either<i6.Failure, String>> execute(i7.SeriesDetail? Series) =>
      (super.noSuchMethod(Invocation.method(#execute, [Series]),
              returnValue: Future<i3.Either<i6.Failure, String>>.value(
                  _FakeEither<i6.Failure, String>()))
          as i5.Future<i3.Either<i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistSeries extends i1.Mock
    implements i16.RemoveWatchlistSeries {
  MockRemoveWatchlistSeries() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<i3.Either<i6.Failure, String>> execute(i7.SeriesDetail? Series) =>
      (super.noSuchMethod(Invocation.method(#execute, [Series]),
              returnValue: Future<i3.Either<i6.Failure, String>>.value(
                  _FakeEither<i6.Failure, String>()))
          as i5.Future<i3.Either<i6.Failure, String>>);
}

/// A class which mocks [SearchSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchSeries extends i1.Mock implements i4.SearchSeries {
  MockSearchSeries() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.SeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeSeriesRepository()) as i2.SeriesRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i7.Series>>> execute(String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
              returnValue: Future<i3.Either<i6.Failure, List<i7.Series>>>.value(
                  _FakeEither<i6.Failure, List<i7.Series>>()))
          as i5.Future<i3.Either<i6.Failure, List<i7.Series>>>);
}
