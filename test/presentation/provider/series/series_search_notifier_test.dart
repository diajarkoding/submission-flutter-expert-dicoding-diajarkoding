import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/series/search_series.dart';
import 'package:ditonton/presentation/provider/series/series_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SeriesSearchNotifier provider;
  late MockSearchSeries mockSearchSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchSeries = MockSearchSeries();
    provider = SeriesSearchNotifier(searchSeries: mockSearchSeries)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

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
  final tQuery = 'Engine';

  group('search series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      provider.fetchSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tSeriesList));
      // act
      await provider.fetchSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, tSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchSeriesSearch(tQuery);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
