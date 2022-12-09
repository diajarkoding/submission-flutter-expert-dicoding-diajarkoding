import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'recommendation_movie_state.dart';

part 'recommendation_movie_event.dart';

class RecommendationMovieBloc
    extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations _getRecommendationMovies;

  RecommendationMovieBloc(this._getRecommendationMovies)
      : super(RecommendationMovieEmpty()) {
    on<OnRecommendationMovie>(_onRecommendationMovie);
  }

  FutureOr<void> _onRecommendationMovie(OnRecommendationMovie event,
      Emitter<RecommendationMovieState> emit) async {
    final id = event.id;
    emit(RecommendationMovieLoading());

    final result = await _getRecommendationMovies.execute(id);
    result.fold((failure) {
      emit(RecommendationMovieError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(RecommendationMovieEmpty())
          : emit(RecommendationMovieHasData(success));
    });
  }
}
