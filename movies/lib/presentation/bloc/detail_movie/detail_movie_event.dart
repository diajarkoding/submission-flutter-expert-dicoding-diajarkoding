part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {}

class OnDetailMovie extends DetailMovieEvent {
  final int id;

  OnDetailMovie(this.id);

  @override
  List<Object?> get props => [id];
}
