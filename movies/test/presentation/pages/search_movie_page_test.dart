// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/presentation/bloc/search_movie/search_movie_bloc.dart';

import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/pages/search_page.dart';

import '../../dummy_data/dummy_objects.dart';

class FakeSearchMoviesEvent extends Fake implements SearchMovieEvent {}

class FakeSearchMoviesState extends Fake implements SearchMovieState {}

class FakeSearchMoviesBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

void main() {
  late FakeSearchMoviesBloc fakeSearchMoviesBloc;

  setUp(() {
    registerFallbackValue(FakeSearchMoviesEvent());
    registerFallbackValue(FakeSearchMoviesState());
    fakeSearchMoviesBloc = FakeSearchMoviesBloc();
  });

  tearDown(() {
    fakeSearchMoviesBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieBloc>(
      create: (context) => fakeSearchMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('search movies test cases', () {
    testWidgets(
      "Page should display Loading indicator when data is loading",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state).thenReturn(SearchLoading());

        final progressbarFinder = find.byType(CircularProgressIndicator);

        await tester.pumpWidget(makeTestableWidget(
          const SearchPage(),
        ));

        expect(progressbarFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display ListView when data is gotten successful",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state)
            .thenReturn(SearchHasData(testMovieList));

        final listViewFinder = find.byType(ListView);

        await tester.pumpWidget(makeTestableWidget(
          const SearchPage(),
        ));

        expect(listViewFinder, findsOneWidget);
      },
    );

    testWidgets(
      "Page should display error message when data failed to fetch",
      (WidgetTester tester) async {
        when(() => fakeSearchMoviesBloc.state)
            .thenReturn(const SearchError('failed'));

        final errorKeyFinder = find.byKey(const Key('error'));

        await tester.pumpWidget(makeTestableWidget(
          const SearchPage(),
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
        when(() => fakeSearchMoviesBloc.state).thenReturn(SearchEmpty());

        final emptyKeyFinder = find.byKey(const Key('empty'));

        await tester.pumpWidget(makeTestableWidget(
          const SearchPage(),
        ));

        for (var i = 0; i < 5; i++) {
          await tester.pump(const Duration(seconds: 1));
        }

        expect(emptyKeyFinder, findsOneWidget);
      },
    );
  });
}
