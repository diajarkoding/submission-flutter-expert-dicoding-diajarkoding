import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/search_series.dart';
import 'package:series/presentation/bloc/search_series/search_series_bloc.dart';
import '../provider/series_search_notifier_test.mocks.dart';

@GenerateMocks([SearchSeries])
void main() {
  late SearchSeriesBloc searchSeriesBloc;
  late MockSearchSeries mockSearchSeries;

  setUp(() {
    mockSearchSeries = MockSearchSeries();
    searchSeriesBloc = SearchSeriesBloc(mockSearchSeries);
  });

  test('initial state should be empty', () {
    expect(searchSeriesBloc.state, SearchEmpty());
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

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tSeriesList));
      return searchSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasData(tSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );

  blocTest<SearchSeriesBloc, SearchSeriesState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchSeries.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchSeriesBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchSeries.execute(tQuery));
    },
  );
}
