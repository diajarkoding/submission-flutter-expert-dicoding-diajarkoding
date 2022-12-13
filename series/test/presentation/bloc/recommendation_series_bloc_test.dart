import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/recommendation_series/recommendation_series_bloc.dart';

import '../../dummy_data/series_dummy_object.dart';
import '../provider/series_list_notifier_test.mocks.dart';

void main() {
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late RecommendationSeriesBloc recommendationSeriesBloc;

  const testId = 1;

  setUp(() {
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    recommendationSeriesBloc =
        RecommendationSeriesBloc(mockGetSeriesRecommendations);
  });

  test('the initial state should be empty', () {
    expect(recommendationSeriesBloc.state, RecommendationSeriesEmpty());
  });

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testSeriesList));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(OnRecommendationSeries(testId)),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetSeriesRecommendations.execute(testId));
      return OnRecommendationSeries(testId).props;
    },
  );

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(OnRecommendationSeries(testId)),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesError('Server Failure'),
    ],
    verify: (bloc) => RecommendationSeriesLoading(),
  );

  blocTest<RecommendationSeriesBloc, RecommendationSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetSeriesRecommendations.execute(testId))
          .thenAnswer((_) async => const Right([]));
      return recommendationSeriesBloc;
    },
    act: (bloc) => bloc.add(OnRecommendationSeries(testId)),
    expect: () => [
      RecommendationSeriesLoading(),
      RecommendationSeriesEmpty(),
    ],
  );
}
