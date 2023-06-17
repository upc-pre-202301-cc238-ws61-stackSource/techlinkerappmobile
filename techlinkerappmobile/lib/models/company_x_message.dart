import 'package:techlinkerappmobile/models/company.dart';

import 'developer.dart';
import 'message.dart';
import 'message_company.dart';

class CompanyMessage {
  final Company company;
  final MessageCompany message;

  CompanyMessage({
    required this.company,
    required this.message,
  });

  //create a method to print teh developer first name and last name and message
  @override
  String toString() {
    return 'company name: ${company.name}, message: ${message.message}';
  }
}
