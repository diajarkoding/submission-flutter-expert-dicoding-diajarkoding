// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:series/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/presentation/pages/popular_series_page.dart';

import '../../dummy_data/series_dummy_object.dart';

class MockPopularSeriesBloc
    extends MockBloc<PopularSeriesEvent, PopularSeriesState>
    implements PopularSeriesBloc {}

void main() {
  late MockPopularSeriesBloc mockPopularSeriesBloc;

  setUp(() {
    mockPopularSeriesBloc = MockPopularSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularSeriesBloc>(
      create: (context) => mockPopularSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state).thenReturn(PopularSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
      makeTestableWidget(const PopularSeriesPage()),
    );

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state)
        .thenReturn(PopularSeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      makeTestableWidget(const PopularSeriesPage()),
    );

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularSeriesBloc.state).thenReturn(PopularSeriesEmpty());

    final emptyMessage = find.text('Tidak Ada Data');

    await tester.pumpWidget(
      makeTestableWidget(const PopularSeriesPage()),
    );

    expect(emptyMessage, findsOneWidget);
  });
}
