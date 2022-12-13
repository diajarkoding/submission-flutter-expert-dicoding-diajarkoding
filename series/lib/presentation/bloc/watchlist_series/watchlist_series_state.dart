part of 'watchlist_series_bloc.dart';

abstract class WatchListSeriesState extends Equatable {}

class WatchListSeriesInitial extends WatchListSeriesState {
  @override
  List<Object?> get props => [];
}

class WatchListSeriesEmpty extends WatchListSeriesState {
  @override
  List<Object?> get props => [];
}

class WatchListSeriesLoading extends WatchListSeriesState {
  @override
  List<Object?> get props => [];
}

class WatchListSeriesError extends WatchListSeriesState {
  final String message;

  WatchListSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class WatchListSeriesHasData extends WatchListSeriesState {
  final List<Series> result;

  WatchListSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class WatchListSeriesIsAdded extends WatchListSeriesState {
  final bool isAdded;

  WatchListSeriesIsAdded(this.isAdded);

  @override
  List<Object?> get props => [isAdded];
}

class WatchListSeriesMessage extends WatchListSeriesState {
  final String message;

  WatchListSeriesMessage(this.message);

  @override
  List<Object?> get props => [message];
}
