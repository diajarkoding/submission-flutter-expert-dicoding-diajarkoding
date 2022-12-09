import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/detail_movie/detail_movie_bloc.dart';
import '../../dummy_data/dummy_objects.dart';
import '../provider/movie_detail_notifier_test.mocks.dart';

void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late DetailMovieBloc detailMovieBloc;

  const testId = 1;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    detailMovieBloc = DetailMovieBloc(mockGetMovieDetail);
  });

  test('the initial state should be empty', () {
    expect(detailMovieBloc.state, DetailMovieEmpty());
  });
  blocTest<DetailMovieBloc, DetailMovieState>(
    'should emit Loading state and then HasData state when data successfully fetched',
    build: () {
      when(mockGetMovieDetail.execute(testId))
          .thenAnswer((_) async => const Right(testMovieDetail));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(OnDetailMovie(testId)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieHasData(testMovieDetail),
    ],
    verify: (bloc) {
      verify(mockGetMovieDetail.execute(testId));
      return OnDetailMovie(testId).props;
    },
  );

  blocTest<DetailMovieBloc, DetailMovieState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetMovieDetail.execute(testId))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return detailMovieBloc;
    },
    act: (bloc) => bloc.add(OnDetailMovie(testId)),
    expect: () => [
      DetailMovieLoading(),
      DetailMovieError('Server Failure'),
    ],
    verify: (bloc) => DetailMovieLoading(),
  );
}
