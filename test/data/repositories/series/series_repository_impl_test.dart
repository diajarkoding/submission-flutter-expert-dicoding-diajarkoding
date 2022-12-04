import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/series/series_detail_model.dart';
import 'package:ditonton/data/models/series/series_model.dart';
import 'package:ditonton/data/repositories/series_repository_impl.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/series/series_dummy_object.dart';
import '../../../helpers/series/series_test_helper.mocks.dart';

void main() {
  late SeriesRepositoryImpl repository;
  late MockSeriesRemoteDataSource mockRemoteDataSource;
  late MockSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockSeriesRemoteDataSource();
    mockLocalDataSource = MockSeriesLocalDataSource();
    repository = SeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tSeriesModel = SeriesModel(
    backdropPath: "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
    firstAirDate: "2021-10-12",
    genreIds: [80, 10765],
    id: 90462,
    name: "Chucky",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 2352.496,
    posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
    voteAverage: 7.9,
    voteCount: 3470,
  );

  final tSeries = Series(
    adult: null,
    backdropPath: "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
    firstAirDate: "2021-10-12",
    genreIds: [80, 10765],
    id: 90462,
    name: "Chucky",
    mediaType: null,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 2352.496,
    posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
    voteAverage: 7.9,
    voteCount: 3470,
  );

  final tSeriesModelList = <SeriesModel>[tSeriesModel];
  final tSeriesList = <Series>[tSeries];

  group('Now Playing Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingSeries())
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.getNowPlayingSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingSeries());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getNowPlayingSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getNowPlayingSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getNowPlayingSeries();
      // assert
      verify(mockRemoteDataSource.getNowPlayingSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular Series', () {
    test('should return Series list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.getPopularSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getPopularSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Top Rated Series', () {
    test('should return Series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedSeries();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Series Detail', () {
    final tId = 1;
    final tSeriesDetailModel = SeriesDetailModel(
      adult: false,
      backdropPath: "/3N3bUR0M9x3W5745KBFhXHawJrl.jpg",
      createdBy: [],
      episodeRunTime: [60],
      firstAirDate: "2004-01-12",
      genreModelSeries: [
        GenreModelSeries(id: 18, name: "Drama"),
      ],
      homepage: "https://www.fujitv.co.jp/b_hp/m9_pride/",
      id: 1,
      inProduction: false,
      languages: ["ja"],
      lastAirDate: "2004-03-22",
      name: "Pride",
      nextEpisodeToAir: null,
      numberOfEpisodes: 11,
      numberOfSeasonModel: 1,
      originCountry: ["JP"],
      originalLanguage: "ja",
      originalName: "プライド",
      overview:
          "The theme is strength and gallantry.Haru Satonaka is the captain of an ice-hockey team, a star athlete who stakes everything on hockey but can only consider love as a game. Aki Murase is a woman who has been waiting for her lover who went abroad two years ago. These two persons start a relationship while frankly admitting to each other that it is only a love game. …The result is the unfolding of a drama of people with their respective pasts and with their pride as individuals.",
      popularity: 4.046,
      posterPath: "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
      productionCompanies: [],
      seasonModel: [
        SeasonModel(
          airDate: "2004-01-12",
          episodeCount: 11,
          id: 2328126,
          name: "Season 1",
          overview: "",
          posterPath: "/nCcGD18HmDFunCl8KBigqUPlIi8.jpg",
          seasonNumber: 1,
        ),
      ],
      status: "Ended",
      tagline: "",
      type: "Scripted",
      voteAverage: 8.136,
      voteCount: 11,
    );

    test(
        'should return Series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(tId))
          .thenAnswer((_) async => tSeriesDetailModel);
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Right(testSeriesDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Series Recommendations', () {
    final tSeriesList = <SeriesModel>[];
    final tId = 1;

    test('should return data (Series list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(tId))
          .thenAnswer((_) async => tSeriesList);
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSeriesList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getSeriesRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSeriesRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSeriesRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getSeriesRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Seach Series', () {
    final tQuery = 'spiderman';

    test('should return Series list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenAnswer((_) async => tSeriesModelList);
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSeries(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchSeries(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist series', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlistSeries(testSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlistSeries(testSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlistSeries(testSeriesDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlistSeries(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist Series', () {
    test('should return list of Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistSeries())
          .thenAnswer((_) async => [testSeriesTable]);
      // act
      final result = await repository.getWatchlistSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistSeries]);
    });
  });
}
