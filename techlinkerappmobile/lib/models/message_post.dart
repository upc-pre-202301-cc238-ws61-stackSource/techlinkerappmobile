class MessagePost {
  final Emitter emitter;
  final int id;
  final String message;
  final Receiver receiver;

  MessagePost({
    required this.emitter,
    required this.id,
    required this.message,
    required this.receiver,
  });

  factory MessagePost.fromJson(Map<String, dynamic> json) {
    return MessagePost(
      emitter: Emitter.fromJson(json['emitter']),
      id: json['id'],
      message: json['message'],
      receiver: Receiver.fromJson(json['receiver']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emitter': emitter.toJson(),
      'id': id,
      'message': message,
      'receiver': receiver.toJson(),
    };
  }
}

class Emitter {
  final String bannerImage;
  final String description;
  final String email;
  final String firstName;
  final int id;
  final String image;
  final String lastName;
  final String password;
  final String phone;
  final String role;

  Emitter({
    required this.bannerImage,
    required this.description,
    required this.email,
    required this.firstName,
    required this.id,
    required this.image,
    required this.lastName,
    required this.password,
    required this.phone,
    required this.role,
  });

  Emitter.withId({required this.id})
      : bannerImage = '',
        description = '',
        email = '',
        firstName = '',
        image = '',
        lastName = '',
        password = '',
        phone = '',
        role = '';

  factory Emitter.fromJson(Map<String, dynamic> json) {
    return Emitter(
      bannerImage: json['bannerImage'],
      description: json['description'],
      email: json['email'],
      firstName: json['firstName'],
      id: json['id'],
      image: json['image'],
      lastName: json['lastName'],
      password: json['password'],
      phone: json['phone'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bannerImage': bannerImage,
      'description': description,
      'email': email,
      'firstName': firstName,
      'id': id,
      'image': image,
      'lastName': lastName,
      'password': password,
      'phone': phone,
      'role': role,
    };
  }
}

class Receiver {
  final String bannerImage;
  final String description;
  final String email;
  final String firstName;
  final int id;
  final String image;
  final String lastName;
  final String password;
  final String phone;
  final String role;

  Receiver({
    required this.bannerImage,
    required this.description,
    required this.email,
    required this.firstName,
    required this.id,
    required this.image,
    required this.lastName,
    required this.password,
    required this.phone,
    required this.role,
  });

  Receiver.withId({required this.id})
      : bannerImage = '',
        description = '',
        email = '',
        firstName = '',
        image = '',
        lastName = '',
        password = '',
        phone = '',
        role = '';

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      bannerImage: json['bannerImage'],
      description: json['description'],
      email: json['email'],
      firstName: json['firstName'],
      id: json['id'],
      image: json['image'],
      lastName: json['lastName'],
      password: json['password'],
      phone: json['phone'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bannerImage': bannerImage,
      'description': description,
      'email': email,
      'firstName': firstName,
      'id': id,
      'image': image,
      'lastName': lastName,
      'password': password,
      'phone': phone,
      'role': role,
    };
  }
}
