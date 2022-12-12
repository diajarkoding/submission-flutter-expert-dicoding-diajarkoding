// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import 'package:movies/presentation/bloc/recommendation_movie/recommendation_movie_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';

import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeMovieDetailEvent extends Fake implements DetailMovieEvent {}

class FakeMovieDetailState extends Fake implements DetailMovieState {}

class FakeMovieDetailBloc extends MockBloc<DetailMovieEvent, DetailMovieState>
    implements DetailMovieBloc {}

/// fake movie recommendations bloc
class FakeMovieRecommendationsEvent extends Fake
    implements RecommendationMovieEvent {}

class FakeMovieRecommendationsState extends Fake
    implements RecommendationMovieState {}

class FakeMovieRecommendationsBloc
    extends MockBloc<RecommendationMovieEvent, RecommendationMovieState>
    implements RecommendationMovieBloc {}

/// fake watchlist movies bloc
class FakeWatchlistMoviesEvent extends Fake implements WatchListMovieEvent {}

class FakeWatchlistMoviesState extends Fake implements WatchListMovieState {}

class FakeWatchlistMoviesBloc
    extends MockBloc<WatchListMovieEvent, WatchListMovieState>
    implements WatchListMovieBloc {}

void main() {
  late FakeMovieDetailBloc fakeMovieDetailBloc;
  late FakeWatchlistMoviesBloc fakeWatchlistMoviesBloc;
  late FakeMovieRecommendationsBloc fakeMovieRecommendationsBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    fakeMovieDetailBloc = FakeMovieDetailBloc();

    registerFallbackValue(FakeWatchlistMoviesEvent());
    registerFallbackValue(FakeWatchlistMoviesState());
    fakeWatchlistMoviesBloc = FakeWatchlistMoviesBloc();

    registerFallbackValue(FakeMovieRecommendationsEvent());
    registerFallbackValue(FakeMovieRecommendationsState());
    fakeMovieRecommendationsBloc = FakeMovieRecommendationsBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailMovieBloc>(
          create: (_) => fakeMovieDetailBloc,
        ),
        BlocProvider<WatchListMovieBloc>(
          create: (_) => fakeWatchlistMoviesBloc,
        ),
        BlocProvider<RecommendationMovieBloc>(
          create: (_) => fakeMovieRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeMovieDetailBloc.close();
    fakeWatchlistMoviesBloc.close();
    fakeMovieRecommendationsBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display progress bar when start to retrieve data',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state).thenReturn(DetailMovieLoading());
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchListMovieLoading());
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMovieLoading());

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });

  testWidgets('All required widget should display',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchListMovieHasData(testMovieList));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMovieHasData(testMovieList));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchListMovieIsAdded(false));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMovieHasData(testMovieList));

    final watchlistButtonIconFinder = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeMovieDetailBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    when(() => fakeWatchlistMoviesBloc.state)
        .thenReturn(WatchListMovieIsAdded(true));
    when(() => fakeMovieRecommendationsBloc.state)
        .thenReturn(RecommendationMovieHasData(testMovieList));

    final watchlistButtonIconFinder = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });
}
