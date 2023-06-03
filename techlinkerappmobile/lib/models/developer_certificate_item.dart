class DeveloperCertificateItem {
  String? id;
  String? title;
  String? description;
  String? iconUrl;
  String? obtainedDate;

  DeveloperCertificateItem({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.obtainedDate,
  });

  static List<DeveloperCertificateItem> developerCertificates() {
    return [
      DeveloperCertificateItem(
          id: "01",
          title: "React Certificate",
          description: "Soportyed by Facebook",
          iconUrl:
              "https://www.uplers.com/wp-content/uploads/2022/05/AngularJs-Frameworks-891x505.jpg",
          obtainedDate: "2023-05-29T17:11:06.780Z"),
      DeveloperCertificateItem(
          id: "02",
          title: "Angular Certificate",
          description: "Sopoorted by Google",
          iconUrl:
              "https://i0.wp.com/blog.webtraining.zone/wp-content/uploads/2018/01/curso-profesional-vue.jpg?resize=825%2C510&ssl=1",
          obtainedDate: "2023-05-29T17:11:06.780Z"),
    ];
  }
}
