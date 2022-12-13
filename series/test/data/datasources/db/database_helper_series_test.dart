import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/series_dummy_object.dart';
import '../../../helpers/series_test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
  });

  final testSeriesTableId = testSeriesTable.id;

  group('Series test on db', () {
    test('should return movie id when inserting new movie', () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => testSeriesTableId);
      // act
      final result =
          await mockDatabaseHelper.insertWatchlistSeries(testSeriesTable);
      // assert
      expect(result, testSeriesTableId);
    });

    test('should return movie id when deleting a movie', () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlistSeries(testSeriesTable))
          .thenAnswer((_) async => testSeriesTableId);
      // act
      final result =
          await mockDatabaseHelper.removeWatchlistSeries(testSeriesTable);
      // assert
      expect(result, testSeriesTableId);
    });

    test('should return Series Detail Table when getting movie by id is found',
        () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(testSeriesTableId))
          .thenAnswer((_) async => testSeriesTable.toJson());
      // act
      final result = await mockDatabaseHelper.getSeriesById(testSeriesTableId);
      // assert
      expect(result, testSeriesTable.toJson());
    });

    test('should return null when getting movie by id is not found', () async {
      // arrange
      when(mockDatabaseHelper.getSeriesById(testSeriesTableId))
          .thenAnswer((_) async => null);
      // act
      final result = await mockDatabaseHelper.getSeriesById(testSeriesTableId);
      // assert
      expect(result, null);
    });

    test('should return list of movie map when getting watchlist movies',
        () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistSeries())
          .thenAnswer((_) async => [testSeriesMap]);
      // act
      final result = await mockDatabaseHelper.getWatchlistSeries();
      // assert
      expect(result, [testSeriesMap]);
    });
  });
}
