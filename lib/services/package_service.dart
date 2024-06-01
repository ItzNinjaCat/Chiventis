import 'api_service.dart';

class PackageService {
  static Future<List<dynamic>?> dataPackages(
      String provider) async {
    try {
      final response = await ApiService.get(
        '/tv/disco/$provider',
      );
      final packages = response['products'] as List<dynamic>;
      return packages;
    } catch (e) {
      print(e);
      return null;
    }
  }
}

// https://chiventis.net/api/v1/tv/disco/DSTV