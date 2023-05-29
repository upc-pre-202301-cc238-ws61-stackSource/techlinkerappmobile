class DeveloperFrameworkItem {
  String? id;
  String? name;
  String? description;
  String? iconLink;

  DeveloperFrameworkItem({
    required this.id,
    required this.name,
    required this.description,
    required this.iconLink,
  });

  static List<DeveloperFrameworkItem> listOfDeveloperFrameworks() {
    return [
      DeveloperFrameworkItem(
          id: "01",
          name: "Vue",
          description: "3 Years of experience",
          iconLink:
              "https://cdn.iconscout.com/icon/free/png-256/vue-282497.png"),
    ];
  }
}
