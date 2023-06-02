import 'package:http/http.dart' as http;
import 'dart:convert';

class DeveloperService {
  static const String baseUrl =
      'https://stacksourcewebservice.azurewebsites.net/api/v1';

  static Future<List<dynamic>> getAllDevelopers() async {
    final url = Uri.parse('$baseUrl/developers');
    print(url);
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

  //get all frameworks
  static Future<List<dynamic>> getAllFrameworks() async {
    final url = Uri.parse('$baseUrl/frameworks');

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
            'Failed to fetch frameworks data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch frameworks data. Error: $e');
    }
  }

  //get all programming languages
  static Future<List<dynamic>> getAllProgrammingLanguages() async {
    final url = Uri.parse('$baseUrl/programmingLanguages');

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
            'Failed to fetch programming languages data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch programming languages data. Error: $e');
    }
  }

  //get all databases
  static Future<List<dynamic>> getAllDatabases() async {
    final url = Uri.parse('$baseUrl/databases');

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
            'Failed to fetch databases data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch databases data. Error: $e');
    }
  }
}
