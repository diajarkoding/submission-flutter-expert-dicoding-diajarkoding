// ignore_for_file: unused_import

import 'package:core/utils/ssl_pinning/http_ssl_pinning.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movies/data/datasources/db/database_helper.dart';
import 'package:movies/data/datasources/movie_local_data_source.dart';
import 'package:movies/data/datasources/movie_remote_data_source.dart';
import 'package:movies/data/repositories/movie_repository_impl.dart';
import 'package:movies/domain/repositories/movie_repository.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_movies.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/domain/usecases/search_movies.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:movies/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movies/presentation/bloc/recommendation_movie/recommendation_movie_bloc.dart';
import 'package:movies/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:series/data/datasources/db/series_database_helper.dart';
import 'package:series/data/datasources/series_local_data_source.dart';
import 'package:series/data/datasources/series_remote_data_source.dart';
import 'package:series/data/repositories/series_repository_impl.dart';
import 'package:series/domain/repositories/series_repository.dart';
import 'package:series/domain/usecases/get_now_playing_series.dart';
import 'package:series/domain/usecases/get_popular_series.dart';
import 'package:series/domain/usecases/get_series_detail.dart';
import 'package:series/domain/usecases/get_series_recommendations.dart';
import 'package:series/domain/usecases/get_top_rated_series.dart';
import 'package:series/domain/usecases/get_watchlist_series.dart';
import 'package:series/domain/usecases/get_watchlist_series_status.dart';
import 'package:series/domain/usecases/remove_watchlist_series.dart';
import 'package:series/domain/usecases/save_watchlist_series.dart';
import 'package:series/domain/usecases/search_series.dart';
import 'package:series/presentation/bloc/detail_series/detail_series_bloc.dart';
import 'package:series/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';
import 'package:series/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/presentation/bloc/recommendation_series/recommendation_series_bloc.dart';
import 'package:series/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:series/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/presentation/bloc/watchlist_series/watchlist_series_bloc.dart';

final locator = GetIt.instance;

void init() {
  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // use case series
  locator.registerLazySingleton(() => GetNowPlayingSeries(locator()));
  locator.registerLazySingleton(() => GetPopularSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedSeries(locator()));
  locator.registerLazySingleton(() => GetSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSeries(locator()));
  locator.registerLazySingleton(() => GetWatchlistSeries(locator()));

  // repository series
  locator.registerLazySingleton<SeriesRepository>(
    () => SeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources series
  locator.registerLazySingleton<SeriesRemoteDataSource>(
      () => SeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<SeriesLocalDataSource>(
      () => SeriesLocalDataSourceImpl(
            databaseHelperSeries: locator(),
          ));

  // helper series
  locator.registerLazySingleton<DatabaseHelperSeries>(
      () => DatabaseHelperSeries());

  // bloc movies
  locator.registerFactory(() => SearchMovieBloc(locator()));
  locator.registerFactory(() => NowPlayingMovieBloc(locator()));
  locator.registerFactory(() => PopularMovieBloc(locator()));
  locator.registerFactory(() => TopRatedMovieBloc(locator()));
  locator.registerFactory(() => DetailMovieBloc(locator()));
  locator.registerFactory(() => RecommendationMovieBloc(locator()));
  locator.registerFactory(
      () => WatchListMovieBloc(locator(), locator(), locator(), locator()));

  // bloc series
  locator.registerFactory(() => SearchSeriesBloc(locator()));
  locator.registerFactory(() => NowPlayingSeriesBloc(locator()));
  locator.registerFactory(() => PopularSeriesBloc(locator()));
  locator.registerFactory(() => TopRatedSeriesBloc(locator()));
  locator.registerFactory(() => DetailSeriesBloc(locator()));
  locator.registerFactory(() => RecommendationSeriesBloc(locator()));
  locator.registerFactory(
      () => WatchListSeriesBloc(locator(), locator(), locator(), locator()));

  // external
  // locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
