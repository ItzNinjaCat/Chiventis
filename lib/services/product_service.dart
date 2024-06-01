import 'api_service.dart';

class ProductService {
  static Future<List<dynamic>?> dataProducsts(
      String provider, String category) async {
    try {
      final response = await ApiService.get(
        '/products/mobile/DATA_BUNDLE/$category/$provider',
      );
      print('1232132121312312312');
      print(response['transaction']);
      final plans = response['transaction'] as List<dynamic>;

      return plans;
    } catch (e) {
      print(e);
      return null;
    }
  }
}


// https://chiventis.net/api/v1/products/mobile/DATA_BUNDLE/Monthly/glo