import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:techlinkerappmobile/models/certificate.dart';
import 'package:techlinkerappmobile/models/database.dart';
import 'package:techlinkerappmobile/models/framework.dart';
import 'package:techlinkerappmobile/models/programming_language.dart';
import 'package:techlinkerappmobile/models/project.dart';
import 'package:techlinkerappmobile/models/study_center.dart';

import '../models/education.dart';

class DeveloperService {
  static const String baseUrl = 'https://stacksource.azurewebsites.net/api/v1';


  static deleteProgrammingLanguage(int id) async{
    final url = Uri.parse(
        '$baseUrl/programmingLanguages/${id}');
    print(url);
    try {
      final response = await http.delete(
        url,
        headers: {'content-type': 'application/json'},
        );

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to delete programing language. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed delete programing language. Error: $e');
    }
  }
  static deleteProject(int id) async{
    final url = Uri.parse(
        '$baseUrl/projects/${id}');
    print(url);
    try {
      final response = await http.delete(
        url,
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to delete project. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed delete project. Error: $e');
    }
  }
  static deleteFramework(int id) async{
    final url = Uri.parse(
        '$baseUrl/frameworks/${id}');
    print(url);
    try {
      final response = await http.delete(
        url,
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to delete framework. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed delete framework. Error: $e');
    }
  }
  static deleteDatabase(int id) async{
    final url = Uri.parse(
        '$baseUrl/databases/${id}');
    print(url);
    try {
      final response = await http.delete(
        url,
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to delete to database. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed delete to database. Error: $e');
    }
  }

  static postCertificate(Certificate certificate) async {
    final url = Uri.parse(
        '$baseUrl/certificates/education/${certificate.education!.id}');
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



  static postProjecttoDatabase(Project project) async {
    final url = Uri.parse(
        '$baseUrl/projects/digitalProfile/${project!.digitalProfile!.id}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'description': project.description,
          'digitalProfile':project.digitalProfile!.toJson(),
          'iconUrl': project.iconUrl,
          'id': project.id,
          'name': project.name,
          'projectUrl':project.projectUrl
        }),
      );
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to create Project Developer. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create Project Developer. Error: $e');
    }
  }



  static postProgramingLanguaje(ProgrammingLanguage programinglanguaje) async {
    final url = Uri.parse(
        '$baseUrl/programmingLanguages/${programinglanguaje!.digitalProfile!.id}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'description': programinglanguaje.description,
          'digitalProfile':programinglanguaje.digitalProfile!.toJson(),
          'iconLink': programinglanguaje.iconLink,
          'id': programinglanguaje.id,
          'name': programinglanguaje.name,
        }),
      );
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to create ProgramingLanguaje. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create ProgramingLanguaje. Error: $e');
    }
  }




  static postDatabase(Database database) async {
    final url = Uri.parse(
        '$baseUrl/databases/${database!.digitalProfile!.id}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'description': database.description,
          'digitalProfile':database.digitalProfile!.toJson(),
          'iconLink': database.iconLink,
          'id': database.id,
          'name': database.name,
        }),
      );
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to create Database. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create Database. Error: $e');
    }
  }




  static postFramework(Framework framework) async {
    final url = Uri.parse(
        '$baseUrl/frameworks/${framework!.digitalProfile!.id}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'description': framework.description,
          'digitalProfile':framework.digitalProfile!.toJson(),
          'iconLink': framework.iconLink,
          'id': framework.id,
          'name': framework.name,
        }),
      );
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to create Framework. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create Framework. Error: $e');
    }
  }










  static postStudyCenter(StudyCenter studyCenter) async {
    final url =
        Uri.parse('$baseUrl/study-centers/${studyCenter.education!.id}');
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
    final url =
        Uri.parse('$baseUrl/educations/${education.digitalProfile!.id}');
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

  //getLastMessagesByDeveloperId
  static Future<List<dynamic>> getLastMessagesByDeveloperId(String id) async {
    final url = Uri.parse('$baseUrl/users/$id/messages/LastMessageDeveloper');

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
            'Failed to fetch messages data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch messages data. Error: $e');
    }
  }

 
  static getMessagesByDeveloperAndReciverId(String id, String reciverId) async {
    final url = Uri.parse('$baseUrl/users/$id/messages/$reciverId');
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
            'Failed to fetch company data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch company data. Error: $e');
    }
  }

}
