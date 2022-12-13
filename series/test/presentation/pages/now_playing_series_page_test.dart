// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';
import 'package:series/presentation/pages/now_playing_series_page.dart';

import '../../dummy_data/series_dummy_object.dart';

class MockNowPlayingSeriesBloc
    extends MockBloc<NowPlayingSeriesEvent, NowPlayingSeriesState>
    implements NowPlayingSeriesBloc {}

void main() {
  late MockNowPlayingSeriesBloc mockNowPlayingSeriesBloc;

  setUp(() {
    mockNowPlayingSeriesBloc = MockNowPlayingSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<NowPlayingSeriesBloc>(
      create: (context) => mockNowPlayingSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockNowPlayingSeriesBloc.state)
        .thenReturn(NowPlayingSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
      makeTestableWidget(const NowPlayingSeriesPage()),
    );

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockNowPlayingSeriesBloc.state)
        .thenReturn(NowPlayingSeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      makeTestableWidget(const NowPlayingSeriesPage()),
    );

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockNowPlayingSeriesBloc.state)
        .thenReturn(NowPlayingSeriesEmpty());

    final emptyMessage = find.text('Tidak Ada Data');

    await tester.pumpWidget(
      makeTestableWidget(const NowPlayingSeriesPage()),
    );

    expect(emptyMessage, findsOneWidget);
  });
}
