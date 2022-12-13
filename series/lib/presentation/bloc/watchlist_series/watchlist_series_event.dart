part of 'watchlist_series_bloc.dart';

abstract class WatchListSeriesEvent extends Equatable {}

class OnFetchWatchListSeries extends WatchListSeriesEvent {
  @override
  List<Object?> get props => [];
}

class WatchListSeriesStatus extends WatchListSeriesEvent {
  final int id;

  WatchListSeriesStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class WatchListSeriesAdd extends WatchListSeriesEvent {
  final SeriesDetail seriesDetail;

  WatchListSeriesAdd(this.seriesDetail);

  @override
  List<Object?> get props => [SeriesDetail];
}

class WatchListSeriesRemove extends WatchListSeriesEvent {
  final SeriesDetail seriesDetail;

  WatchListSeriesRemove(this.seriesDetail);

  @override
  List<Object?> get props => [SeriesDetail];
}
