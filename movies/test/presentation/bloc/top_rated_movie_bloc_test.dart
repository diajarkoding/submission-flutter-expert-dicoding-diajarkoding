import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/bloc_test_helper.mocks.dart';

void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late TopRatedMovieBloc topRatedMovieBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(mockGetTopRatedMovies);
  });

  test('the initial state should be empty', () {
    expect(topRatedMovieBloc.state, TopRatedMovieEmpty());
  });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMovie()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
      return OnTopRatedMovie().props;
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMovie()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieError('Server Failure'),
    ],
    verify: (bloc) => TopRatedMovieLoading(),
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Right([]));
      return topRatedMovieBloc;
    },
    act: (bloc) => bloc.add(OnTopRatedMovie()),
    expect: () => [
      TopRatedMovieLoading(),
      TopRatedMovieEmpty(),
    ],
  );
}
