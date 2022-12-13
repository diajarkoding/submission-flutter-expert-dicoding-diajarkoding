import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:series/domain/usecases/get_series_detail.dart';

part 'detail_series_event.dart';

part 'detail_series_state.dart';

class DetailSeriesBloc extends Bloc<DetailSeriesEvent, DetailSeriesState> {
  final GetSeriesDetail _getSeriesDetail;

  DetailSeriesBloc(this._getSeriesDetail) : super(DetailSeriesEmpty()) {
    on<OnDetailSeries>(_onDetailSeries);
  }

  FutureOr<void> _onDetailSeries(
      OnDetailSeries event, Emitter<DetailSeriesState> emit) async {
    final id = event.id;

    emit(DetailSeriesLoading());
    final result = await _getSeriesDetail.execute(id);

    result.fold((failure) {
      emit(DetailSeriesError(failure.message));
    }, (success) {
      emit(DetailSeriesHasData(success));
    });
  }
}
