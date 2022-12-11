import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/popular_movies_notifier_test.mocks.dart';

void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc popularMovieBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('the initial state should be empty', () {
    expect(popularMovieBloc.state, PopularMovieEmpty());
  });

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(OnPopularMovie()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
      return OnPopularMovie().props;
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(OnPopularMovie()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieError('Server Failure'),
    ],
    verify: (bloc) => PopularMovieLoading(),
  );

  blocTest<PopularMovieBloc, PopularMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return popularMovieBloc;
    },
    act: (bloc) => bloc.add(OnPopularMovie()),
    expect: () => [
      PopularMovieLoading(),
      PopularMovieEmpty(),
    ],
  );
}
