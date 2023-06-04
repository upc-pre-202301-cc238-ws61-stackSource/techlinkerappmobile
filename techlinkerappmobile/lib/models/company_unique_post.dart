import 'package:techlinkerappmobile/models/company_unique_item.dart';

class PostItem {
  int? id;
  String? title;
  String? description;
  String? imageUrl;
  CompanyUniqueItem companyUniqueItem;

  PostItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.companyUniqueItem,
  });

  factory PostItem.fromJson(Map<String, dynamic> json) {
    return PostItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      companyUniqueItem: CompanyUniqueItem.fromJson(json['companyUniqueItem']),
    );
  }
  
  static List<PostItem> allCompanyPosts() {
    return [
      PostItem(
          id: 1,
          title: "Backend Developer",
          description:
              "We are looking for a Back-End Web Developer responsible for managing.",
          imageUrl:
              "https://www.simplilearn.com/ice9/free_resources_article_thumb/How_to_Become_a_Back_End_Developer.jpg",
          companyUniqueItem: CompanyUniqueItem(
              id: 1,
              firstName: "John",
              lastName: "Doe",
              email: "john@gmail.com",
              phone: "0987654321",
              password: "123456",
              role: "company",
              description:
                  "Experience as a manager of agile proyects. I work in Facebook meta. Every day is a challenge.",
              bannerImage:
                  "https://pbs.twimg.com/profile_images/1374076420566224899/wSZ6S8vW_400x400.jpg",
              ruc: "1234567890",
              owner: "John Doe",
              companyName: "Google",
              address: "San Isidro, 243",
              country: "Ecuador",
              city: "Quito")),
      PostItem(
          id: 2,
          title: "Frontend Developer",
          description:
              "We are looking for a Front-End Web Developer who is motivated to combine the art of design.",
          imageUrl:
              "https://media.licdn.com/dms/image/D5612AQG2wFDFDltiNg/article-cover_image-shrink_720_1280/0/1675322684139?e=2147483647&v=beta&t=R_9OphmuNCHhnP3GTyVyOtlHqxxF8CFBIdJTyGz98Rw",
          companyUniqueItem: CompanyUniqueItem(
              id: 2,
              firstName: "Jane",
              lastName: "Smith",
              email: "jane@gmail.com",
              phone: "0987654321",
              password: "123456",
              role: "company",
              description:
                  "Experience as a manager of agile proyects. I work in Instagram. Every day is a challenge.",
              bannerImage:
                  "https://i.pinimg.com/originals/cb/05/f0/cb05f0ca5a29d510201e2c112aa2c0fa.jpg",
              ruc: "1234567890",
              owner: "Jane Smith",
              companyName: "Facebook",
              address: "San Isidro, 100",
              country: "Ecuador",
              city: "Quito")),
      PostItem(
          id: 3,
          title: "Fullstack Developer",
          description:
              "We are looking for a Full Stack Developer to produce scalable software solutions.",
          imageUrl:
              "https://thetapacademy.com/wp-content/uploads/2022/10/full-stack-web-developer-1024x1024.jpg",
          companyUniqueItem: CompanyUniqueItem(
              id: 3,
              firstName: "Robert",
              lastName: "Johnson",
              email: "robert@gmail.com",
              phone: "0987654321",
              password: "123456",
              role: "company",
              description:
                  "Experience as a manager of agile proyects. I work in Instagram. Every day is a challenge.",
              bannerImage:
                  "https://i.pinimg.com/originals/cb/05/f0/cb05f0ca5a29d510201e2c112aa2c0fa.jpg",
              ruc: "1234567890",
              owner: "Robert Johnson",
              companyName: "Amazon",
              address: "San Miguel, 123",
              country: "Ecuador",
              city: "Quito")),
      PostItem(
          id: 4,
          title: "Full Stack Developer",
          description: "Need a Full Stack Developer ",
          imageUrl:
              "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/202946464/original/51d81428d4cf9e08c5cf35709b9c54ab9ba41238/compile-and-test-your-code.jpeg",
          companyUniqueItem: CompanyUniqueItem(
              id: 3,
              firstName: "Robert",
              lastName: "Johnson",
              email: "robert@gmail.com",
              phone: "0987654321",
              password: "123456",
              role: "company",
              description:
                  "Experience as a manager of agile proyects. I work in Instagram. Every day is a challenge.",
              bannerImage:
                  "https://i.pinimg.com/originals/cb/05/f0/cb05f0ca5a29d510201e2c112aa2c0fa.jpg",
              ruc: "1234567890",
              owner: "Robert Johnson",
              companyName: "Amazon",
              address: "San Miguel, 123",
              country: "Ecuador",
              city: "Quito")),
      PostItem(
          id: 5,
          title: "Need a Full Stack Developer",
          description: "Need a Full Stack Developer ",
          imageUrl:
              "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/202946464/original/51d81428d4cf9e08c5cf35709b9c54ab9ba41238/compile-and-test-your-code.jpeg",
          companyUniqueItem: CompanyUniqueItem(
              id: 3,
              firstName: "Robert",
              lastName: "Johnson",
              email: "robert@gmail.com",
              phone: "0987654321",
              password: "123456",
              role: "company",
              description:
                  "Experience as a manager of agile proyects. I work in Instagram. Every day is a challenge.",
              bannerImage:
                  "https://i.pinimg.com/originals/cb/05/f0/cb05f0ca5a29d510201e2c112aa2c0fa.jpg",
              ruc: "1234567890",
              owner: "Robert Johnson",
              companyName: "Amazon",
              address: "San Miguel, 123",
              country: "Ecuador",
              city: "Quito")),
      PostItem(
          id: 6,
          title: "Need a Full Stack Developer",
          description: "Need a Full Stack Developer ",
          imageUrl:
              "https://thetapacademy.com/wp-content/uploads/2022/10/full-stack-web-developer-1024x1024.jpg",
          companyUniqueItem: CompanyUniqueItem(
              id: 3,
              firstName: "Robert",
              lastName: "Johnson",
              email: "robert@gmail.com",
              phone: "0987654321",
              password: "123456",
              role: "company",
              description:
                  "Experience as a manager of agile proyects. I work in Instagram. Every day is a challenge.",
              bannerImage:
                  "https://i.pinimg.com/originals/cb/05/f0/cb05f0ca5a29d510201e2c112aa2c0fa.jpg",
              ruc: "1234567890",
              owner: "Robert Johnson",
              companyName: "Amazon",
              address: "San Miguel, 123",
              country: "Ecuador",
              city: "Quito")),
    ];
  }

}
