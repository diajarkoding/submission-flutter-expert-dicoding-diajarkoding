import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/utils.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/presentation/pages/now_playing_series_page.dart';
import 'package:series/presentation/pages/popular_series_page.dart';
import 'package:series/presentation/pages/search_series_page.dart';
import 'package:series/presentation/pages/series_detail_page.dart';
import 'package:series/presentation/pages/top_rated_series_page.dart';
import 'package:series/presentation/provider/series_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:series/presentation/provider/watchlist_series_notifier.dart';
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
      Provider.of<SeriesListNotifier>(context, listen: false)
        ..fetchNowPlayingSeries()
        ..fetchPopularSeries()
        ..fetchTopRatedSeries();
      Provider.of<WatchlistSeriesNotifier>(context, listen: false)
          .fetchWatchlistSeries();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistSeriesNotifier>(context, listen: false)
        .fetchWatchlistSeries();
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
        const Tab(
          text: 'Series',
        ),
        const Tab(
          text: 'Watchlist',
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
          child: Consumer<WatchlistSeriesNotifier>(
            builder: (context, data, child) {
              if (data.watchlistState == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.watchlistState == RequestState.Loaded) {
                return Column(
                  children: data.watchlistSeries
                      .map((series) => SeriesCard(series))
                      .toList(),
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(data.message),
                );
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
          Consumer<SeriesListNotifier>(builder: (context, data, child) {
            final state = data.nowPlayingState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return SeriesList(data.nowPlayingSeries);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'Popular',
            onTap: () =>
                Navigator.pushNamed(context, PopularSeriesPage.ROUTE_NAME),
          ),
          Consumer<SeriesListNotifier>(builder: (context, data, child) {
            final state = data.popularSeriesState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return SeriesList(data.popularSeries);
            } else {
              return Text('Failed');
            }
          }),
          _buildSubHeading(
            title: 'Top Rated',
            onTap: () =>
                Navigator.pushNamed(context, TopRatedSeriesPage.ROUTE_NAME),
          ),
          Consumer<SeriesListNotifier>(builder: (context, data, child) {
            final state = data.topRatedSeriesState;
            if (state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded) {
              return SeriesList(data.topRatedSeries);
            } else {
              return Text('Failed');
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
  final List<Series> seriesList;

  SeriesList(this.seriesList);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = seriesList[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SeriesDetailPage.ROUTE_NAME,
                  arguments: series.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: seriesList.length,
      ),
    );
  }
}
