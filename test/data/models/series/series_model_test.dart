import 'package:ditonton/data/models/series/series_model.dart';
import 'package:ditonton/domain/entities/series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesModel = SeriesModel(
    backdropPath: "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
    firstAirDate: "2021-10-12",
    genreIds: [80, 10765],
    id: 90462,
    name: "Chucky",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 3545.458,
    posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
    voteAverage: 7.9,
    voteCount: 3466,
  );

  final tSeries = Series(
    adult: null,
    backdropPath: "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
    firstAirDate: "2021-10-12",
    genreIds: [80, 10765],
    id: 90462,
    mediaType: null,
    name: "Chucky",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Chucky",
    overview:
        "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
    popularity: 3545.458,
    posterPath: "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
    voteAverage: 7.9,
    voteCount: 3466,
  );

  test('should be a subclass of Movie entity', () async {
    final result = tSeriesModel.toEntity();
    expect(result, tSeries);
  });
}
