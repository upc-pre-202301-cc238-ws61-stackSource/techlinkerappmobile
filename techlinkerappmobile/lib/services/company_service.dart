import 'package:http/http.dart' as http;
import 'package:techlinkerappmobile/models/company_unique_item.dart';
import 'dart:convert';

import 'package:techlinkerappmobile/widgets/job_offer_item.dart';

import '../models/company_unique_post.dart';

class CompanyService {
  static const String baseUrl = 'https://stacksource.azurewebsites.net/api/v1';

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
}