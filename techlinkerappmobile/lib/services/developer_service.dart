import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:techlinkerappmobile/models/developer_certificate_item.dart';
import 'package:techlinkerappmobile/models/developer_study_center.dart';

class DeveloperService {
  static const String baseUrl =
      'https://stacksource.azurewebsites.net/api/v1';

  static postCertificate(DeveloperCertificateItem certificate) async {
    final url = Uri.parse('$baseUrl/certificates/education/${certificate.education!.id}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'description': certificate.description,
          'education': certificate.education!.toJson(),
          'iconUrl': certificate.iconUrl,
          'id': certificate.id,
          'obtainedDate': certificate.obtainedDate!.toIso8601String(),
          'title': certificate.title,
        }),
      );
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to create certificate. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create certificate. Error: $e');
    }
  }

  static postStudyCenter(StudyCenterUniqueItem studyCenter) async {
    final url = Uri.parse('$baseUrl/study-centers/${studyCenter.education!.id}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'description': studyCenter.description,
          'education': studyCenter.education!.toJson(),
          'entryDate': studyCenter.entryDate!.toIso8601String(),
          'graduationDate': studyCenter.graduationDate!.toIso8601String(),
          'iconUrl': studyCenter.iconUrl,
          'id': studyCenter.id,
          'name': studyCenter.name,
          'progress': studyCenter.progress,
        }),
      );

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to create study center. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create study center. Error: $e');
    }
  }

  static getDigitalProfileByDeveloperId(String id) async {
    final url = Uri.parse('$baseUrl/digital_profiles/$id');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to fetch digital profile data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch digital profile data. Error: $e');
    }
  }

  static getEducationByDigitalProfileId(String id) async {
    final url = Uri.parse('$baseUrl/educations/digitalProfile/$id');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to fetch education data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch education data. Error: $e');
    }
  }

  static setEducationPublish(Education education) async {
    final url = Uri.parse('$baseUrl/educations/${education.digitalProfile!.id}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'career': education.career,
          'digitalProfile': education.digitalProfile!.toJson(),
          'id': education.id,
        }),
      );

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to create education. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create education. Error: $e');
    }
  }

  static getEducationById(String id) async {
    final url = Uri.parse('$baseUrl/educations/$id');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to fetch education data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch education data. Error: $e');
    }
  }

   static getDeveloperById(String id) async {
    final url = Uri.parse('$baseUrl/developers/$id');
    try {
      final response = await http.get(
        url,
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to fetch developer data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch developer data. Error: $e');
    }
  }

  static Future<List<dynamic>> getAllDevelopers() async {
    final url = Uri.parse('$baseUrl/developers');
    print(url);
    try {
      final response = await http.get(
        url,
        headers: {'content-type': 'application/json'},
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
        headers: {'content-type': 'application/json'},
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
        headers: {'content-type': 'application/json'},
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
        headers: {'content-type': 'application/json'},
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
  static Future<List<dynamic>> getAllCertificate() async {
    final url = Uri.parse('$baseUrl/certificates');

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
            'Failed to fetch certificates data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch certificates data. Error: $e');
    }
  }
 
  static setCompanyPost(DeveloperCertificateItem postCert) async {
    final url = Uri.parse('$baseUrl/posts/${postCert.id}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'description': postCert.description,
          'id': postCert.id,
          'imageUrl': postCert.iconUrl,
          'title': postCert.title,
        }),
      );
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to create post. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create post. Error: $e');
    }
  }
}
