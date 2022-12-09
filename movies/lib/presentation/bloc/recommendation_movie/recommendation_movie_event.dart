part of 'recommendation_movie_bloc.dart';

abstract class RecommendationMovieEvent extends Equatable {}

class OnRecommendationMovie extends RecommendationMovieEvent {
  final int id;

  OnRecommendationMovie(this.id);

  @override
  List<Object?> get props => [id];
}
