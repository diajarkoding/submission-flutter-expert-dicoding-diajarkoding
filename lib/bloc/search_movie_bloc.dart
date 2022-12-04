import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/movies/search_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final SearchMovies _searchMovies;

  SearchMovieBloc(this._searchMovies) : super(SearchEmpty()) {
    on<OnQueryChanged>(
      (event, emit) async {
        final query = event.query;
        print(query);

        emit(SearchLoading());

        final result = await _searchMovies.execute(query);

        result.fold(
          (failure) {
            emit(SearchError(failure.message));
          },
          (data) {
            emit(SearchHasData(data));
          },
        );
      },
      transformer: debounce(
        const Duration(milliseconds: 500),
      ),
    );
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
