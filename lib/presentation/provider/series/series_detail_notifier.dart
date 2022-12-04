import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/series_detail.dart';
import 'package:ditonton/domain/usecases/series/get_series_detail.dart';
import 'package:ditonton/domain/usecases/series/get_watchlist_series_status.dart';
import 'package:ditonton/domain/usecases/series/remove_watchlist_series.dart';
import 'package:ditonton/domain/usecases/series/save_watchlist_series.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSeriesDetail getSeriesDetail;
  final GetWatchListSeriesStatus getWatchListSeriesStatus;
  final SaveWatchlistSeries saveWatchlistSeries;
  final RemoveWatchlistSeries removeWatchlistSeries;

  SeriesDetailNotifier({
    required this.getSeriesDetail,
    required this.getWatchListSeriesStatus,
    required this.saveWatchlistSeries,
    required this.removeWatchlistSeries,
  });

  late SeriesDetail _seriesDetail;
  SeriesDetail get seriesDetail => _seriesDetail;

  RequestState _seriesDetailState = RequestState.Empty;
  RequestState get seriesDetailState => _seriesDetailState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchSeriesDetail(int id) async {
    _seriesDetailState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getSeriesDetail.execute(id);

    detailResult.fold(
      (failure) {
        _seriesDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (seriesDetail) {
        _seriesDetailState = RequestState.Loaded;
        _seriesDetail = seriesDetail;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(SeriesDetail series) async {
    final result = await saveWatchlistSeries.execute(series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> removeFromWatchlist(SeriesDetail series) async {
    final result = await removeWatchlistSeries.execute(series);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(series.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListSeriesStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
