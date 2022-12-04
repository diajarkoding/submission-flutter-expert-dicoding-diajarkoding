import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NowPlayingMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-movies';

  @override
  _NowPlayingMoviePageState createState() => _NowPlayingMoviePageState();
}

class _NowPlayingMoviePageState extends State<NowPlayingMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<MovieListNotifier>(context, listen: false)
            .fetchNowPlayingMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Now Playing Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<MovieListNotifier>(
          builder: (context, data, child) {
            if (data.nowPlayingState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.nowPlayingState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.nowPlayingMovies[index];
                  return MovieCard(movie);
                },
                itemCount: data.nowPlayingMovies.length,
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
