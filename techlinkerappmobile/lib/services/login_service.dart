import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:techlinkerappmobile/models/user.dart';

import '../models/education.dart';

class LoginService {
  //static const String baseUrl = 'https://stacksource.azurewebsites.net/api/v1';
  static const String baseUrl = 'https://stacksourcewebservice.azurewebsites.net/api/v1';

  static Future<User> GetUserByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/users/searchByEmail/$email'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    }
    else if(response.statusCode == 404)
    {
      return User.empty();
    }
    else {
      throw Exception('Failed to load user');
      
    }
  }

}
