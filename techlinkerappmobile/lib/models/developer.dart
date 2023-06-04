class Developer {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String description;
  final String image;
  final String bannerImage;

  Developer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.description,
    required this.image,
    required this.bannerImage,
  });

  //empty constructor
  factory Developer.empty() {
    return Developer(
      id: 1,
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      password: '',
      role: '',
      description: '',
      image: '',
      bannerImage: '',
    );
  }

  factory Developer.fromJson(Map<String, dynamic> json) {
    return Developer(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      role: json['role'],
      description: json['description'],
      image: json['image'],
      bannerImage: json['bannerImage'],
    );
  }
}
