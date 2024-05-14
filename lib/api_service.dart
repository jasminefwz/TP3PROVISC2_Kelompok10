import 'package:dio/dio.dart';
import 'package:tp3provis/item.dart';

class ApiService {
  final Dio dio = Dio();

  Future<List<Item>> fetchItems() async {
    try {
      final response =
          await dio.get('https://dummy.restapiexample.com/api/v1/employees');
      return (response.data['data'] as List)
          .map((itemJson) => Item.fromJson(itemJson))
          .toList();
    } on DioError catch (e) {
      if (e.response?.statusCode == 429) {
        // Wait for a specified time before retrying
        await Future.delayed(Duration(seconds: 1));
        return fetchItems();
      } else {
        throw Exception('Failed to fetch items: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to fetch items: ${e.toString()}');
    }
  }
}
