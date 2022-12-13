// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:series/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';

import '../../dummy_data/series_dummy_object.dart';

class MockTopRatedSeriesBloc
    extends MockBloc<TopRatedSeriesEvent, TopRatedSeriesState>
    implements TopRatedSeriesBloc {}

class TopRatedSeriesStateFake extends Fake implements TopRatedSeriesState {}

class TopRatedSeriesEventFake extends Fake implements TopRatedSeriesEvent {}

void main() {
  late MockTopRatedSeriesBloc mockTopRatedSeriesBloc;

  setUp(() {
    mockTopRatedSeriesBloc = MockTopRatedSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedSeriesBloc>(
      create: (context) => mockTopRatedSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(TopRatedSeriesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(
      makeTestableWidget(TopRatedSeriesPage()),
    );

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state)
        .thenReturn(TopRatedSeriesHasData(testSeriesList));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(
      makeTestableWidget(TopRatedSeriesPage()),
    );

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedSeriesBloc.state).thenReturn(TopRatedSeriesEmpty());

    final emptyMessage = find.text('Tidak Ada Data');

    await tester.pumpWidget(
      makeTestableWidget(TopRatedSeriesPage()),
    );

    expect(emptyMessage, findsOneWidget);
  });
}
