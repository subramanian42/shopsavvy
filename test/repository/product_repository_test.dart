import 'package:mocktail/mocktail.dart';
import 'package:shopsavvy/core/clients/punk_api_client.dart';
import 'package:shopsavvy/core/model/beer_model.dart';
import 'package:shopsavvy/core/repository/product_repository.dart';
import 'package:test/test.dart';

class MockPunkApiClient extends Mock implements PunkApiClient {}

void main() {
  late ProductRepository productRepository;
  late MockPunkApiClient mockPunkApiClient;
  final page = 1;
  final beerList = [
    Beer(
      id: 1,
      name: 'name',
      tagline: 'tagline',
      firstBrewed: 'firstbrewed',
      description: 'description',
      imageUrl: 'imageurl',
      abv: '1',
      ibu: '10',
      targetFg: '1011',
      targetOg: '1040',
      ebc: '20',
      srm: '30',
      ph: '4.5',
      attenuationLevel: '45',
    ),
    Beer(
      id: 2,
      name: 'name',
      tagline: 'tagline',
      firstBrewed: 'firstbrewed',
      description: 'description',
      imageUrl: 'imageurl',
      abv: '1',
      ibu: '10',
      targetFg: '1011',
      targetOg: '1040',
      ebc: '20',
      srm: '30',
      ph: '4.5',
      attenuationLevel: '45',
    ),
  ];
  setUp(() {
    mockPunkApiClient = MockPunkApiClient();
    productRepository = ProductRepository(punkApiClient: mockPunkApiClient);
  });

  test('fetchProductList returns a list of beers', () async {
    when(() => mockPunkApiClient
            .fetchList('/beers', queryParams: {'page': page.toString()}))
        .thenAnswer((_) async => beerList.map((e) => e.toJson()).toList());

    final result = await productRepository.fetchProductList(page);

    expect(result, beerList);
  });
  test('fetchProductList returns expected list of beers', () async {
    when(() => mockPunkApiClient
            .fetchList('/beers', queryParams: {'page': page.toString()}))
        .thenAnswer((_) async => beerList.map((e) => e.toJson()).toList());
    final result = await productRepository.fetchProductList(page);
    expect(result, beerList);
  });
}
