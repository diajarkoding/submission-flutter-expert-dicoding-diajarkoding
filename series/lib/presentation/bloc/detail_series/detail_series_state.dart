part of 'detail_series_bloc.dart';

abstract class DetailSeriesState extends Equatable {}

class DetailSeriesEmpty extends DetailSeriesState {
  @override
  List<Object?> get props => [];
}

class DetailSeriesLoading extends DetailSeriesState {
  @override
  List<Object?> get props => [];
}

class DetailSeriesError extends DetailSeriesState {
  final String message;

  DetailSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class DetailSeriesHasData extends DetailSeriesState {
  final SeriesDetail result;

  DetailSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
