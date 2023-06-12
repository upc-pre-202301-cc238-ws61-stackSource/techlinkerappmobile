class CompanyUniqueItem {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? role;
  String? description;
  String? bannerImage;
  String? ruc;
  String? owner;
  String? companyName;
  String? address;
  String? country;
  String? city;

  CompanyUniqueItem({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.description,
    required this.bannerImage,
    required this.ruc,
    required this.owner,
    required this.companyName,
    required this.address,
    required this.country,
    required this.city,
  });

  factory CompanyUniqueItem.fromJson(Map<String, dynamic> json) {
    return CompanyUniqueItem(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
      role: json['role'],
      description: json['description'],
      bannerImage: json['bannerImage'],
      ruc: json['ruc'],
      owner: json['owner'],
      companyName: json['companyName'],
      address: json['address'],
      country: json['country'],
      city: json['city'],
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
    'bannerImage': bannerImage,
    'ruc': ruc,
    'owner': owner,
    'companyName': companyName,
    'address': address,
    'country': country,
    'city': city,
  };
}

  static List<CompanyUniqueItem> developerItems() {
    return [
      CompanyUniqueItem(
          id: 1,
          firstName: "Tomas",
          lastName: "Pastor",
          email: "tomas@gmail.com",
          phone: "0987654321",
          password: "123456",
          role: "company",
          description: "Somos una empresa de desarrollo de software",
          bannerImage:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          ruc: "1234567890",
          owner: "John Doe",
          companyName: "Google",
          address: "Av. Amazonas N34-123",
          country: "Ecuador",
          city: "Quito"),
      CompanyUniqueItem(
          id: 2
          
          ,
          firstName: "Jane",
          lastName: "Smith",
          email: "jane@gmail.com",
          phone: "0987654321",
          password: "123456",
          role: "company",
          description: "Somos una empresa de desarrollo de software",
          bannerImage:
              "https://images.pexels.com/photos/749091/pexels-photo-749091.jpeg",
          ruc: "1234567890",
          owner: "Jane Smith",
          companyName: "Facebook",
          address: "Av. Amazonas N34-123",
          country: "Ecuador",
          city: "Quito"),
      CompanyUniqueItem(
          id: 3,
          firstName: "Robert",
          lastName: "Johnson",
          email: "robert@gmail.com",
          phone: "0987654321",
          password: "123456",
          role: "company",
          description: "Somos una empresa de desarrollo de software",
          bannerImage:
              "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg",
          ruc: "1234567890",
          owner: "Robert Johnson",
          companyName: "Amazon",
          address: "Av. Amazonas N34-123",
          country: "Ecuador",
          city: "Quito"),
    ];
  }
}
