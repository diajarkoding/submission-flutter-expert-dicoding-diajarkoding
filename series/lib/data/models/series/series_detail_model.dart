import 'package:series/domain/entities/series_detail.dart';
import 'package:equatable/equatable.dart';

class SeriesDetailModel extends Equatable {
  SeriesDetailModel({
    required this.adult,
    required this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    required this.genreModelSeries,
    required this.homepage,
    required this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.name,
    required this.nextEpisodeToAir,
    this.numberOfEpisodes,
    this.numberOfSeasonModel,
    this.originCountry,
    required this.originalLanguage,
    this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    this.seasonModel,
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
  final List<GenreModelSeries> genreModelSeries;
  final String homepage;
  final int id;
  final bool? inProduction;
  final List? languages;
  final String? lastAirDate;
  final String? name;
  final dynamic nextEpisodeToAir;
  final int? numberOfEpisodes;
  final int? numberOfSeasonModel;
  final List? originCountry;
  final String originalLanguage;
  final String? originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<dynamic> productionCompanies;
  final List<SeasonModel>? seasonModel;
  final String status;
  final String tagline;
  final String? type;
  final double voteAverage;
  final int voteCount;

  factory SeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      SeriesDetailModel(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        createdBy: json["created_by"],
        episodeRunTime: json["episode_run_time"],
        firstAirDate: json["first_air_date"],
        genreModelSeries: List<GenreModelSeries>.from(
            json["genres"].map((x) => GenreModelSeries.fromJson(x))),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: json["languages"],
        lastAirDate: json["last_air_date"],
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasonModel: json["number_of_seasons"],
        originCountry: json["origin_country"],
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        productionCompanies:
            List<dynamic>.from(json["production_companies"].map((x) => x)),
        seasonModel: List<SeasonModel>.from(json["seasons"] != null
            ? json["seasons"].map((x) => SeasonModel.fromJson(x))
            : <SeasonModel>[]),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  SeriesDetail toEntity() {
    return SeriesDetail(
      adult: adult,
      backdropPath: backdropPath,
      createdBy: createdBy,
      episodeRunTime: episodeRunTime,
      firstAirDate: firstAirDate,
      genres: genreModelSeries.map((genre) => genre.toEntity()).toList(),
      homepage: homepage,
      id: id,
      inProduction: inProduction,
      languages: languages,
      lastAirDate: lastAirDate,
      name: name,
      nextEpisodeToAir: nextEpisodeToAir,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasonModel,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      productionCompanies: productionCompanies,
      seasons: seasonModel?.map((seasons) => seasons.toEntity()).toList(),
      status: status,
      tagline: tagline,
      type: type,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        createdBy,
        episodeRunTime,
        firstAirDate,
        genreModelSeries,
        homepage,
        id,
        inProduction,
        languages,
        lastAirDate,
        name,
        nextEpisodeToAir,
        numberOfEpisodes,
        numberOfSeasonModel,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        seasonModel,
        status,
        tagline,
        type,
        voteAverage,
        voteCount,
      ];
}

class GenreModelSeries extends Equatable {
  GenreModelSeries({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreModelSeries.fromJson(Map<String, dynamic> json) =>
      GenreModelSeries(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  GenreSeries toEntity() {
    return GenreSeries(
      id: id,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}

class SeasonModel extends Equatable {
  SeasonModel({
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

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate: json["air_date"] != null ? json["air_date"] : null,
        episodeCount:
            json["episode_count"] != null ? json["episode_count"] : null,
        id: json["id"] != null ? json["id"] : null,
        name: json["name"] != null ? json["name"] : null,
        overview: json["overview"] != null ? json["overview"] : null,
        posterPath: json["poster_path"] != null ? json["poster_path"] : null,
        seasonNumber:
            json["season_number"] != null ? json["season_number"] : null,
      );

  Season toEntity() {
    return Season(
      airDate: airDate != null ? airDate : null,
      episodeCount: episodeCount != null ? episodeCount : null,
      id: id != null ? id : null,
      name: name != null ? name : null,
      overview: overview != null ? overview : null,
      posterPath: posterPath != null ? posterPath : null,
      seasonNumber: seasonNumber != null ? seasonNumber : null,
    );
  }

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
