// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:series/presentation/bloc/detail_series/detail_series_bloc.dart';
import 'package:series/presentation/bloc/recommendation_series/recommendation_series_bloc.dart';
import 'package:series/presentation/bloc/watchlist_series/watchlist_series_bloc.dart';

import 'package:mocktail/mocktail.dart';
import 'package:series/presentation/pages/series_detail_page.dart';

import '../../dummy_data/series_dummy_object.dart';

class FakeSeriesDetailEvent extends Fake implements DetailSeriesEvent {}

class FakeSeriesDetailState extends Fake implements DetailSeriesState {}

class FakeSeriesDetailBloc
    extends MockBloc<DetailSeriesEvent, DetailSeriesState>
    implements DetailSeriesBloc {}

/// fake series recommendations bloc
class FakeSeriesRecommendationsEvent extends Fake
    implements RecommendationSeriesEvent {}

class FakeSeriesRecommendationsState extends Fake
    implements RecommendationSeriesState {}

class FakeSeriesRecommendationsBloc
    extends MockBloc<RecommendationSeriesEvent, RecommendationSeriesState>
    implements RecommendationSeriesBloc {}

/// fake watchlist series bloc
class FakeWatchlistSeriessEvent extends Fake implements WatchListSeriesEvent {}

class FakeWatchlistSeriessState extends Fake implements WatchListSeriesState {}

class FakeWatchlistSeriessBloc
    extends MockBloc<WatchListSeriesEvent, WatchListSeriesState>
    implements WatchListSeriesBloc {}

void main() {
  late FakeSeriesDetailBloc fakeSeriesDetailBloc;
  late FakeWatchlistSeriessBloc fakeWatchlistSeriessBloc;
  late FakeSeriesRecommendationsBloc fakeSeriesRecommendationsBloc;

  setUpAll(() {
    registerFallbackValue(FakeSeriesDetailEvent());
    registerFallbackValue(FakeSeriesDetailState());
    fakeSeriesDetailBloc = FakeSeriesDetailBloc();

    registerFallbackValue(FakeWatchlistSeriessEvent());
    registerFallbackValue(FakeWatchlistSeriessState());
    fakeWatchlistSeriessBloc = FakeWatchlistSeriessBloc();

    registerFallbackValue(FakeSeriesRecommendationsEvent());
    registerFallbackValue(FakeSeriesRecommendationsState());
    fakeSeriesRecommendationsBloc = FakeSeriesRecommendationsBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DetailSeriesBloc>(
          create: (_) => fakeSeriesDetailBloc,
        ),
        BlocProvider<WatchListSeriesBloc>(
          create: (_) => fakeWatchlistSeriessBloc,
        ),
        BlocProvider<RecommendationSeriesBloc>(
          create: (_) => fakeSeriesRecommendationsBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  tearDown(() {
    fakeSeriesDetailBloc.close();
    fakeWatchlistSeriessBloc.close();
    fakeSeriesRecommendationsBloc.close();
  });

  const testId = 1;

  testWidgets('Page should display progress bar when start to retrieve data',
      (WidgetTester tester) async {
    when(() => fakeSeriesDetailBloc.state).thenReturn(DetailSeriesLoading());
    when(() => fakeWatchlistSeriessBloc.state)
        .thenReturn(WatchListSeriesLoading());
    when(() => fakeSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationSeriesLoading());

    final progressbarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(progressbarFinder, findsOneWidget);
  });

  testWidgets('All required widget should display',
      (WidgetTester tester) async {
    when(() => fakeSeriesDetailBloc.state)
        .thenReturn(DetailSeriesHasData(testSeriesDetail));
    when(() => fakeWatchlistSeriessBloc.state)
        .thenReturn(WatchListSeriesHasData(testSeriesList));
    when(() => fakeSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationSeriesHasData(testSeriesList));

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Recommendations'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when series not added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeSeriesDetailBloc.state)
        .thenReturn(DetailSeriesHasData(testSeriesDetail));
    when(() => fakeWatchlistSeriessBloc.state)
        .thenReturn(WatchListSeriesIsAdded(false));
    when(() => fakeSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationSeriesHasData(testSeriesList));

    final watchlistButtonIconFinder = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when series is added to watchlist',
      (WidgetTester tester) async {
    when(() => fakeSeriesDetailBloc.state)
        .thenReturn(DetailSeriesHasData(testSeriesDetail));
    when(() => fakeWatchlistSeriessBloc.state)
        .thenReturn(WatchListSeriesIsAdded(true));
    when(() => fakeSeriesRecommendationsBloc.state)
        .thenReturn(RecommendationSeriesHasData(testSeriesList));

    final watchlistButtonIconFinder = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const SeriesDetailPage(
      id: testId,
    )));
    await tester.pump();

    expect(watchlistButtonIconFinder, findsOneWidget);
  });
}
