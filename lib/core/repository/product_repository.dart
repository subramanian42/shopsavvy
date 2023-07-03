import '../clients/punk_api_client.dart';
import '../model/beer_model.dart';

class ProductRepository {
  ProductRepository({PunkApiClient? punkApiClient})
      : _punkApiClient = punkApiClient ?? PunkApiClient();

  final PunkApiClient _punkApiClient;

  Future<List<Beer>> fetchProductList(int page) async {
    final List<Map<String, dynamic>> result = await _punkApiClient.fetchList(
      "/beers",
      queryParams: {
        'page': page.toString(),
      },
    ).then(
      (List<dynamic> value) =>
          value.map((dynamic e) => e as Map<String, dynamic>).toList(),
    );

    final List<Beer> productList = <Beer>[];
    for (Map<String, dynamic> element in result) {
      productList.add(Beer.fromJson(element));
    }
    return productList;
  }
}
