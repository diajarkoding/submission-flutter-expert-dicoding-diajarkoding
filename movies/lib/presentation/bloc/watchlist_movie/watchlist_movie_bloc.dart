import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

part 'watchlist_movie_state.dart';

part 'watchlist_movie_event.dart';

class WatchListMovieBloc
    extends Bloc<WatchListMovieEvent, WatchListMovieState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final RemoveWatchlist _removeWatchlist;
  final SaveWatchlist _saveWatchlist;

  WatchListMovieBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._removeWatchlist, this._saveWatchlist)
      : super(WatchListMovieInitial()) {
    on<OnFetchWatchListMovie>(_onFetchWatchListMovie);
    on<WatchListMovieStatus>(_onWatchListMovieStatus);
    on<WatchListMovieAdd>(_onWatchListMovieAdd);
    on<WatchListMovieRemove>(_onWatchListMovieRemove);
  }

  FutureOr<void> _onFetchWatchListMovie(
      OnFetchWatchListMovie event, Emitter<WatchListMovieState> emit) async {
    emit(WatchListMovieLoading());
    final result = await _getWatchlistMovies.execute();

    result.fold((failure) {
      emit(WatchListMovieError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(WatchListMovieEmpty())
          : emit(WatchListMovieHasData(success));
    });
  }

  FutureOr<void> _onWatchListMovieStatus(
      WatchListMovieStatus event, Emitter<WatchListMovieState> emit) async {
    final id = event.id;
    final result = await _getWatchListStatus.execute(id);
    emit(WatchListMovieIsAdded(result));
  }

  FutureOr<void> _onWatchListMovieAdd(
      WatchListMovieAdd event, Emitter<WatchListMovieState> emit) async {
    final movie = event.movieDetail;

    final result = await _saveWatchlist.execute(movie);
    result.fold((failure) {
      emit(WatchListMovieError(failure.message));
    }, (success) {
      emit(WatchListMovieMessage(success));
    });
  }

  FutureOr<void> _onWatchListMovieRemove(
      WatchListMovieRemove event, Emitter<WatchListMovieState> emit) async {
    final movie = event.movieDetail;
    final result = await _removeWatchlist.execute(movie);
    result.fold((failure) {
      emit(WatchListMovieError(failure.message));
    }, (success) {
      emit(WatchListMovieMessage(success));
    });
  }
}
