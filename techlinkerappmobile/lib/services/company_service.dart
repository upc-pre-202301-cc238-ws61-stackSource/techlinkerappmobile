import 'package:http/http.dart' as http;
import 'package:techlinkerappmobile/models/company.dart';
import 'package:techlinkerappmobile/models/message_post.dart';
import 'package:techlinkerappmobile/widgets/message_item.dart';
import 'dart:convert';

import '../models/company_unique_post.dart';

class CompanyService {
  static const String baseUrl = 'https://stacksource.azurewebsites.net/api/v1';

  static Future<Map<String, dynamic>> insertCompany(Company company) async {
    final url = Uri.parse('$baseUrl/companies');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'address': company.address,
          'bannerImage': company.bannerImage,
          'city': company.city,
          'country': company.country,
          'description': company.description,
          'email': company.email,
          'firstName': company.firstName,
          'id': company.id,
          'image': company.image,
          'lastName': company.lastName,
          'name': company.name,
          'owner': company.owner,
          'password': company.password,
          'phone': company.phone,
          'role': company.role,
          'ruc': company.ruc,
        }),
      );
      if (response.statusCode == 201) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception('Failed to create developer. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create developer. Error: $e');
    }
  }

  static sendNotificationFromCompanyToDeveloper(
      String id, String reciverId, String content) async {
    final url = Uri.parse('$baseUrl/users/$id/notifications/$reciverId');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode(
          {
            "content": content,
            "date": DateTime.now().toIso8601String(),
          },
        ),
      );

      if (response.statusCode == 201) {
        return [];
      } else {
        throw Exception(
            'Failed to fetch company data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch company data. Error: $e');
    }
  }

  static setCompanyPost(PostItem postJob) async {
    final url = Uri.parse('$baseUrl/posts/${postJob.companyUniqueItem.id}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'company': postJob.companyUniqueItem.toJson(),
          'description': postJob.description,
          'id': postJob.id,
          'imageUrl': postJob.imageUrl,
          'title': postJob.title,
        }),
      );

      if (response.statusCode == 200) {
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

  static updateProfileCompany(Company company) async {
    final url = Uri.parse('$baseUrl/companies/${company.id}');
    print(url);
    try {
      final response = await http.put(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'id': company.id,
          'firstName': company.firstName,
          'lastName': company.lastName,
          'email': company.email,
          'phone': company.phone,
          'password': company.password,
          'role': company.role,
          'description': company.description,
          'image': company.image,
          'bannerImage': company.bannerImage,
          "ruc": company.ruc,
          "owner": company.owner,
          "name": company.name,
          "address": company.address,
          "country": company.country,
          "city": company.city
        }),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonData;
      } else {
        throw Exception(
            'Failed to update profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update profile. Error: $e');
    }
  }

  static getCompanyById(String id) async {
    final url = Uri.parse('$baseUrl/companies/$id');
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
            'Failed to fetch company data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch company data. Error: $e');
    }
  }

  // get posts by company id
  static getPostsByCompanyId(String id) async {
    final url = Uri.parse('$baseUrl/posts/company/$id');
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

  static getAllPosts() async {
    final url = Uri.parse('$baseUrl/posts');
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

  static getLastMessagesByCompanyId(String id) async {
    final url = Uri.parse('$baseUrl/users/$id/messages/LastMessageCompany');
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

  //getMessagesByCompanyId
  static getMessagesByCompanyAndReciverId(String id, String reciverId) async {
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

  //post message
  static postMessage(MessagePost message) async {
    final url = Uri.parse(
        '$baseUrl/users/${message.emitter.id.toString()}/messages/${message.receiver.id.toString()}');
    print(url);
    try {
      final response = await http.post(
        url,
        headers: {'content-type': 'application/json'},
        body: jsonEncode({
          'id': message.id,
          'message': message.message,
          'emitter': message.emitter.toJson(),
          'receiver': message.receiver.toJson(),
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

  //delete a post by id
  static deleteCompanyPostById(String id) async {
    final url = Uri.parse('$baseUrl/posts/$id');
    print(url);
    try {
      final response = await http.delete(
        url,
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        return [];
      } else {
        throw Exception(
            'Failed to delete post. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete post. Error: $e');
    }
  }


  static getNotificationsByCompanyId(String id) async {
    final url = Uri.parse('$baseUrl/users/$id/notifications');
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

  static deleteNotificationIdByDeveloperIdOrCompanyId(String id, String notificationId) async {
    final url = Uri.parse('$baseUrl/users/$id/notifications/$notificationId');
    print(url);
    try {
      final response = await http.delete(
        url,
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return [];
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
