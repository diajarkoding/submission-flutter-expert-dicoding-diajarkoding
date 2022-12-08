import 'package:series/data/models/series/series_detail_model.dart';
import 'package:series/domain/entities/series_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSeriesDetailModel = SeriesDetailModel(
    adult: false,
    backdropPath: "/3N3bUR0M9x3W5745KBFhXHawJrl.jpg",
    createdBy: [],
    episodeRunTime: [60],
    firstAirDate: "2004-01-12",
    genreModelSeries: [
      GenreModelSeries(id: 18, name: "Drama"),
    ],
    homepage: "https://www.fujitv.co.jp/b_hp/m9_pride/",
    id: 1,
    inProduction: false,
    languages: ["ja"],
    lastAirDate: "2004-03-22",
    name: "Pride",
    nextEpisodeToAir: null,
    numberOfEpisodes: 11,
    numberOfSeasonModel: 1,
    originCountry: ["JP"],
    originalLanguage: "ja",
    originalName: "プライド",
    overview:
        "The theme is strength and gallantry.Haru Satonaka is the captain of an ice-hockey team, a star athlete who stakes everything on hockey but can only consider love as a game. Aki Murase is a woman who has been waiting for her lover who went abroad two years ago. These two persons start a relationship while frankly admitting to each other that it is only a love game. …The result is the unfolding of a drama of people with their respective pasts and with their pride as individuals.",
    popularity: 4.046,
    posterPath: "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
    productionCompanies: [],
    seasonModel: [
      SeasonModel(
        airDate: "2004-01-12",
        episodeCount: 11,
        id: 2328126,
        name: "Season 1",
        overview: "",
        posterPath: "/nCcGD18HmDFunCl8KBigqUPlIi8.jpg",
        seasonNumber: 1,
      ),
    ],
    status: "Ended",
    tagline: "",
    type: "Scripted",
    voteAverage: 8.136,
    voteCount: 11,
  );

  final tSeriesDetail = SeriesDetail(
    adult: false,
    backdropPath: "/3N3bUR0M9x3W5745KBFhXHawJrl.jpg",
    createdBy: [],
    episodeRunTime: [60],
    firstAirDate: "2004-01-12",
    genres: [
      GenreSeries(id: 18, name: "Drama"),
    ],
    homepage: "https://www.fujitv.co.jp/b_hp/m9_pride/",
    id: 1,
    inProduction: false,
    languages: ["ja"],
    lastAirDate: "2004-03-22",
    name: "Pride",
    nextEpisodeToAir: null,
    numberOfEpisodes: 11,
    numberOfSeasons: 1,
    originCountry: ["JP"],
    originalLanguage: "ja",
    originalName: "プライド",
    overview:
        "The theme is strength and gallantry.Haru Satonaka is the captain of an ice-hockey team, a star athlete who stakes everything on hockey but can only consider love as a game. Aki Murase is a woman who has been waiting for her lover who went abroad two years ago. These two persons start a relationship while frankly admitting to each other that it is only a love game. …The result is the unfolding of a drama of people with their respective pasts and with their pride as individuals.",
    popularity: 4.046,
    posterPath: "/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg",
    productionCompanies: [],
    seasons: [
      Season(
        airDate: "2004-01-12",
        episodeCount: 11,
        id: 2328126,
        name: "Season 1",
        overview: "",
        posterPath: "/nCcGD18HmDFunCl8KBigqUPlIi8.jpg",
        seasonNumber: 1,
      ),
    ],
    status: "Ended",
    tagline: "",
    type: "Scripted",
    voteAverage: 8.136,
    voteCount: 11,
  );

  test('should be a subclass of Series Detail entity', () async {
    final result = tSeriesDetailModel.toEntity();
    expect(result, tSeriesDetail);
  });
}
