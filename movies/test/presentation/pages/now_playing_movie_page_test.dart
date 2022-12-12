// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/now_playing_movie/now_playing_movie_bloc.dart';
import 'package:movies/presentation/pages/now_playing_movies_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockNowPlayingMovieBloc
    extends MockBloc<NowPlayingMovieEvent, NowPlayingMovieState>
    implements NowPlayingMovieBloc {}

void main() {
  late MockNowPlayingMovieBloc mockNowPlayingMovieBloc;

  setUp(() {
    mockNowPlayingMovieBloc = MockNowPlayingMovieBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingMovieBloc>(
      create: (context) => mockNowPlayingMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
      makeTestableWidget(const NowPlayingMoviePage()),
    );

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieHasData(testMovieList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      makeTestableWidget(const NowPlayingMoviePage()),
    );

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingMovieBloc.state)
        .thenReturn(NowPlayingMovieEmpty());

    final emptyMessage = find.text('Tidak Ada Data');

    await tester.pumpWidget(
      makeTestableWidget(const NowPlayingMoviePage()),
    );

    expect(emptyMessage, findsOneWidget);
  });
}
