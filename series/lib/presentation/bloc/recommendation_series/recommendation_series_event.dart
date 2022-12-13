part of 'recommendation_series_bloc.dart';

abstract class RecommendationSeriesEvent extends Equatable {}

class OnRecommendationSeries extends RecommendationSeriesEvent {
  final int id;

  OnRecommendationSeries(this.id);

  @override
  List<Object?> get props => [id];
}
