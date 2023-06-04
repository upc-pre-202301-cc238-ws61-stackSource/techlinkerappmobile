class Company {
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
  String? ruc;
  String? owner;
  String? name;
  String? address;
  String? country;
  String? city;

  Company({
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
    this.ruc,
    this.owner,
    this.name,
    this.address,
    this.country,
    this.city,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
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
      ruc: json['ruc'],
      owner: json['owner'],
      name: json['name'],
      address: json['address'],
      country: json['country'],
      city: json['city'],
    );
  }
}
