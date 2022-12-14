import 'package:dartz/dartz.dart';
import 'package:series/domain/entities/series.dart';
import 'package:core/utils/failure.dart';
import 'package:series/domain/repositories/series_repository.dart';

class GetWatchlistSeries {
  final SeriesRepository _repository;

  GetWatchlistSeries(this._repository);

  Future<Either<Failure, List<Series>>> execute() {
    return _repository.getWatchlistSeries();
  }
}
