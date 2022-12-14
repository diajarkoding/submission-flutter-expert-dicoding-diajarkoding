import 'dart:io';
import 'dart:ui';
import 'package:core/core.dart';
import 'package:core/utils/certificate.dart';
import 'package:core/utils/ssl_pinning/http_ssl_pinning.dart';
import 'package:core/utils/utils.dart';
import 'package:about/about_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:movies/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movies/presentation/bloc/recommendation_movie/recommendation_movie_bloc.dart';
import 'package:movies/presentation/bloc/search_movie/search_movie_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/now_playing_movies_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/search_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:series/presentation/bloc/detail_series/detail_series_bloc.dart';
import 'package:series/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';
import 'package:series/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/presentation/bloc/recommendation_series/recommendation_series_bloc.dart';

import 'package:series/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/presentation/bloc/search_series/search_series_bloc.dart';
import 'package:series/presentation/bloc/watchlist_series/watchlist_series_bloc.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';

import 'package:series/presentation/pages/series_page.dart';
import 'package:series/presentation/pages/now_playing_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  di.init();
  HttpOverrides.global = MyHttpOverrides();
  await HttpSSLPinning.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Movie Bloc
        BlocProvider(create: (_) => di.locator<SearchMovieBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMovieBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMovieBloc>()),
        BlocProvider(create: (_) => di.locator<DetailMovieBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationMovieBloc>()),
        BlocProvider(create: (_) => di.locator<WatchListMovieBloc>()),

        // Series Bloc
        BlocProvider(create: (_) => di.locator<SearchSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<NowPlayingSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<PopularSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<DetailSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationSeriesBloc>()),
        BlocProvider(create: (_) => di.locator<WatchListSeriesBloc>()),
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
                  builder: (_) => MovieDetailPage(id: id), settings: settings);
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
            case PopularSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularSeriesPage());
            case TopRatedSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedSeriesPage());
            case SearchSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SearchSeriesPage());
            case NowPlayingSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => NowPlayingSeriesPage());

            // default
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :(('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
