import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/developer_study_center.dart';
import 'package:techlinkerappmobile/models/framework.dart';
import 'package:techlinkerappmobile/screens/filter_developer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import '../models/database.dart';
import '../models/developer_unique_item.dart';
import '../models/programming_language.dart';
import '../widgets/developer_item.dart';
import '../constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class CompanyHome extends StatefulWidget {
  CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  List<dynamic> selectedYearsOfExperience = [];
  List<dynamic> selectedFramework = [];
  List<dynamic> selectedProgrammingLanguage = [];
  List<dynamic> selectedDatabase = [];
  List<Developer> developers = [];
  List<Developer> filteredDevelopers = [];

  bool isLoding = true;

  Map<String, String> urlDevelopersImages = {};

  @override
  void initState() {
    super.initState();

    getAllDevelopers().then((value) {
      getDevelopersImageUrls();
      WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
      filteredDevelopers = developers;
    });

    getAllFrameworks();
  }

  Future loadData() async {
    if (mounted) {
      setState(() => isLoding = true);
    }

    await Future.wait(urlDevelopersImages.entries
        .map((urlImage) => cacheImage(context, urlImage.value))
        .toList());

    if (mounted) {
      setState(() => isLoding = false);
    }
  }

  Future cacheImage(BuildContext context, String urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage), context);

  void getDevelopersImageUrls() {
    for (var item in developers) {
      urlDevelopersImages[item.id!.toString()] = item.image!;
    }
  }

  @override
  Widget build(BuildContext context) {
    //final filterDevelopersList = filterDevelopers();

    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF39BCFD),
                    Color(0xFF4F93E9),
                    Color(0xFF7176EE),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(children: const [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Polular",
                  style: TextStyle(
                      color: cardColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "Developers",
                  style: TextStyle(
                      color: cardColor,
                      fontSize: 41,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(
                  height: 25,
                )
              ]),
            ),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    isLoding = true;
                  });
                  await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeveloperFilter()))
                      .then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  selectedFramework =
                                      value['selectedFramework'];
                                  selectedDatabase = value['selectedDatabase'];
                                  selectedProgrammingLanguage =
                                      value['selectedProgrammingLanguage'];
                                  selectedYearsOfExperience =
                                      value['selectedYearsOfExperience'];
                                })
                              },
                          });
                  filterDevelopers();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors
                      .transparent, // Set the background color to transparent
                  elevation: 0, // Remove the button's shadow
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF39BCFD),
                        Color(0xFF4F93E9),
                        Color(0xFF7176EE),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(children: const [
                      Icon(Icons.filter_list, color: cardColor),
                      Text('Filter Developers',
                          style: TextStyle(color: cardColor, fontSize: 17)),
                    ]),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 5),
              child: Text("All Developers",
                  style: TextStyle(
                      color: mainTextInBackground,
                      fontSize: 18,
                      fontWeight: FontWeight.w700)),
            ),
            const SizedBox(
              height: 10,
            ),
            developers.isEmpty
                ? //create progress indicator while loading data
                Expanded(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                              baseColor: Color.fromARGB(255, 219, 221, 225)!,
                              highlightColor: Colors.grey[200]!,
                              child: buildSkeleton(context));
                        }),
                  ))
                : Expanded(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23),
                    child: ListView.builder(
                        itemCount: filteredDevelopers.length,
                        itemBuilder: (context, index) {
                          final developer = filteredDevelopers[index];

                          return isLoding
                              ? Shimmer.fromColors(
                                  baseColor:
                                      Color.fromARGB(255, 219, 221, 225)!,
                                  highlightColor: Colors.grey[200]!,
                                  child: buildSkeleton(context))
                              : DeveloperItem(
                                  item: developer,
                                  urlImage: urlDevelopersImages[
                                      developer.id!.toString()]!,
                                );
                        }),
                  ))
          ]),
        ));
  }

  Widget buildSkeleton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(126, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            //create a circle for simulating the image of avatar
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 150,
                    height: 13,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void filterDevelopers() async {
    //aplying framework filter

    List<Framework> frameworks = await getAllFrameworks();

    Map<int, List<Framework>> frameworksByDeveloper = {};

    for (var framework in frameworks) {
      int digitalProfileId = framework.digitalProfile.id!;

      if (frameworksByDeveloper.containsKey(digitalProfileId)) {
        frameworksByDeveloper[digitalProfileId]!.add(framework);
      } else {
        frameworksByDeveloper[digitalProfileId] = [framework];
      }
    }

    List<int> devFilterByFramework = frameworksByDeveloper.entries
        .where((entry) {
          List<Framework> developerFrameworks = entry.value;
          return selectedFramework.every((selectedFramework) =>
              developerFrameworks
                  .any((framework) => framework.name == selectedFramework));
        })
        .map((entry) => entry.key)
        .toList();

    //aplying programming language filter

    List<ProgrammingLanguage> networkProgrammingLanguages =
        await getAllProgrammingLanguages();

    List<ProgrammingLanguage> programmingLanguages = networkProgrammingLanguages
        .where((programmingLanguage) => devFilterByFramework
            .contains(programmingLanguage.digitalProfile.id))
        .toList();

    Map<int, List<ProgrammingLanguage>> programmingLanguagesByDeveloper = {};

    for (var programmingLanguage in programmingLanguages) {
      int digitalProfileId = programmingLanguage.digitalProfile.id!;

      if (programmingLanguagesByDeveloper.containsKey(digitalProfileId)) {
        programmingLanguagesByDeveloper[digitalProfileId]!
            .add(programmingLanguage);
      } else {
        programmingLanguagesByDeveloper[digitalProfileId] = [
          programmingLanguage
        ];
      }
    }

    List<int> devFilterByProgrammingLanguage = programmingLanguagesByDeveloper
        .entries
        .where((entry) {
          List<ProgrammingLanguage> developerProgrammingLanguages = entry.value;
          return selectedProgrammingLanguage.every(
              (selectedProgrammingLanguage) =>
                  developerProgrammingLanguages.any((programmingLanguage) =>
                      programmingLanguage.name == selectedProgrammingLanguage));
        })
        .map((entry) => entry.key)
        .toList();

    //aplying database filter

    List<Database> networkDatabases = await getAllDatabases();

    List<Database> databases = networkDatabases
        .where((database) =>
            devFilterByProgrammingLanguage.contains(database.digitalProfile.id))
        .toList();

    Map<int, List<Database>> databasesByDeveloper = {};

    for (var database in databases) {
      int digitalProfileId = database.digitalProfile.id!;

      if (databasesByDeveloper.containsKey(digitalProfileId)) {
        databasesByDeveloper[digitalProfileId]!.add(database);
      } else {
        databasesByDeveloper[digitalProfileId] = [database];
      }
    }

    List<int> devFilterByDatabase = databasesByDeveloper.entries
        .where((entry) {
          List<Database> developerDatabases = entry.value;
          return selectedDatabase.every((selectedDatabase) => developerDatabases
              .any((database) => database.name == selectedDatabase));
        })
        .map((entry) => entry.key)
        .toList();

    setState(() {
      filteredDevelopers = developers
          .where((developer) => devFilterByDatabase.contains(developer.id))
          .toList();
      isLoding = false;
    });
  }

  Future<List<Framework>> getAllFrameworks() async {
    try {
      final frameworksData = await DeveloperService.getAllFrameworks();
      if (mounted) {
        final frameworks = frameworksData
            .map<Framework>((framework) => Framework(
                  description: framework['description'],
                  digitalProfile:
                      DigitalProfile.fromJson(framework['digitalProfile']),
                  iconLink: framework['iconLink'],
                  id: framework['id'],
                  name: framework['name'],
                ))
            .toList();
        return frameworks;
      }
    } catch (e) {
      print('Failed to fetch frameworks data. Error: $e');
    }

    return [];
  }

  Future<void> getAllDevelopers() async {
    try {
      final developersData = await DeveloperService.getAllDevelopers();
      if (mounted) {
        //convert json data to list of developers
        final developers = developersData
            .map((developer) => Developer.fromJson(developer))
            .toList();

        setState(() {
          this.developers = developers;
        });
      }
    } catch (e) {
      print('Failed to fetch developers data. Error: $e');
    }
  }

  Future<List<ProgrammingLanguage>> getAllProgrammingLanguages() async {
    try {
      final programmingLanguagesData =
          await DeveloperService.getAllProgrammingLanguages();
      if (mounted) {
        final programmingLanguages = programmingLanguagesData
            .map<ProgrammingLanguage>((programmingLanguage) =>
                ProgrammingLanguage.fromJson(programmingLanguage))
            .toList();
        return programmingLanguages;
      }
    } catch (e) {
      print('Failed to fetch programming languages data. Error: $e');
    }

    return [];
  }

  Future<List<Database>> getAllDatabases() async {
    try {
      final databasesData = await DeveloperService.getAllDatabases();
      if (mounted) {
        final databases = databasesData
            .map<Database>((database) => Database.fromJson(database))
            .toList();
        return databases;
      }
    } catch (e) {
      print('Failed to fetch databases data. Error: $e');
    }

    return [];
  }


  Future<>

}
