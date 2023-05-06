class PostItem {
  String? id;
  String? title;
  String? description;
  String? imageUrl;
  String? companyProfileImage;

  PostItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.companyProfileImage,
  });

  static List<PostItem> allCompanyPosts() {
    return [
      PostItem(
          id: "01",
          title: "Need a Full Stack Developer",
          description: "Need a Full Stack Developer",
          imageUrl:
              "https://static.vecteezy.com/system/resources/previews/002/223/229/large_2x/abstract-technology-hi-tech-background-banner-template-with-copy-space-vector.jpg",
          companyProfileImage:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
      PostItem(
          id: "02",
          title: "Need a Full Stack Developer",
          description: "Need a Full Stack Developer ",
          imageUrl:
              "https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          companyProfileImage:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    ];
  }
}
