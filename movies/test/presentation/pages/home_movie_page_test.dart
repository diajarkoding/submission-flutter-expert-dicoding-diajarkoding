// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movies/presentation/pages/home_movie_page.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'fake_home_page.dart';

/// fake now playing movies bloc
class FakeNowPlayingMovieEvent extends Fake implements NowPlayingMovieEvent {}

class FakeNowPlayingMovieState extends Fake implements NowPlayingMovieState {}

class FakeNowPlayingMovieBloc
    extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState>
    implements NowPlayingMovieBloc {}

/// fake popular movies bloc
class FakePopularMoviesEvent extends Fake implements PopularMovieEvent {}

class FakePopularMoviesState extends Fake implements PopularMovieState {}

class FakePopularMoviesBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

/// fake top rated movies bloc
class FakeTopRatedMoviesEvent extends Fake implements TopRatedMovieEvent {}

class FakeTopRatedMoviesState extends Fake implements TopRatedMovieState {}

class FakeTopRatedMoviesBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

void main() {
  late FakeNowPlayingMovieBloc fakeNowPlayingMovieBloc;
  late FakePopularMoviesBloc fakePopularMovieBloc;
  late FakeTopRatedMoviesBloc fakeTopRatedMovieBloc;

  setUp(() {
    registerFallbackValue(FakeNowPlayingMovieEvent());
    registerFallbackValue(FakeNowPlayingMovieState());
    fakeNowPlayingMovieBloc = FakeNowPlayingMovieBloc();

    registerFallbackValue(FakePopularMoviesEvent());
    registerFallbackValue(FakePopularMoviesState());
    fakePopularMovieBloc = FakePopularMoviesBloc();

    registerFallbackValue(FakeTopRatedMoviesEvent());
    registerFallbackValue(FakeTopRatedMoviesState());
    fakeTopRatedMovieBloc = FakeTopRatedMoviesBloc();

    TestWidgetsFlutterBinding.ensureInitialized();
  });

  tearDown(() {
    fakeNowPlayingMovieBloc.close();
    fakePopularMovieBloc.close();
    fakeTopRatedMovieBloc.close();
  });

  Widget createTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (context) => fakeNowPlayingMovieBloc,
        ),
        BlocProvider<PopularMovieBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  Widget createAnotherTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMovieBloc>(
          create: (context) => fakeNowPlayingMovieBloc,
        ),
        BlocProvider<PopularMovieBloc>(
          create: (context) => fakePopularMovieBloc,
        ),
        BlocProvider<TopRatedMovieBloc>(
          create: (context) => fakeTopRatedMovieBloc,
        ),
      ],
      child: body,
    );
  }

  final routes = <String, WidgetBuilder>{
    '/': (context) => const FakeHomePage(),
    '/next': (context) => createAnotherTestableWidget(const HomeMoviePage()),
    MovieDetailPage.ROUTE_NAME: (context) => const FakeDestination(),
    TopRatedMoviesPage.ROUTE_NAME: (context) => const FakeDestination(),
    PopularMoviesPage.ROUTE_NAME: (context) => const FakeDestination(),
    '/search': (context) => const FakeDestination(),
  };

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(() => fakeNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieLoading());
    when(() => fakePopularMovieBloc.state).thenReturn(PopularMovieLoading());
    when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(createTestableWidget(const HomeMoviePage()));

    expect(progressBarFinder, findsNWidgets(3));
  });

  testWidgets(
      'Page should display listview of now-playing-movies when HasData state occurred',
      (tester) async {
    when(() => fakeNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(createTestableWidget(const HomeMoviePage()));

    expect(listViewFinder, findsNWidgets(3));
  });

  testWidgets('Page should display error text when error', (tester) async {
    when(() => fakeNowPlayingMovieBloc.state)
        .thenReturn(const NowPlayingMovieError('failed'));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieError('failed'));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieError('failed'));

    await tester.pumpWidget(createTestableWidget(const HomeMoviePage()));

    expect(find.byKey(const Key('error')), findsNWidgets(3));
  });

  // testWidgets('Page should display empty text when empty', (tester) async {
  //   when(() => fakeNowPlayingMovieBloc.state)
  //       .thenReturn(NowPlayingMoviesEmpty());
  //   when(() => fakePopularMovieBloc.state).thenReturn(PopularMoviesEmpty());
  //   when(() => fakeTopRatedMovieBloc.state).thenReturn(TopRatedMoviesEmpty());
  //
  //   await tester.pumpWidget(createTestableWidget(const HomeMoviePage()));
  //
  //   expect(find.byKey(const Key('empty_message')), findsNWidgets(3));
  // });

  // testWidgets(
  //     'Doing action "tap" on see more (popular movies) should go to Popular Movies page',
  //     (tester) async {
  //   when(() => fakeNowPlayingMovieBloc.state)
  //       .thenReturn(NowPlayingMovieHasData(testMovieList));
  //   when(() => fakePopularMovieBloc.state)
  //       .thenReturn(PopularMovieHasData(testMovieList));
  //   when(() => fakeTopRatedMovieBloc.state)
  //       .thenReturn(TopRatedMovieHasData(testMovieList));
  //
  //   await tester.pumpWidget(MaterialApp(
  //     routes: routes,
  //   ));
  //
  //   expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);
  //
  //   await tester.tap(find.byKey(const Key('fakeHomePage')));
  //
  //   for (var i = 0; i < 5; i++) {
  //     await tester.pump(const Duration(seconds: 1));
  //   }
  //
  //   expect(find.byKey(const Key('see_more_popular_movies')), findsOneWidget);
  //   expect(find.byKey(const Key('see_more_top_rated_movies')), findsOneWidget);
  //
  //   // on tap testing
  //   await tester.dragUntilVisible(
  //     find.byKey(const Key('see_more_popular_movies')),
  //     find.byType(SingleChildScrollView),
  //     const Offset(0, 200),
  //   );
  //   await tester.tap(find.byKey(const Key('see_more_popular_movies')));
  //
  //   for (var i = 0; i < 5; i++) {
  //     await tester.pump(const Duration(seconds: 1));
  //   }
  //
  //   expect(find.byKey(const Key('see_more_popular_movies')), findsNothing);
  //   expect(find.byKey(const Key('see_more_top_rated_movies')), findsNothing);
  // });

  // testWidgets(
  //     'Doing action "tap" on see more (top rated movies) should go to top rated movies page',
  //     (tester) async {
  //   when(() => fakeNowPlayingMovieBloc.state)
  //       .thenReturn(NowPlayingMovieHasData(testMovieList));
  //   when(() => fakePopularMovieBloc.state)
  //       .thenReturn(PopularMovieHasData(testMovieList));
  //   when(() => fakeTopRatedMovieBloc.state)
  //       .thenReturn(TopRatedMovieHasData(testMovieList));
  //
  //   await tester.pumpWidget(MaterialApp(
  //     routes: routes,
  //   ));
  //
  //   expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);
  //
  //   await tester.tap(find.byKey(const Key('fakeHomePage')));
  //
  //   for (var i = 0; i < 5; i++) {
  //     await tester.pump(const Duration(seconds: 1));
  //   }
  //
  //   expect(find.byKey(const Key('see_more_popular_movies')), findsOneWidget);
  //   expect(find.byKey(const Key('see_more_top_rated_movies')), findsOneWidget);
  //
  //   // on tap testing
  //   await tester.dragUntilVisible(
  //     find.byKey(const Key('see_more_top_rated_movies')),
  //     find.byType(SingleChildScrollView),
  //     const Offset(0, 100),
  //   );
  //   await tester.tap(find.byKey(const Key('see_more_top_rated_movies')));
  //
  //   for (var i = 0; i < 5; i++) {
  //     await tester.pump(const Duration(seconds: 1));
  //   }
  //
  //   expect(find.byKey(const Key('see_more_popular_movies')), findsNothing);
  //   expect(find.byKey(const Key('see_more_top_rated_movies')), findsNothing);
  // });

  testWidgets(
      'Doing action "tap" on one of the Now Playing card should go to Movie Detail page',
      (tester) async {
    when(() => fakeNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('Now Playing-0')), findsOneWidget);
    expect(find.byKey(const Key('Popular-0')), findsOneWidget);
    expect(find.byKey(const Key('Top Rated-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('Now Playing-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('Now Playing-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('Now Playing-0')), findsNothing);
    expect(find.byKey(const Key('Popular-0')), findsNothing);
    expect(find.byKey(const Key('Top Rated-0')), findsNothing);
  });

  testWidgets(
      'Doing action "tap" on one of the Popular Movies card should go to Movie Detail page',
      (tester) async {
    when(() => fakeNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('Now Playing-0')), findsOneWidget);
    expect(find.byKey(const Key('Popular-0')), findsOneWidget);
    expect(find.byKey(const Key('Top Rated-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('Popular-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );

    await tester.tap(find.byKey(const Key('Popular-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('Now Playing-0')), findsNothing);
    expect(find.byKey(const Key('Popular-0')), findsNothing);
    expect(find.byKey(const Key('Top Rated-0')), findsNothing);
  });

  testWidgets(
      'Doing action "tap" on one of the Top Rated Movies card should go to Movie Detail page',
      (tester) async {
    when(() => fakeNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieHasData(testMovieList));
    when(() => fakePopularMovieBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));
    when(() => fakeTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));

    await tester.pumpWidget(MaterialApp(
      routes: routes,
    ));

    expect(find.byKey(const Key('fakeHomePage')), findsOneWidget);

    await tester.tap(find.byKey(const Key('fakeHomePage')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('Now Playing-0')), findsOneWidget);
    expect(find.byKey(const Key('Popular-0')), findsOneWidget);
    expect(find.byKey(const Key('Top Rated-0')), findsOneWidget);

    // on tap testing
    await tester.dragUntilVisible(
      find.byKey(const Key('Top Rated-0')),
      find.byType(SingleChildScrollView),
      const Offset(0, 100),
    );
    await tester.tap(find.byKey(const Key('Top Rated-0')));

    for (var i = 0; i < 5; i++) {
      await tester.pump(const Duration(seconds: 1));
    }

    expect(find.byKey(const Key('Now Playing-0')), findsNothing);
    expect(find.byKey(const Key('Popular-0')), findsNothing);
    expect(find.byKey(const Key('Top Rated-0')), findsNothing);
  });
}
