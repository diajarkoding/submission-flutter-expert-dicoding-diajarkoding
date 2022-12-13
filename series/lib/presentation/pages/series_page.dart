import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/bloc/now_playing_series/now_playing_series_bloc.dart';
import 'package:series/presentation/bloc/popular_series/popular_series_bloc.dart';
import 'package:series/presentation/bloc/top_rated_series/top_rated_series_bloc.dart';
import 'package:series/presentation/bloc/watchlist_series/watchlist_series_bloc.dart';
import 'package:series/presentation/pages/now_playing_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:flutter/material.dart';
import 'package:series/presentation/widgets/series_card.dart';

class SeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/list-series';

  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage>
    with TickerProviderStateMixin, RouteAware {
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
    Future.microtask(() {
      Future.microtask(() {
        context.read<NowPlayingSeriesBloc>().add(OnNowPLayingSeries());
        context.read<TopRatedSeriesBloc>().add(OnTopRatedSeries());
        context.read<PopularSeriesBloc>().add(OnPopularSeries());
      });
      BlocProvider.of<WatchListSeriesBloc>(context, listen: false)
          .add(OnFetchWatchListSeries());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    BlocProvider.of<WatchListSeriesBloc>(context, listen: false)
        .add(OnFetchWatchListSeries());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  late TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchSeriesPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              tabBarView(),
              tabBar(),
            ],
          )),
    );
  }

  Widget tabBar() {
    return TabBar(
      indicator: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
      tabs: [
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.live_tv),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.5),
                child: Text('Series'),
              ),
            ],
          ),
        ),
        Tab(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.save_alt),
              SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2.5),
                child: Text('Watchlist'),
              ),
            ],
          ),
        )
      ],
      controller: tabController,
    );
  }

  Widget tabBarView() {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
      child: TabBarView(
        controller: tabController,
        children: [
          listSeries(),
          watchList(),
        ],
      ),
    );
  }

  Widget watchList() {
    return ListView(
      padding: EdgeInsets.only(top: 7),
      children: [
        Text(
          'Watchlist Series',
          style: kHeading6,
        ),
        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<WatchListSeriesBloc, WatchListSeriesState>(
            builder: (context, state) {
              if (state is WatchListSeriesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WatchListSeriesHasData) {
                return Column(
                  children: state.result
                      .map(
                        (series) => SeriesCard(series),
                      )
                      .toList(),
                );
              } else if (state is WatchListSeriesEmpty) {
                return Center(
                    child: Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: Text('Anda belum menambahkan watchlist'),
                ));
              } else {
                return const Center(child: Text('Failed'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget listSeries() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubHeading(
            title: 'Now Playing',
            onTap: () =>
                Navigator.pushNamed(context, NowPlayingSeriesPage.ROUTE_NAME),
          ),
          BlocBuilder<NowPlayingSeriesBloc, NowPlayingSeriesState>(
              builder: (context, state) {
            if (state is NowPlayingSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is NowPlayingSeriesHasData) {
              final data = state.result;
              return SeriesList(data, 'Now Playing');
            } else if (state is NowPlayingSeriesError) {
              return const Text(
                'Failed',
                key: Key('error'),
              );
            } else {
              return Container();
            }
          }),
          _buildSubHeading(
            title: 'Popular',
            onTap: () =>
                Navigator.pushNamed(context, PopularSeriesPage.ROUTE_NAME),
          ),
          BlocBuilder<PopularSeriesBloc, PopularSeriesState>(
              builder: (context, state) {
            if (state is PopularSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PopularSeriesHasData) {
              final data = state.result;
              return SeriesList(data, 'Popular');
            } else if (state is PopularSeriesError) {
              return const Text(
                'Failed',
                key: Key('error'),
              );
            } else {
              return Container();
            }
          }),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () =>
                Navigator.pushNamed(context, TopRatedSeriesPage.ROUTE_NAME),
          ),
          BlocBuilder<TopRatedSeriesBloc, TopRatedSeriesState>(
              builder: (context, state) {
            if (state is TopRatedSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedSeriesHasData) {
              final data = state.result;
              return SeriesList(data, 'Top Rated');
            } else if (state is TopRatedSeriesError) {
              return const Text(
                'Failed',
                key: Key('error'),
              );
            } else {
              return Container();
            }
          }),
        ],
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class SeriesList extends StatelessWidget {
  final List<Series> movies;
  final String keyText;

  const SeriesList(
    this.movies,
    this.keyText, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            key: Key("$keyText-$index"),
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
