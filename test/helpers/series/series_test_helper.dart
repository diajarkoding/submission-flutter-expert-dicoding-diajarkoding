import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/series_remote_data_source.dart';
import 'package:ditonton/domain/repositories/series_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  SeriesRepository,
  SeriesRemoteDataSource,
  // SerieLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
