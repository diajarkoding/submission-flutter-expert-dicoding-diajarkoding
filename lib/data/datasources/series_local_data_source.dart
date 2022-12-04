import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/series_database_helper.dart';
import 'package:ditonton/data/models/series/series_table.dart';

abstract class SeriesLocalDataSource {
  Future<String> insertWatchlistSeries(SeriesTable series);
  Future<String> removeWatchlistSeries(SeriesTable series);
  Future<SeriesTable?> getSeriesById(int id);
  Future<List<SeriesTable>> getWatchlistSeries();
}

class SeriesLocalDataSourceImpl implements SeriesLocalDataSource {
  final DatabaseHelperSeries databaseHelperSeries;

  SeriesLocalDataSourceImpl({required this.databaseHelperSeries});

  @override
  Future<String> insertWatchlistSeries(SeriesTable series) async {
    try {
      await databaseHelperSeries.insertWatchlistSeries(series);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistSeries(SeriesTable series) async {
    try {
      await databaseHelperSeries.removeWatchlistSeries(series);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SeriesTable?> getSeriesById(int id) async {
    final result = await databaseHelperSeries.getSeriesById(id);
    if (result != null) {
      return SeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SeriesTable>> getWatchlistSeries() async {
    final result = await databaseHelperSeries.getWatchlistSeries();
    return result.map((data) => SeriesTable.fromMap(data)).toList();
  }
}
