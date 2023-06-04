import 'company.dart';

class Post {
  Company company;
  String description;
  int id;
  String imageUrl;
  String title;

  Post({
    required this.company,
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.title,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      company: Company.fromJson(json['company']),
      description: json['description'],
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
    );
  }
}
