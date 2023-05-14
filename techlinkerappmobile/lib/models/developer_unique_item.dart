class DeveloperUniqueItem {
  String? id;
  String? name;
  String? image;
  String? specialityType;
  int? yearsOfExperience;
  List<String>? frameworks;
  List<String>? programmingLanguage;
  List<String>? database;
  int? points;

  DeveloperUniqueItem(
      {required this.id,
      required this.name,
      required this.image,
      required this.specialityType,
      required this.yearsOfExperience,
      required this.frameworks,
      required this.programmingLanguage,
      required this.database,
      required this.points});

  static List<DeveloperUniqueItem> developerItems() {
    return [
      DeveloperUniqueItem(
          id: "01",
          name: "John Doe",
          image:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          specialityType: "Backend",
          yearsOfExperience: 3,
          frameworks: ["ASP.NET Core", "Angular"],
          programmingLanguage: ["C#", "JavaScript"],
          database: ["SQL Server", "MongoDB"],
          points: 67),
      DeveloperUniqueItem(
          id: "02",
          name: "Jane Smith",
          image:
              "https://images.pexels.com/photos/749091/pexels-photo-749091.jpeg",
          specialityType: "Frontend",
          yearsOfExperience: 6,
          frameworks: ["Angular", "React Native"],
          programmingLanguage: ["JavaScript", "TypeScript"],
          database: ["MySQL", "Oracle"],
          points: 85),
      DeveloperUniqueItem(
          id: "03",
          name: "Robert Johnson",
          image:
              "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg",
          specialityType: "Backend",
          yearsOfExperience: 4,
          frameworks: ["Django"],
          programmingLanguage: ["Python", "JavaScript"],
          database: ["PostgreSQL", "MySQL"],
          points: 72),
      DeveloperUniqueItem(
          id: "04",
          name: "Shao Leen",
          image:
              "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          specialityType: "FullStack",
          yearsOfExperience: 7,
          frameworks: ["Vue", "React Native"],
          programmingLanguage: ["JavaScript", "TypeScript", "Python"],
          database: ["MongoDB", "MySQL"],
          points: 91),
      DeveloperUniqueItem(
          id: "05",
          name: "Michael Chen",
          image:
              "https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          specialityType: "Mobile",
          yearsOfExperience: 1,
          frameworks: ["React Native", "Angular"],
          programmingLanguage: ["Java", "C#"],
          database: ["MongoDB"],
          points: 80),
      DeveloperUniqueItem(
          id: "06",
          name: "Emily Davis",
          image:
              "https://images.pexels.com/photos/774095/pexels-photo-774095.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          specialityType: "FullStack",
          yearsOfExperience: 2,
          frameworks: ["Vue"],
          programmingLanguage: ["JavaScript", "TypeScript"],
          database: ["MongoDB", "MySQL"],
          points: 63),
      DeveloperUniqueItem(
          id: "07",
          name: "John Doe",
          image:
              "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          specialityType: "Backend",
          yearsOfExperience: 3,
          frameworks: ["ASP.NET Core", "Angular"],
          programmingLanguage: ["C#", "JavaScript"],
          database: ["SQL Server", "MongoDB"],
          points: 67),
      DeveloperUniqueItem(
          id: "08",
          name: "Jane Smith",
          image:
              "https://images.pexels.com/photos/749091/pexels-photo-749091.jpeg",
          specialityType: "Frontend",
          yearsOfExperience: 6,
          frameworks: ["Angular", "React Native"],
          programmingLanguage: ["JavaScript", "TypeScript"],
          database: ["MySQL", "Oracle"],
          points: 85),
      DeveloperUniqueItem(
          id: "09",
          name: "Robert Johnson",
          image:
              "https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg",
          specialityType: "Backend",
          yearsOfExperience: 4,
          frameworks: ["Django"],
          programmingLanguage: ["Python", "JavaScript"],
          database: ["PostgreSQL", "MySQL"],
          points: 72),
      DeveloperUniqueItem(
          id: "10",
          name: "Shao Leen",
          image:
              "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          specialityType: "FullStack",
          yearsOfExperience: 7,
          frameworks: ["Vue", "React Native"],
          programmingLanguage: ["JavaScript", "TypeScript", "Python"],
          database: ["MongoDB", "MySQL"],
          points: 91),
      DeveloperUniqueItem(
          id: "11",
          name: "Michael Chen",
          image:
              "https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          specialityType: "Mobile",
          yearsOfExperience: 1,
          frameworks: ["React Native", "Angular"],
          programmingLanguage: ["Java", "C#"],
          database: ["MongoDB"],
          points: 80),
      DeveloperUniqueItem(
          id: "12",
          name: "Emily Davis",
          image:
              "https://images.pexels.com/photos/774095/pexels-photo-774095.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
          specialityType: "FullStack",
          yearsOfExperience: 2,
          frameworks: ["Vue"],
          programmingLanguage: ["JavaScript", "TypeScript"],
          database: ["MongoDB", "MySQL"],
          points: 63),
    ];
  }
}
