import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';

part 'recommendation_series_state.dart';

part 'recommendation_series_event.dart';

class RecommendationSeriesBloc
    extends Bloc<RecommendationSeriesEvent, RecommendationSeriesState> {
  final GetSeriesRecommendations _getRecommendationSeries;

  RecommendationSeriesBloc(this._getRecommendationSeries)
      : super(RecommendationSeriesEmpty()) {
    on<OnRecommendationSeries>(_onRecommendationSeries);
  }

  FutureOr<void> _onRecommendationSeries(OnRecommendationSeries event,
      Emitter<RecommendationSeriesState> emit) async {
    final id = event.id;
    emit(RecommendationSeriesLoading());

    final result = await _getRecommendationSeries.execute(id);
    result.fold((failure) {
      emit(RecommendationSeriesError(failure.message));
    }, (success) {
      success.isEmpty
          ? emit(RecommendationSeriesEmpty())
          : emit(RecommendationSeriesHasData(success));
    });
  }
}
