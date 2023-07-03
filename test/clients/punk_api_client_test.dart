import 'package:mocktail/mocktail.dart';
import 'package:shopsavvy/core/clients/punk_api_client.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

Uri _beersUrl() {
  return Uri.https(
    'api.punkapi.com',
    '/v2/beers',
    <String, String>{
      'per_page': "10",
    },
  );
}

void main() {
  group('PunkApiClient tests', () {
    late PunkApiClient punkApiClient;
    late MockHttpClient mockHttpClient;
    const reponseString =
        '''[ { "id": 1, "name": "Beer 1", "tagline": "tagline", "first_brewed": "firstbrewed", "description": "description", "image_url": "imageurl", "abv": 1, "ibu": 10, "target_fg": 1011, "target_og": 1040, "ebc": 20, "srm": 30, "ph": 4.5, "attenuation_level": 45 }, { "id": 2, "name": "Beer 2", "tagline": "tagline", "first_brewed": "firstbrewed", "description": "description", "image_url": "imageurl", "abv": 1, "ibu": 10, "target_fg": 1011, "target_og": 1040, "ebc": 20, "srm": 30, "ph": 4.5, "attenuation_level": 45 }]''';
    setUp(() {
      mockHttpClient = MockHttpClient();
      punkApiClient = PunkApiClient(httpClient: mockHttpClient);
    });
    setUpAll(() {
      registerFallbackValue(Uri());
    });
    test('fetchList returns a list of data when successful', () async {
      final response = http.Response(reponseString, 200);
      when(() => mockHttpClient.get(_beersUrl()))
          .thenAnswer((_) async => Future.value(response));

      final result = await punkApiClient.fetchList('/beers');

      expect(result, isA<List<dynamic>>());
      expect(result.length, equals(2));
      expect(result[0]['id'], equals(1));
      expect(result[0]['name'], equals('Beer 1'));
      expect(result[1]['id'], equals(2));
      expect(result[1]['name'], equals('Beer 2'));
    });

    test('fetchList throws a NetworkException when unsuccessful', () async {
      final response = http.Response('Error fetching data', 404);
      when(() => mockHttpClient.get(_beersUrl()))
          .thenAnswer((_) async => response);

      expect(() => punkApiClient.fetchList('/beers'),
          throwsA(isA<NetWorkException>()));
    });
  });
}
