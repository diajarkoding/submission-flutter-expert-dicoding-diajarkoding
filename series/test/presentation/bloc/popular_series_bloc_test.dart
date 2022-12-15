import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/popular_series/popular_series_bloc.dart';

import '../../dummy_data/series_dummy_object.dart';
import '../../helpers/bloc_test_series.mocks.dart';

void main() {
  late MockGetPopularSeries mockGetPopularSeries;
  late PopularSeriesBloc popularSeriesBloc;

  setUp(() {
    mockGetPopularSeries = MockGetPopularSeries();
    popularSeriesBloc = PopularSeriesBloc(mockGetPopularSeries);
  });

  test('the initial state should be empty', () {
    expect(popularSeriesBloc.state, PopularSeriesEmpty());
  });

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return popularSeriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularSeries()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetPopularSeries.execute());
      return OnPopularSeries().props;
    },
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return popularSeriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularSeries()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesError('Server Failure'),
    ],
    verify: (bloc) => PopularSeriesLoading(),
  );

  blocTest<PopularSeriesBloc, PopularSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetPopularSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return popularSeriesBloc;
    },
    act: (bloc) => bloc.add(OnPopularSeries()),
    expect: () => [
      PopularSeriesLoading(),
      PopularSeriesEmpty(),
    ],
  );
}
