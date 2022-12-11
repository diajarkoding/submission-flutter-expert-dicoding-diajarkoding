// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movies/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockPopularMovieBloc
    extends MockBloc<PopularMovieEvent, PopularMovieState>
    implements PopularMovieBloc {}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>(
      create: (context) => mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(PopularMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
      makeTestableWidget(const PopularMoviesPage()),
    );

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state)
        .thenReturn(PopularMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      makeTestableWidget(const PopularMoviesPage()),
    );

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularMovieBloc.state).thenReturn(PopularMovieEmpty());

    final emptyMessage = find.text('Tidak Ada Data');

    await tester.pumpWidget(
      makeTestableWidget(const PopularMoviesPage()),
    );

    expect(emptyMessage, findsOneWidget);
  });
}
