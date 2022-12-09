import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/recommendation_movie/recommendation_movie_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';

void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late RecommendationMovieBloc recommendationMovieBloc;

  const testId = 1;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieBloc =
        RecommendationMovieBloc(mockGetMovieRecommendations);
  });

  test('the initial state should be empty', () {
    expect(recommendationMovieBloc.state, RecommendationMovieEmpty());
  });

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(OnRecommendationMovie(testId)),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testId));
      return OnRecommendationMovie(testId).props;
    },
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(OnRecommendationMovie(testId)),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieError('Server Failure'),
    ],
    verify: (bloc) => RecommendationMovieLoading(),
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return recommendationMovieBloc;
    },
    act: (bloc) => bloc.add(OnRecommendationMovie(testId)),
    expect: () => [
      RecommendationMovieLoading(),
      RecommendationMovieEmpty(),
    ],
  );
}
