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
          iconUrl: "",
          projectUrl: "")
    ];
  }
}
