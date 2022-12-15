// Mocks generated by Mockito 5.0.17 from annotations
// in movies/test/helpers/bloc_test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as i5;

import 'package:core/utils/failure.dart' as i6;
import 'package:movies/domain/entities/movie.dart' as i9;
import 'package:movies/domain/entities/movie_detail.dart' as i7;
import 'package:movies/domain/repositories/movie_repository.dart' as i2;
import 'package:movies/domain/usecases/get_movie_detail.dart' as i4;
import 'package:movies/domain/usecases/get_movie_recommendations.dart' as i8;
import 'package:movies/domain/usecases/get_now_playing_movies.dart' as i10;
import 'package:movies/domain/usecases/get_popular_movies.dart' as i11;
import 'package:movies/domain/usecases/get_top_rated_movies.dart' as i12;
import 'package:movies/domain/usecases/get_watchlist_movies.dart' as i14;
import 'package:movies/domain/usecases/get_watchlist_status.dart' as i13;
import 'package:movies/domain/usecases/remove_watchlist.dart' as i16;
import 'package:movies/domain/usecases/save_watchlist.dart' as i15;
import 'package:dartz/dartz.dart' as i3;
import 'package:mockito/mockito.dart' as i1;
import 'package:movies/domain/entities/movie.dart' as i7;
import 'package:movies/domain/usecases/search_movies.dart' as i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository extends i1.Fake implements i2.MovieRepository {}

class _FakeEither<L, R> extends i1.Fake implements i3.Either<L, R> {}

/// A class which mocks [GetMovieDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieDetail extends i1.Mock implements i4.GetMovieDetail {
  MockGetMovieDetail() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, i7.MovieDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<i3.Either<i6.Failure, i7.MovieDetail>>.value(
                  _FakeEither<i6.Failure, i7.MovieDetail>()))
          as i5.Future<i3.Either<i6.Failure, i7.MovieDetail>>);
}

/// A class which mocks [GetMovieRecommendations].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetMovieRecommendations extends i1.Mock
    implements i8.GetMovieRecommendations {
  MockGetMovieRecommendations() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Movie>>> execute(dynamic id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Movie>>>.value(
                  _FakeEither<i6.Failure, List<i9.Movie>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Movie>>>);
}

/// A class which mocks [GetNowPlayingMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetNowPlayingMovies extends i1.Mock
    implements i10.GetNowPlayingMovies {
  MockGetNowPlayingMovies() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Movie>>>.value(
                  _FakeEither<i6.Failure, List<i9.Movie>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Movie>>>);
}

/// A class which mocks [GetPopularMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularMovies extends i1.Mock implements i11.GetPopularMovies {
  MockGetPopularMovies() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Movie>>>.value(
                  _FakeEither<i6.Failure, List<i9.Movie>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Movie>>>);
}

/// A class which mocks [GetTopRatedMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedMovies extends i1.Mock implements i12.GetTopRatedMovies {
  MockGetTopRatedMovies() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Movie>>>.value(
                  _FakeEither<i6.Failure, List<i9.Movie>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Movie>>>);
}

/// A class which mocks [GetWatchListStatusMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatusMovie extends i1.Mock
    implements i13.GetWatchListStatus {
  MockGetWatchListStatusMovie() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as i5.Future<bool>);
}

/// A class which mocks [GetWatchlistMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlistMovies extends i1.Mock implements i14.GetWatchlistMovies {
  MockGetWatchlistMovies() {
    i1.throwOnMissingStub(this);
  }

  @override
  i5.Future<i3.Either<i6.Failure, List<i9.Movie>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue: Future<i3.Either<i6.Failure, List<i9.Movie>>>.value(
                  _FakeEither<i6.Failure, List<i9.Movie>>()))
          as i5.Future<i3.Either<i6.Failure, List<i9.Movie>>>);
}

/// A class which mocks [SaveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlistMovie extends i1.Mock implements i15.SaveWatchlist {
  MockSaveWatchlistMovie() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, String>> execute(i7.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<i3.Either<i6.Failure, String>>.value(
                  _FakeEither<i6.Failure, String>()))
          as i5.Future<i3.Either<i6.Failure, String>>);
}

/// A class which mocks [RemoveWatchlistMovie].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlistMovie extends i1.Mock implements i16.RemoveWatchlist {
  MockRemoveWatchlistMovie() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, String>> execute(i7.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<i3.Either<i6.Failure, String>>.value(
                  _FakeEither<i6.Failure, String>()))
          as i5.Future<i3.Either<i6.Failure, String>>);
}

/// A class which mocks [SearchMovies].
///
/// See the documentation for Mockito's code generation for more information.
class MockSearchMovies extends i1.Mock implements i4.SearchMovies {
  MockSearchMovies() {
    i1.throwOnMissingStub(this);
  }

  @override
  i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository()) as i2.MovieRepository);
  @override
  i5.Future<i3.Either<i6.Failure, List<i7.Movie>>> execute(String? query) =>
      (super.noSuchMethod(Invocation.method(#execute, [query]),
              returnValue: Future<i3.Either<i6.Failure, List<i7.Movie>>>.value(
                  _FakeEither<i6.Failure, List<i7.Movie>>()))
          as i5.Future<i3.Either<i6.Failure, List<i7.Movie>>>);
}
