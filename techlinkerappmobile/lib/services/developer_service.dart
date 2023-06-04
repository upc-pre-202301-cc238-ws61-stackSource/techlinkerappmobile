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

  //get developer by id
  static Future<dynamic> getDeveloperById(String id) async {
    final url = Uri.parse('$baseUrl/developers/$id');

    print(url);

    try {
      final response = await http.get(
        url,
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception(
            'Failed to fetch developer data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch developer data. Error: $e');
    }
  }

  //get study cernters by developer id
  static Future<List<dynamic>> getStudyCentersByDeveloperId(String id) async {
    final url = Uri.parse('$baseUrl/developers/$id/studyCenters');

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
            'Failed to fetch study centers data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch study centers data. Error: $e');
    }
  }

  //get education by digital profile id
  static Future<dynamic> getEducationByDigitalProfileId(String id) async {
    final url = Uri.parse('$baseUrl/educations/digitalProfile/$id');

    try {
      final response = await http.get(
        url,
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as dynamic;
        return jsonData;
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw Exception(
            'Failed to fetch education data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch education data. Error: $e');
    }
  }

  //get study centers by education id
  static Future<List<dynamic>> getStudyCentersByEducationId(String id) async {
    final url = Uri.parse('$baseUrl/study-centers/education/$id');

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
            'Failed to fetch study centers data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch study centers data. Error: $e');
    }
  }

  //get projects by digital profile id
  static Future<List<dynamic>> getProjectsByDigitalProfileId(String id) async {
    final url = Uri.parse('$baseUrl/projects/digitalProfile/$id');

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
            'Failed to fetch projects data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch projects data. Error: $e');
    }
  }

  //get databases by digital profile id
  static Future<List<dynamic>> getDatabasesByDigitalProfileId(String id) async {
    final url = Uri.parse('$baseUrl/databases/digitalProfile/$id');

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
            'Failed to fetch databases data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch databases data. Error: $e');
    }
  }

  //get frameworks by digital profile id
  static Future<List<dynamic>> getFrameworksByDigitalProfileId(
      String id) async {
    final url = Uri.parse('$baseUrl/frameworks/digitalProfile/$id');

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
            'Failed to fetch frameworks data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch frameworks data. Error: $e');
    }
  }

  //get programming languages by digital profile id
  static Future<List<dynamic>> getProgrammingLanguagesByDigitalProfileId(
      String id) async {
    final url = Uri.parse('$baseUrl/programmingLanguages/digitalProfile/$id');

    print(url);

    try {
      final response = await http.get(
        url,
        headers: {'accept': 'application/json'},
      );

      print(response.statusCode);

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

  //get certifications by education id
  static Future<List<dynamic>> getCertificationsByEducationId(String id) async {
    final url = Uri.parse('$baseUrl/certificates/education/$id');

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
            'Failed to fetch certifications data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch certifications data. Error: $e');
    }
  }
}
