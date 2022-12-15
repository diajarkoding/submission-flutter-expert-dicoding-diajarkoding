import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/detail_series/detail_series_bloc.dart';
import '../../dummy_data/series_dummy_object.dart';
import '../../helpers/bloc_test_series.mocks.dart';

void main() {
  late MockGetSeriesDetail mockGetSeriesDetail;
  late DetailSeriesBloc detailSeriesBloc;

  const testId = 1;

  setUp(() {
    mockGetSeriesDetail = MockGetSeriesDetail();
    detailSeriesBloc = DetailSeriesBloc(mockGetSeriesDetail);
  });

  test('the initial state should be empty', () {
    expect(detailSeriesBloc.state, DetailSeriesEmpty());
  });
  blocTest<DetailSeriesBloc, DetailSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetSeriesDetail.execute(testId))
          .thenAnswer((_) async => Right(testSeriesDetail));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(OnDetailSeries(testId)),
    expect: () => [
      DetailSeriesLoading(),
      DetailSeriesHasData(testSeriesDetail),
    ],
    verify: (bloc) {
      verify(mockGetSeriesDetail.execute(testId));
      return OnDetailSeries(testId).props;
    },
  );

  blocTest<DetailSeriesBloc, DetailSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetSeriesDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailSeriesBloc;
    },
    act: (bloc) => bloc.add(OnDetailSeries(testId)),
    expect: () => [
      DetailSeriesLoading(),
      DetailSeriesError('Server Failure'),
    ],
    verify: (bloc) => DetailSeriesLoading(),
  );
}
