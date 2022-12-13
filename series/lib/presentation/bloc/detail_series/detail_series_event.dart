part of 'detail_series_bloc.dart';

abstract class DetailSeriesEvent extends Equatable {}

class OnDetailSeries extends DetailSeriesEvent {
  final int id;

  OnDetailSeries(this.id);

  @override
  List<Object?> get props => [id];
}
