import 'package:series/data/datasources/db/series_database_helper.dart';
import 'package:series/data/datasources/series_remote_data_source.dart';
import 'package:series/domain/repositories/series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  SeriesRepository,
  SeriesRemoteDataSource,
  // SerieLocalDataSource,
  DatabaseHelperSeries,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
