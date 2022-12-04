import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/series/series_list_notifier.dart';
import 'package:ditonton/presentation/widgets/series_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-series';

  @override
  _NowPlayingSeriesPageState createState() => _NowPlayingSeriesPageState();
}

class _NowPlayingSeriesPageState extends State<NowPlayingSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<SeriesListNotifier>(context, listen: false)
            .fetchNowPlayingSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SeriesListNotifier>(
          builder: (context, data, child) {
            if (data.nowPlayingState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.nowPlayingState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final series = data.nowPlayingSeries[index];
                  return SeriesCard(series);
                },
                itemCount: data.nowPlayingSeries.length,
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
    );
  }
}
