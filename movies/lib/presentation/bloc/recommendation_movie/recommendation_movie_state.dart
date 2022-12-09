part of 'recommendation_movie_bloc.dart';

@immutable
abstract class RecommendationMovieState extends Equatable {}

class RecommendationMovieEmpty extends RecommendationMovieState {
  @override
  List<Object?> get props => [];
}

class RecommendationMovieLoading extends RecommendationMovieState {
  @override
  List<Object?> get props => [];
}

class RecommendationMovieError extends RecommendationMovieState {
  final String message;

  RecommendationMovieError(this.message);

  @override
  List<Object?> get props => [message];
}

class RecommendationMovieHasData extends RecommendationMovieState {
  final List<Movie> result;

  RecommendationMovieHasData(this.result);

  @override
  List<Object?> get props => [result];
}
