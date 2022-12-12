// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_movie_bloc.dart';
import 'package:movies/presentation/pages/watchlist_movies_page.dart';
import 'package:movies/presentation/widget/movie_card.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeWatchlistMovieEvent extends Fake implements WatchListMovieEvent {}

class FakeWatchlistMovieState extends Fake implements WatchListMovieState {}

class FakeWatchlistMovieBloc
    extends MockBloc<WatchListMovieEvent, WatchListMovieState>
    implements WatchListMovieBloc {}

void main() {
  late FakeWatchlistMovieBloc fakeWatchlistMovieBloc;

  setUpAll(() {
    registerFallbackValue(FakeWatchlistMovieEvent());
    registerFallbackValue(FakeWatchlistMovieState());
    fakeWatchlistMovieBloc = FakeWatchlistMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchListMovieBloc>(
      create: (_) => fakeWatchlistMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeWatchlistMovieBloc.close();
  });

  group('watchlist movies', () {
    testWidgets('loading indicator should display when getting data',
        (WidgetTester tester) async {
      when(() => fakeWatchlistMovieBloc.state)
          .thenReturn(WatchListMovieLoading());

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('watchlist movies should display', (WidgetTester tester) async {
      when(() => fakeWatchlistMovieBloc.state)
          .thenReturn(WatchListMovieHasData(testMovieList));

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(MovieCard), findsWidgets);
    });

    testWidgets('message for feedback should display when data is empty',
        (WidgetTester tester) async {
      when(() => fakeWatchlistMovieBloc.state)
          .thenReturn(WatchListMovieEmpty());

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(find.text('Anda belum menambahkan watchlist'), findsOneWidget);
    });
  });
}
