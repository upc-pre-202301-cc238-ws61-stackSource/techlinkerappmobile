import 'developer_study_center.dart';

class DeveloperCertificateItem {
  int? id;
  String? title;
  String? description;
  String? iconUrl;
  DateTime? obtainedDate;
  Education? education;
  DeveloperCertificateItem({
    required this.id,
    required this.title,
    required this.description,
    required this.iconUrl,
    required this.obtainedDate,
    required this.education
  });

  static List<DeveloperCertificateItem> developerCertificates() {
    return [
      DeveloperCertificateItem(
          id: 1,
          title: "React Certificate",
          description: "Soportyed by Facebook",
          iconUrl:
              "https://www.uplers.com/wp-content/uploads/2022/05/AngularJs-Frameworks-891x505.jpg",
          obtainedDate: DateTime.now(),
          education: Education(),
          ),
      DeveloperCertificateItem(
          id: 2,
          title: "Angular Certificate",
          description: "Sopoorted by Google",
          iconUrl:
              "https://i0.wp.com/blog.webtraining.zone/wp-content/uploads/2018/01/curso-profesional-vue.jpg?resize=825%2C510&ssl=1",
          obtainedDate: DateTime.now(),
          education: Education(),
        ),
    ];
  }
}
