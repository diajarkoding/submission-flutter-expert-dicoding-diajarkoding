import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';

part 'popular_series_event.dart';

part 'popular_series_state.dart';

class PopularSeriesBloc extends Bloc<PopularSeriesEvent, PopularSeriesState> {
  final GetPopularSeries _getPopularSeries;

  PopularSeriesBloc(this._getPopularSeries) : super(PopularSeriesEmpty()) {
    on<OnPopularSeries>(_onPopularSeries);
  }

  FutureOr<void> _onPopularSeries(
      OnPopularSeries event, Emitter<PopularSeriesState> emit) async {
    emit(PopularSeriesLoading());

    final result = await _getPopularSeries.execute();

    result.fold((failure) {
      emit(PopularSeriesError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(PopularSeriesEmpty())
          : emit(PopularSeriesHasData(success));
    });
  }
}
