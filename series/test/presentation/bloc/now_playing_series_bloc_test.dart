import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';

import '../../dummy_data/series_dummy_object.dart';
import '../provider/series_list_notifier_test.mocks.dart';

void main() {
  late MockGetNowPlayingSeries mockGetNowPlayingSeries;
  late NowPlayingSeriesBloc nowPlayingSeriesBloc;

  setUp(() {
    mockGetNowPlayingSeries = MockGetNowPlayingSeries();
    nowPlayingSeriesBloc = NowPlayingSeriesBloc(mockGetNowPlayingSeries);
  });

  test('the initial state should be empty', () {
    expect(nowPlayingSeriesBloc.state, NowPlayingSeriesEmpty());
  });

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => Right(testSeriesList));
      return nowPlayingSeriesBloc;
    },
    act: (bloc) => bloc.add(OnNowPLayingSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesHasData(testSeriesList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingSeries.execute());
      return OnNowPLayingSeries().props;
    },
  );

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return nowPlayingSeriesBloc;
    },
    act: (bloc) => bloc.add(OnNowPLayingSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      const NowPlayingSeriesError('Server Failure'),
    ],
    verify: (bloc) => NowPlayingSeriesLoading(),
  );

  blocTest<NowPlayingSeriesBloc, NowPlayingSeriesState>(
    'should emit Loading state and then Empty state when the retrieved data is empty',
    build: () {
      when(mockGetNowPlayingSeries.execute())
          .thenAnswer((_) async => const Right([]));
      return nowPlayingSeriesBloc;
    },
    act: (bloc) => bloc.add(OnNowPLayingSeries()),
    expect: () => [
      NowPlayingSeriesLoading(),
      NowPlayingSeriesEmpty(),
    ],
  );
}
