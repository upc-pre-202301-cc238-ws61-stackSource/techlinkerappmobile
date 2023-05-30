import 'package:http/http.dart' as http;
import 'dart:convert';

class DeveloperService {
  static const String baseUrl =
      'https://stacksourcewebservice.azurewebsites.net/api/v1/developers';

  static Future<List<dynamic>> getAllDevelopers() async {
    final url = Uri.parse(baseUrl);

    try {
      final response = await http.get(
        url,
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;
        return jsonData;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception(
            'Failed to fetch developers data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch developers data. Error: $e');
    }
  }
}
