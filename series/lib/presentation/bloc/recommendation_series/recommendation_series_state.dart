part of 'recommendation_series_bloc.dart';

@immutable
abstract class RecommendationSeriesState extends Equatable {}

class RecommendationSeriesEmpty extends RecommendationSeriesState {
  @override
  List<Object?> get props => [];
}

class RecommendationSeriesLoading extends RecommendationSeriesState {
  @override
  List<Object?> get props => [];
}

class RecommendationSeriesError extends RecommendationSeriesState {
  final String message;

  RecommendationSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class RecommendationSeriesHasData extends RecommendationSeriesState {
  final List<Series> result;

  RecommendationSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
