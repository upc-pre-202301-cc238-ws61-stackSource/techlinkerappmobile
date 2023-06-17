import 'developer.dart';
import 'message.dart';

class DeveloperMessage {
  final Developer developer;
  final Message message;

  DeveloperMessage({
    required this.developer,
    required this.message,
  });

  //create a method to print teh developer first name and last name and message
  @override
  String toString() {
    return 'developer firstName: ${developer.firstName}, developer lastName: ${developer.lastName}, message: ${message.message}';
  }
}
