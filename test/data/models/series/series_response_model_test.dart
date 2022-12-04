import 'dart:convert';

import 'package:ditonton/data/models/series/series_model.dart';
import 'package:ditonton/data/models/series/series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../json_reader.dart';

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

  final tSeriesResponseModel =
      SeriesResponse(seriesList: <SeriesModel>[tSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/series/series_playing.json'));
      // act
      final result = SeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "adult": null,
            "backdrop_path": "/5kkw5RT1OjTAMh3POhjo5LdaACZ.jpg",
            "first_air_date": "2021-10-12",
            "genre_ids": [80, 10765],
            "id": 90462,
            "media_type": null,
            "name": "Chucky",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "Chucky",
            "overview":
                "After a vintage Chucky doll turns up at a suburban yard sale, an idyllic American town is thrown into chaos as a series of horrifying murders begin to expose the town’s hypocrisies and secrets. Meanwhile, the arrival of enemies — and allies — from Chucky’s past threatens to expose the truth behind the killings, as well as the demon doll’s untold origins.",
            "popularity": 3545.458,
            "poster_path": "/kY0BogCM8SkNJ0MNiHB3VTM86Tz.jpg",
            "vote_average": 7.9,
            "vote_count": 3466
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
