class Developer {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? role;
  String? description;
  String? image;
  String? bannerImage;

  Developer({
     this.id,
     this.firstName,
     this.lastName,
     this.email,
     this.phone,
     this.password,
     this.role,
     this.description,
     this.image,
     this.bannerImage,
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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'description': description,
      'image': image,
      'bannerImage': bannerImage,
    };
  }
}
