// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:movies/presentation/bloc/top_rated_movie/top_rated_movie_bloc.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedMovieBloc
    extends MockBloc<TopRatedMovieEvent, TopRatedMovieState>
    implements TopRatedMovieBloc {}

class TopRatedMovieStateFake extends Fake implements TopRatedMovieState {}

class TopRatedMovieEventFake extends Fake implements TopRatedMovieEvent {}

void main() {
  late MockTopRatedMovieBloc mockTopRatedMovieBloc;

  setUp(() {
    mockTopRatedMovieBloc = MockTopRatedMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMovieBloc>(
      create: (context) => mockTopRatedMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedMovieBloc.state).thenReturn(TopRatedMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
      makeTestableWidget(const TopRatedMoviesPage()),
    );

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedMovieBloc.state)
        .thenReturn(TopRatedMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      makeTestableWidget(const TopRatedMoviesPage()),
    );

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedMovieBloc.state).thenReturn(TopRatedMovieEmpty());

    final emptyMessage = find.text('Tidak Ada Data');

    await tester.pumpWidget(
      makeTestableWidget(const TopRatedMoviesPage()),
    );

    expect(emptyMessage, findsOneWidget);
  });
}
