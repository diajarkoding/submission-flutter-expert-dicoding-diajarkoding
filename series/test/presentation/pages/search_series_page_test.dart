// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/bloc/search_series/search_series_bloc.dart';

import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/pages/search_series_page.dart';

import '../../dummy_data/series_dummy_object.dart';

class FakeSearchSeriesEvent extends Fake implements SearchSeriesEvent {}

class FakeSearchSeriesState extends Fake implements SearchSeriesState {}

class FakeSearchSeriesBloc
    extends MockBloc<SearchSeriesEvent, SearchSeriesState>
    implements SearchSeriesBloc {}

void main() {
  late FakeSearchSeriesBloc fakeSearchSeriesBloc;

  setUp(() {
    registerFallbackValue(FakeSearchSeriesEvent());
    registerFallbackValue(FakeSearchSeriesState());
    fakeSearchSeriesBloc = FakeSearchSeriesBloc();
  });

  tearDown(() {
    fakeSearchSeriesBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchSeriesBloc>(
      create: (context) => fakeSearchSeriesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('search series test cases', () {
    testWidgets(
      "Page should display Loading indicator when data is loading",
      (WidgetTester tester) async {
        when(() => fakeSearchSeriesBloc.state).thenReturn(SearchLoading());

        final progressbarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(makeTestableWidget(
          const SearchSeriesPage(),
        ));

        expect(progressbarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when data is gotten successful",
      (WidgetTester tester) async {
        when(() => fakeSearchSeriesBloc.state)
            .thenReturn(SearchHasData(testSeriesList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(makeTestableWidget(
          const SearchSeriesPage(),
        ));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error message when data failed to fetch",
      (WidgetTester tester) async {
        when(() => fakeSearchSeriesBloc.state)
            .thenReturn(const SearchError('failed'));

        final errorKeyFinder = find.byKey(const Key('error'));

        await tester.pumpWidget(makeTestableWidget(
          const SearchSeriesPage(),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(errorKeyFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display empty message when the searched data is empty",
      (WidgetTester tester) async {
        when(() => fakeSearchSeriesBloc.state).thenReturn(SearchEmpty());

        final emptyKeyFinder = find.byKey(const Key('empty'));

        await tester.pumpWidget(makeTestableWidget(
          const SearchSeriesPage(),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(emptyKeyFinder, findsOneWidget);
      },
    );
  });
}
