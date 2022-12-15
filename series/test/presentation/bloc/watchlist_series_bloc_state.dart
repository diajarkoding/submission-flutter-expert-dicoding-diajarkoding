import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:series/presentation/bloc/watchlist_series/watchlist_series_bloc.dart';
import '../../dummy_data/series_dummy_object.dart';
import '../../helpers/bloc_test_series.mocks.dart';

void main() {
  late MockGetWatchlistSeries mockGetWatchlistSeries;
  late MockGetWatchListStatusSeries mockGetWatchListSeriesStatus;
  late MockRemoveWatchlistSeries mockRemoveWatchlistSeries;
  late MockSaveWatchlistSeries mockSaveWatchlistSeries;
  late WatchListSeriesBloc watchListSeriesBloc;

  setUp(() {
    mockSaveWatchlistSeries = MockSaveWatchlistSeries();
    mockRemoveWatchlistSeries = MockRemoveWatchlistSeries();
    mockGetWatchlistSeries = MockGetWatchlistSeries();
    mockGetWatchListSeriesStatus = MockGetWatchListStatusSeries();
    watchListSeriesBloc = WatchListSeriesBloc(
      mockGetWatchlistSeries,
      mockGetWatchListSeriesStatus,
      mockRemoveWatchlistSeries,
      mockSaveWatchlistSeries,
    );
  });

  test('the initial state should be Initial state', () {
    expect(watchListSeriesBloc.state, WatchListSeriesInitial());
  });

  group(
    'get watchlist series test cases',
    () {
      blocTest<WatchListSeriesBloc, WatchListSeriesState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(mockGetWatchlistSeries.execute())
              .thenAnswer((_) async => Right([testWatchlistSeries]));
          return watchListSeriesBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchListSeries()),
        expect: () => [
          WatchListSeriesLoading(),
          WatchListSeriesHasData([testWatchlistSeries]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistSeries.execute());
          return OnFetchWatchListSeries().props;
        },
      );

      blocTest<WatchListSeriesBloc, WatchListSeriesState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(mockGetWatchlistSeries.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchListSeriesBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchListSeries()),
        expect: () => [
          WatchListSeriesLoading(),
          WatchListSeriesError('Server Failure'),
        ],
        verify: (bloc) => WatchListSeriesLoading(),
      );

      blocTest<WatchListSeriesBloc, WatchListSeriesState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(mockGetWatchlistSeries.execute())
              .thenAnswer((_) async => const Right([]));
          return watchListSeriesBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchListSeries()),
        expect: () => [
          WatchListSeriesLoading(),
          WatchListSeriesEmpty(),
        ],
      );
    },
  );

  group(
    'get watchlist status test cases',
    () {
      blocTest<WatchListSeriesBloc, WatchListSeriesState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
              .thenAnswer((_) async => true);
          return watchListSeriesBloc;
        },
        act: (bloc) => bloc.add(WatchListSeriesStatus(testSeriesDetail.id)),
        expect: () => [
          WatchListSeriesIsAdded(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id));
          return WatchListSeriesStatus(testSeriesDetail.id).props;
        },
      );

      blocTest<WatchListSeriesBloc, WatchListSeriesState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id))
              .thenAnswer((_) async => false);
          return watchListSeriesBloc;
        },
        act: (bloc) => bloc.add(WatchListSeriesStatus(testSeriesDetail.id)),
        expect: () => [
          WatchListSeriesIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListSeriesStatus.execute(testSeriesDetail.id));
          return WatchListSeriesStatus(testSeriesDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<WatchListSeriesBloc, WatchListSeriesState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveWatchlistSeries.execute(testSeriesDetail))
              .thenAnswer((_) async => const Right("addMessage"));
          return watchListSeriesBloc;
        },
        act: (bloc) => bloc.add(WatchListSeriesAdd(testSeriesDetail)),
        expect: () => [
          WatchListSeriesMessage("addMessage"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistSeries.execute(testSeriesDetail));
          return WatchListSeriesAdd(testSeriesDetail).props;
        },
      );

      blocTest<WatchListSeriesBloc, WatchListSeriesState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveWatchlistSeries.execute(testSeriesDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchListSeriesBloc;
        },
        act: (bloc) => bloc.add(WatchListSeriesAdd(testSeriesDetail)),
        expect: () => [
          WatchListSeriesError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlistSeries.execute(testSeriesDetail));
          return WatchListSeriesAdd(testSeriesDetail).props;
        },
      );

      blocTest<WatchListSeriesBloc, WatchListSeriesState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveWatchlistSeries.execute(testSeriesDetail))
              .thenAnswer((_) async => const Right("removeMessage"));
          return watchListSeriesBloc;
        },
        act: (bloc) => bloc.add(WatchListSeriesRemove(testSeriesDetail)),
        expect: () => [
          WatchListSeriesMessage("removeMessage"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
          return WatchListSeriesRemove(testSeriesDetail).props;
        },
      );

      blocTest<WatchListSeriesBloc, WatchListSeriesState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveWatchlistSeries.execute(testSeriesDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchListSeriesBloc;
        },
        act: (bloc) => bloc.add(WatchListSeriesRemove(testSeriesDetail)),
        expect: () => [
          WatchListSeriesError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlistSeries.execute(testSeriesDetail));
          return WatchListSeriesRemove(testSeriesDetail).props;
        },
      );
    },
  );
}
