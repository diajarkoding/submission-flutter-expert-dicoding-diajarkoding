import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';

part 'detail_movie_event.dart';

part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;

  DetailMovieBloc(this._getMovieDetail) : super(DetailMovieEmpty()) {
    on<OnDetailMovie>(_onDetailMovie);
  }

  FutureOr<void> _onDetailMovie(
      OnDetailMovie event, Emitter<DetailMovieState> emit) async {
    final id = event.id;

    emit(DetailMovieLoading());
    final result = await _getMovieDetail.execute(id);

    result.fold((failure) {
      emit(DetailMovieError(failure.message));
    }, (success) {
      emit(DetailMovieHasData(success));
    });
  }
}
