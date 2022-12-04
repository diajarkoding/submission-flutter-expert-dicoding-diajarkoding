import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:ditonton/domain/usecases/movies/get_popular_movies.dart';
import 'package:ditonton/presentation/provider/series/popular_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_series_notifier_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularSeries = MockGetPopularSeries();
    notifier = PopularSeriesNotifier(mockGetPopularSeries)
      ..addListener(() {
        listenerCallCount++;
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    notifier.fetchPopularSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Right(tSeriesList));
    // act
    await notifier.fetchPopularSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.series, tSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
