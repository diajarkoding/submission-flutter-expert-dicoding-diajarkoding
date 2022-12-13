import 'package:core/utils/ssl_pinning/shared.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';
  group('SSL Pinning tests', () {
    test('should get response 200 when connection succeeded', () async {
      final myClient = await Shared.createLEClient(isTestMode: true);
      final response =
          await myClient.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey'));

      expect(response.statusCode, 200);
      myClient.close();
    });
  });
}
