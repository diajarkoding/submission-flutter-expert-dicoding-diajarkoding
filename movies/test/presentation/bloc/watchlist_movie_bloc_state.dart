import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';
import '../provider/watchlist_movie_notifier_test.mocks.dart';

void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockSaveWatchlist mockSaveWatchlist;
  late WatchListMovieBloc watchListMovieBloc;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    watchListMovieBloc = WatchListMovieBloc(
      mockGetWatchlistMovies,
      mockGetWatchListStatus,
      mockRemoveWatchlist,
      mockSaveWatchlist,
    );
  });

  test('the initial state should be Initial state', () {
    expect(watchListMovieBloc.state, WatchListMovieInitial());
  });

  group(
    'get watchlist movies test cases',
    () {
      blocTest<WatchListMovieBloc, WatchListMovieState>(
        'should emit Loading state and then HasData state when watchlist data successfully retrieved',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => Right([testWatchlistMovie]));
          return watchListMovieBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchListMovie()),
        expect: () => [
          WatchListMovieLoading(),
          WatchListMovieHasData([testWatchlistMovie]),
        ],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
          return OnFetchWatchListMovie().props;
        },
      );

      blocTest<WatchListMovieBloc, WatchListMovieState>(
        'should emit Loading state and then Error state when watchlist data failed to retrieved',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));
          return watchListMovieBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchListMovie()),
        expect: () => [
          WatchListMovieLoading(),
          WatchListMovieError('Server Failure'),
        ],
        verify: (bloc) => WatchListMovieLoading(),
      );

      blocTest<WatchListMovieBloc, WatchListMovieState>(
        'should emit Loading state and then Empty state when the retrieved watchlist data is empty',
        build: () {
          when(mockGetWatchlistMovies.execute())
              .thenAnswer((_) async => const Right([]));
          return watchListMovieBloc;
        },
        act: (bloc) => bloc.add(OnFetchWatchListMovie()),
        expect: () => [
          WatchListMovieLoading(),
          WatchListMovieEmpty(),
        ],
      );
    },
  );

  group(
    'get watchlist status test cases',
    () {
      blocTest<WatchListMovieBloc, WatchListMovieState>(
        'should be true when the watchlist status is also true',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => true);
          return watchListMovieBloc;
        },
        act: (bloc) => bloc.add(WatchListMovieStatus(testMovieDetail.id)),
        expect: () => [
          WatchListMovieIsAdded(true),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return WatchListMovieStatus(testMovieDetail.id).props;
        },
      );

      blocTest<WatchListMovieBloc, WatchListMovieState>(
        'should be false when the watchlist status is also false',
        build: () {
          when(mockGetWatchListStatus.execute(testMovieDetail.id))
              .thenAnswer((_) async => false);
          return watchListMovieBloc;
        },
        act: (bloc) => bloc.add(WatchListMovieStatus(testMovieDetail.id)),
        expect: () => [
          WatchListMovieIsAdded(false),
        ],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(testMovieDetail.id));
          return WatchListMovieStatus(testMovieDetail.id).props;
        },
      );
    },
  );

  group(
    'add and remove watchlist test cases',
    () {
      blocTest<WatchListMovieBloc, WatchListMovieState>(
        'should update watchlist status when adding watchlist succeeded',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("addMessage"));
          return watchListMovieBloc;
        },
        act: (bloc) => bloc.add(WatchListMovieAdd(testMovieDetail)),
        expect: () => [
          WatchListMovieMessage("addMessage"),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          return WatchListMovieAdd(testMovieDetail).props;
        },
      );

      blocTest<WatchListMovieBloc, WatchListMovieState>(
        'should throw failure message status when adding watchlist failed',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchListMovieBloc;
        },
        act: (bloc) => bloc.add(WatchListMovieAdd(testMovieDetail)),
        expect: () => [
          WatchListMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
          return WatchListMovieAdd(testMovieDetail).props;
        },
      );

      blocTest<WatchListMovieBloc, WatchListMovieState>(
        'should update watchlist status when removing watchlist succeeded',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail))
              .thenAnswer((_) async => const Right("removeMessage"));
          return watchListMovieBloc;
        },
        act: (bloc) => bloc.add(WatchListMovieRemove(testMovieDetail)),
        expect: () => [
          WatchListMovieMessage("removeMessage"),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          return WatchListMovieRemove(testMovieDetail).props;
        },
      );

      blocTest<WatchListMovieBloc, WatchListMovieState>(
        'should throw failure message status when removing watchlist failed',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
              (_) async =>
                  const Left(DatabaseFailure('can\'t add data to watchlist')));
          return watchListMovieBloc;
        },
        act: (bloc) => bloc.add(WatchListMovieRemove(testMovieDetail)),
        expect: () => [
          WatchListMovieError('can\'t add data to watchlist'),
        ],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
          return WatchListMovieRemove(testMovieDetail).props;
        },
      );
    },
  );
}
