import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';
import 'package:series/domain/usecases/get_watchlist_series_status.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';

part 'watchlist_series_state.dart';

part 'watchlist_series_event.dart';

class WatchListSeriesBloc
    extends Bloc<WatchListSeriesEvent, WatchListSeriesState> {
  final GetWatchlistSeries _getWatchlistSeries;
  final GetWatchListSeriesStatus _getWatchListSeriesStatus;
  final RemoveWatchlistSeries _removeWatchlistSeries;
  final SaveWatchlistSeries _saveWatchlistSeries;

  WatchListSeriesBloc(this._getWatchlistSeries, this._getWatchListSeriesStatus,
      this._removeWatchlistSeries, this._saveWatchlistSeries)
      : super(WatchListSeriesInitial()) {
    on<OnFetchWatchListSeries>(_onFetchWatchListSeries);
    on<WatchListSeriesStatus>(_onWatchListSeriestatus);
    on<WatchListSeriesAdd>(_onWatchListSeriesAdd);
    on<WatchListSeriesRemove>(_onWatchListSeriesRemove);
  }

  FutureOr<void> _onFetchWatchListSeries(
      OnFetchWatchListSeries event, Emitter<WatchListSeriesState> emit) async {
    emit(WatchListSeriesLoading());
    final result = await _getWatchlistSeries.execute();

    result.fold((failure) {
      emit(WatchListSeriesError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(WatchListSeriesEmpty())
          : emit(WatchListSeriesHasData(success));
    });
  }

  FutureOr<void> _onWatchListSeriestatus(
      WatchListSeriesStatus event, Emitter<WatchListSeriesState> emit) async {
    final id = event.id;
    final result = await _getWatchListSeriesStatus.execute(id);
    emit(WatchListSeriesIsAdded(result));
  }

  FutureOr<void> _onWatchListSeriesAdd(
      WatchListSeriesAdd event, Emitter<WatchListSeriesState> emit) async {
    final Series = event.seriesDetail;

    final result = await _saveWatchlistSeries.execute(Series);
    result.fold((failure) {
      emit(WatchListSeriesError(failure.message));
    }, (success) {
      emit(WatchListSeriesMessage(success));
    });
  }

  FutureOr<void> _onWatchListSeriesRemove(
      WatchListSeriesRemove event, Emitter<WatchListSeriesState> emit) async {
    final Series = event.seriesDetail;
    final result = await _removeWatchlistSeries.execute(Series);
    result.fold((failure) {
      emit(WatchListSeriesError(failure.message));
    }, (success) {
      emit(WatchListSeriesMessage(success));
    });
  }
}
