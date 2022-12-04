import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/series_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/series/series_dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SeriesLocalDataSourceImpl dataSource;
  late MockDatabaseHelperSeries mockDatabaseHelperSeries;

  setUp(() {
    mockDatabaseHelperSeries = MockDatabaseHelperSeries();
    dataSource = SeriesLocalDataSourceImpl(
        databaseHelperSeries: mockDatabaseHelperSeries);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelperSeries.insertWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlistSeries(testSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperSeries.insertWatchlistSeries(testSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlistSeries(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelperSeries.removeWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlistSeries(testSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelperSeries.removeWatchlistSeries(testSeriesTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlistSeries(testSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    final tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockDatabaseHelperSeries.getSeriesById(tId))
          .thenAnswer((_) async => testSeriesMap);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, testSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelperSeries.getSeriesById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getSeriesById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockDatabaseHelperSeries.getWatchlistSeries())
          .thenAnswer((_) async => [testSeriesMap]);
      // act
      final result = await dataSource.getWatchlistSeries();
      // assert
      expect(result, [testSeriesTable]);
    });
  });
}
