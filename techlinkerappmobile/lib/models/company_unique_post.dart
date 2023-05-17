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
              "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2022/06/Coder.jpeg.jpg",
          companyProfileImage:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
      PostItem(
          id: "03",
          title: "Need a Full Stack Developer",
          description: "Need a Full Stack Developer ",
          imageUrl:
              "https://ik.imagekit.io/6eslefmcf/flexiple-blog/freelance-coding-websites-16x9-1024x636-tpbm9_bwAWF-mlH.jpg",
          companyProfileImage:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
      PostItem(
          id: "04",
          title: "Need a Full Stack Developer",
          description: "Need a Full Stack Developer ",
          imageUrl:
              "https://fiverr-res.cloudinary.com/images/t_main1,q_auto,f_auto,q_auto,f_auto/gigs/202946464/original/51d81428d4cf9e08c5cf35709b9c54ab9ba41238/compile-and-test-your-code.jpeg",
          companyProfileImage:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
      PostItem(
          id: "05",
          title: "Need a Full Stack Developer",
          description: "Need a Full Stack Developer ",
          imageUrl:
              "https://img.freepik.com/vector-premium/plantilla-pagina-inicio-desarrollador-web-independiente-ilustracion-sitio-web-codificacion-hombres_115338-22.jpg?w=2000",
          companyProfileImage:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
      PostItem(
          id: "06",
          title: "Need a Full Stack Developer",
          description: "Need a Full Stack Developer ",
          imageUrl:
              "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          companyProfileImage:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    ];
  }
}
