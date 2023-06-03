class DeveloperProjectItem {
  String? id;
  String? name;
  String? description;
  String? iconUrl;
  String? projectUrl;

  DeveloperProjectItem({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.projectUrl,
  });

  static List<DeveloperProjectItem> developerProjects() {
    return [
      DeveloperProjectItem(
          id: "01",
          name: "React Project",
          description: "Tourism App for Folclore Commpany",
          iconUrl:
              "https://www.uplers.com/wp-content/uploads/2022/05/AngularJs-Frameworks-891x505.jpg",
          projectUrl: "https://cutt.ly/lwqJX4tf"),
      DeveloperProjectItem(
          id: "02",
          name: "Angular Project",
          description: "Tourism App for Folclore Commpany",
          iconUrl:
              "https://i0.wp.com/blog.webtraining.zone/wp-content/uploads/2018/01/curso-profesional-vue.jpg?resize=825%2C510&ssl=1",
          projectUrl: "https://cutt.ly/lwqJX4tf"),
    ];
  }
}
