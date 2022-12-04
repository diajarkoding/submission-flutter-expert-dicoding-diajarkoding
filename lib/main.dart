import 'dart:io';

import 'package:ditonton/bloc/search_movie_bloc.dart';
import 'package:ditonton/common/certificate.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/now_playing_movies_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/series/dashboard_series_page.dart';
import 'package:ditonton/presentation/pages/series/now_playing_series_page.dart';
import 'package:ditonton/presentation/pages/series/popular_series_page.dart';
import 'package:ditonton/presentation/pages/series/search_series_page.dart';
import 'package:ditonton/presentation/pages/series/series_detail_page.dart';
import 'package:ditonton/presentation/pages/series/series_page.dart';
import 'package:ditonton/presentation/pages/series/top_rated_series_page.dart';
import 'package:ditonton/presentation/pages/series/watchlist_series_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/series/popular_series_notifier.dart';
import 'package:ditonton/presentation/provider/series/series_detail_notifier.dart';
import 'package:ditonton/presentation/provider/series/series_list_notifier.dart';
import 'package:ditonton/presentation/provider/series/series_search_notifier.dart';
import 'package:ditonton/presentation/provider/series/top_rated_series_notifier.dart';
import 'package:ditonton/presentation/provider/series/watchlist_series_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Movie
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),

        // Movie Bloc
        BlocProvider(
          create: (_) => di.locator<SearchMovieBloc>(),
        ),

        // Series
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SeriesSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            di.locator<SeriesListNotifier>();
            di.locator<SeriesDetailNotifier>();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case NowPlayingMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingMoviePage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            // series
            case SeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SeriesPage());
            case SeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SeriesDetailPage(id: id),
                settings: settings,
              );
            case WatchlistSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistSeriesPage());
            case PopularSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularSeriesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedSeriesPage());
            case SearchSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchSeriesPage());
            case DashboardSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => DashboardSeriesPage());
            case NowPlayingSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingSeriesPage());
            // default
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
