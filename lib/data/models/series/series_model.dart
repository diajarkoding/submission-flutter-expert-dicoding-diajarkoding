import 'package:ditonton/domain/entities/series.dart';
import 'package:equatable/equatable.dart';

class SeriesModel extends Equatable {
  SeriesModel({
    this.adult,
    this.backdropPath,
    this.firstAirDate,
    required this.genreIds,
    required this.id,
    this.mediaType,
    required this.name,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    this.posterPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool? adult;
  final String? backdropPath;
  final String? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String? mediaType;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  factory SeriesModel.fromJson(Map<String, dynamic> json) => SeriesModel(
        adult: json["adult"] != null ? json["adult"] : null,
        backdropPath:
            json["backdrop_path"] != null ? json["backdrop_path"] : null,
        firstAirDate:
            json["first_air_date"] != null ? json["first_air_date"] : null,
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        mediaType: json["media_type"] != null ? json["media_type"] : null,
        name: json["name"],
        originCountry: List<String>.from(json["origin_country"].map((x) => x)),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "first_air_date": firstAirDate,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "media_type": mediaType,
        "name": name,
        "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
        "original_language": originalLanguage,
        "original_name": originalName,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  Series toEntity() {
    return Series(
      adult: adult,
      backdropPath: backdropPath != null ? backdropPath : null,
      firstAirDate: firstAirDate != null ? firstAirDate : null,
      genreIds: genreIds,
      id: id,
      mediaType: mediaType,
      name: name,
      originCountry: originCountry,
      originalLanguage: originalLanguage,
      originalName: originalName,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath!,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        firstAirDate,
        genreIds,
        id,
        mediaType,
        name,
        originCountry,
        originalLanguage,
        originalName,
        overview,
        popularity,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
