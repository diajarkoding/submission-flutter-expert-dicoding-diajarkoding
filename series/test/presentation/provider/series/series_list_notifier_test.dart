import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:core/utils/failure.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:core/utils/state_enum.dart';
import 'package:series/presentation/provider/series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingSeries,
  GetPopularSeries,
  GetTopRatedSeries,
  GetSeriesRecommendations
])
void main() {
  late SeriesListNotifier provider;
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late MockGetPopularSeries mockGetPopularSeries;
  late MockGetTopRatedSeries mockGetTopRatedSeries;
  late MockGetSeriesRecommendations mockGetSeriesRecommendations;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    mockGetPopularSeries = MockGetPopularSeries();
    mockGetTopRatedSeries = MockGetTopRatedSeries();
    mockGetSeriesRecommendations = MockGetSeriesRecommendations();
    provider = SeriesListNotifier(
      getNowPlayingSeries: mockGetNowPlayingSeries,
      getPopularSeries: mockGetPopularSeries,
      getTopRatedSeries: mockGetTopRatedSeries,
      getSeriesRecommendations: mockGetSeriesRecommendations,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tSeries = Series(
    adult: false,
    backdropPath: null,
    id: 1382,
    name: "Engine",
    originalLanguage: "ja",
    originalName: "エンジン",
    overview:
        "Jiro Kanzaki is an F3000 test driver blessed with acute sensitivity and breathtaking driving techniques. He's a daredevil who feels no fear driving at speeds that even top racers dare not attempt. But unexpected trouble forces this world-famous racer to leave his team and return to Japan for the first time in years. Until he finds a new job as a racer, Jiro decides to stay with his parents. What awaits Jiro there is his hardheaded father, his nagging sister, the 12 children of the foster home his father runs, a snobbish male nurse, and a stubborn female nurse who likes to daydream about her life.",
    posterPath: "/rFL0ZXxBKprVuERMGO1ROGpEq45.jpg",
    mediaType: "tv",
    genreIds: [35],
    popularity: 2.562,
    firstAirDate: "2005-04-18",
    voteAverage: 7.8,
    voteCount: 4,
    originCountry: ["JP"],
  );
  final tSeriesList = <Series>[tSeries];

  group('now playing series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchNowPlayingSeries();
      // assert
      verify(mockGetNowPlayingSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchNowPlayingSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change series when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchNowPlayingSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.nowPlayingSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.Loaded);
      expect(provider.popularSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularSeries();
      // assert
      expect(provider.popularSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.Loading);
    });

    test('should change series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.Loaded);
      expect(provider.topRatedSeries, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedSeries();
      // assert
      expect(provider.topRatedSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('Get Series Recommendations', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetctSeriesRecommendations(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loading);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetctSeriesRecommendations(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.seriesRecommendations, tSeriesList);
    });

    test('should update error message when request in successful', () async {
      // arrange

      when(mockGetSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetctSeriesRecommendations(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Server Failure');
    });
  });
}