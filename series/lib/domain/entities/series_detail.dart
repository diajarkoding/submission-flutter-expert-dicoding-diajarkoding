import 'package:equatable/equatable.dart';

class SeriesDetail extends Equatable {
  SeriesDetail({
    required this.adult,
    required this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.name,
    required this.nextEpisodeToAir,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    required this.originalLanguage,
    this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    this.seasons,
    required this.status,
    required this.tagline,
    this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String backdropPath;
  final List? createdBy;
  final List? episodeRunTime;
  final String? firstAirDate;
  final List<GenreSeries> genres;
  final String homepage;
  final int id;
  final bool? inProduction;
  final List? languages;
  final String? lastAirDate;
  final String? name;
  final dynamic nextEpisodeToAir;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List? originCountry;
  final String originalLanguage;
  final String? originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<dynamic> productionCompanies;
  final List<Season>? seasons;
  final String status;
  final String tagline;
  final String? type;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genres,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        nextEpisodeToAir,
        numberOfEpisodes,
        numberOfSeasons,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        seasons,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

class GenreSeries extends Equatable {
  GenreSeries({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

class Season extends Equatable {
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;

  @override
  List<Object?> get props => [
        airDate,
        episodeCount,
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
      ];
}
