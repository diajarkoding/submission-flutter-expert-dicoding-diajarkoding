import 'package:series/data/models/series/series_table.dart';
import 'package:series/domain/entities/series.dart';
import 'package:series/domain/entities/series_detail.dart';

final testSeries = Series(
  adult: false,
  backdropPath: null,
  id: 1382,
  name: "Engine",
  originalLanguage: "ja",
  originalName: "エンジン",
  overview:
      "Jiro Kanzaki is an F3000 test driver blessed with acute sensitivity and breathtaking driving techniques. He's a daredevil who feels no fear driving at speeds that even top racers dare not attempt. But unexpected trouble forces this world-famous racer to leave his team and return to Japan for the first time in years. Until he finds a new job as a racer, Jiro decides to stay with his parents. What awaits Jiro there is his hardheaded father, his nagging sister, the 12 children of the foster home his father runs, a snobbish male nurse, and a stubborn female nurse who likes to daydream about her life.",
  posterPath: "/rFL0ZXxBKprVuERMGO1ROGpEq45.jpg",
  mediaType: "tv",
  genreIds: [35],
  popularity: 2.562,
  firstAirDate: "2005-04-18",
  voteAverage: 7.8,
  voteCount: 4,
  originCountry: ["JP"],
);

final testSeriesList = [testSeries];

final testSeriesDetail = SeriesDetail(
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

final testSeriesTable = SeriesTable(
  id: 1,
  name: 'Pride',
  posterPath: '/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg',
  overview:
      'The theme is strength and gallantry.Haru Satonaka is the captain of an ice-hockey team, a star athlete who stakes everything on hockey but can only consider love as a game. Aki Murase is a woman who has been waiting for her lover who went abroad two years ago. These two persons start a relationship while frankly admitting to each other that it is only a love game. …The result is the unfolding of a drama of people with their respective pasts and with their pride as individuals.',
);

final testSeriesMap = {
  'id': 1,
  'overview':
      'The theme is strength and gallantry.Haru Satonaka is the captain of an ice-hockey team, a star athlete who stakes everything on hockey but can only consider love as a game. Aki Murase is a woman who has been waiting for her lover who went abroad two years ago. These two persons start a relationship while frankly admitting to each other that it is only a love game. …The result is the unfolding of a drama of people with their respective pasts and with their pride as individuals.',
  'posterPath': '/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg',
  'title': 'Pride',
};

final testWatchlistSeries = Series.watchlist(
  id: 1,
  name: 'Pride',
  posterPath: '/9Ub2BwnLYKoiSaQF93ItyXriCon.jpg',
  overview:
      'The theme is strength and gallantry.Haru Satonaka is the captain of an ice-hockey team, a star athlete who stakes everything on hockey but can only consider love as a game. Aki Murase is a woman who has been waiting for her lover who went abroad two years ago. These two persons start a relationship while frankly admitting to each other that it is only a love game. …The result is the unfolding of a drama of people with their respective pasts and with their pride as individuals.',
);
