import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/digital_profile.dart';
import 'package:techlinkerappmobile/models/framework.dart';
import 'package:techlinkerappmobile/screens/filter_developer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import '../models/database.dart';
import '../models/developer.dart';
import '../models/programming_language.dart';
import '../widgets/developer_item.dart';
import '../constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class CompanyHome extends StatefulWidget {
  final int companyId;
  CompanyHome({super.key, required this.companyId});

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
      getDevelopersImageUrls(value).then((value) {
        WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
        filteredDevelopers = developers;
      });
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

  Future<Map<String, String>> getDevelopersImageUrls(
      List<Developer> backDevelopers) async {
    for (var item in backDevelopers) {
      urlDevelopersImages[item.id!.toString()] = item.image!;
    }

    if (mounted) {
      setState(() {});
    }

    return urlDevelopersImages;
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
                  if (mounted) {
                    setState(() {
                      isLoding = true;
                    });
                  }

                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DeveloperFilter())).then((value) => {
                        if (value != null)
                          {
                            if (mounted)
                              {
                                setState(() {
                                  selectedFramework =
                                      value['selectedFramework'];
                                  selectedDatabase = value['selectedDatabase'];
                                  selectedProgrammingLanguage =
                                      value['selectedProgrammingLanguage'];
                                  selectedYearsOfExperience =
                                      value['selectedYearsOfExperience'];
                                  //convert filters to lower case
                                  selectedFramework = selectedFramework
                                      .map((framework) =>
                                          framework.toLowerCase())
                                      .toList();
                                  selectedDatabase = selectedDatabase
                                      .map((database) => database.toLowerCase())
                                      .toList();
                                  selectedProgrammingLanguage =
                                      selectedProgrammingLanguage
                                          .map((language) =>
                                              language.toLowerCase())
                                          .toList();
                                  selectedYearsOfExperience =
                                      selectedYearsOfExperience
                                          .map((experience) => experience
                                              .toString()
                                              .toLowerCase())
                                          .toList();
                                })
                              }
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
            isLoding
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
                : filteredDevelopers.isEmpty
                    ? Container(
                        padding: EdgeInsets.only(top: 120),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //create a button to assign all data from developers to filtered developers
                            const Center(
                              child: Text(
                                'No developers found',
                                style: TextStyle(
                                  color: cardTextColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    filteredDevelopers = developers;
                                  });
                                }
                              },
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
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Text(
                                    'Show all developers',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
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
                                      companyId: widget.companyId,
                                    );
                            }),
                      )),
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
    List<Framework> frameworks = await getAllFrameworks();
    List<ProgrammingLanguage> programmingLanguages =
        await getAllProgrammingLanguages();
    List<Database> databases = await getAllDatabases();

    //to lower case
    frameworks = frameworks
        .map((framework) => Framework(
              description: framework.description,
              digitalProfile:
                  DigitalProfile.fromJson(framework.digitalProfile!.toJson()),
              iconLink: framework.iconLink,
              id: framework.id,
              name: framework.name!.toLowerCase(),
            ))
        .toList();

    programmingLanguages = programmingLanguages
        .map((language) => ProgrammingLanguage(
              description: language.description,
              digitalProfile:
                  DigitalProfile.fromJson(language.digitalProfile!.toJson()),
              iconLink: language.iconLink,
              id: language.id,
              name: language.name!.toLowerCase(),
            ))
        .toList();

    databases = databases
        .map((database) => Database(
              description: database.description,
              digitalProfile:
                  DigitalProfile.fromJson(database.digitalProfile!.toJson()),
              iconLink: database.iconLink,
              id: database.id,
              name: database.name!.toLowerCase(),
            ))
        .toList();

    List<int?> filteredDeveloperIds =
        developers.map((developer) => developer.id).toList();

    if (selectedFramework.isNotEmpty) {
      // Apply framework filter

      filteredDeveloperIds = filteredDeveloperIds.where((developerId) {
        List<Framework> developerFrameworks = frameworks
            .where((framework) => framework.digitalProfile!.id == developerId)
            .toList();
        return selectedFramework.every((selectedFramework) =>
            developerFrameworks
                .any((framework) => framework.name == selectedFramework));
      }).toList();
    }

    if (selectedProgrammingLanguage.isNotEmpty) {
      // Apply programming language filter
      filteredDeveloperIds = filteredDeveloperIds.where((developerId) {
        List<ProgrammingLanguage> developerLanguages = programmingLanguages
            .where((language) => language.digitalProfile.id == developerId)
            .toList();
        return selectedProgrammingLanguage.every((selectedLanguage) =>
            developerLanguages
                .any((language) => language.name == selectedLanguage));
      }).toList();
    }

    if (selectedDatabase.isNotEmpty) {
      // Apply database filter
      filteredDeveloperIds = filteredDeveloperIds.where((developerId) {
        List<Database> developerDatabases = databases
            .where((database) => database.digitalProfile.id == developerId)
            .toList();
        return selectedDatabase.every((selectedDatabase) => developerDatabases
            .any((database) => database.name == selectedDatabase));
      }).toList();
    }

    if (mounted) {
      setState(() {
        //check if there is not any filter and set filter developers with all developer if thats the case

        if (selectedFramework.isEmpty &&
            selectedProgrammingLanguage.isEmpty &&
            selectedDatabase.isEmpty) {
          filteredDevelopers = developers;
          isLoding = false;
          return;
        }

        filteredDevelopers = developers
            .where((developer) => filteredDeveloperIds.contains(developer.id))
            .toList();
        print('Filtered developers: $filteredDevelopers');
        isLoding = false;
      });
    }
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

  Future<List<Developer>> getAllDevelopers() async {
    try {
      final developersData = await DeveloperService.getAllDevelopers();
      if (mounted) {
        //convert json data to list of developers
        final backDevelopers = developersData
            .map((developer) => Developer.fromJson(developer))
            .toList();

        if (mounted) {
          setState(() {
            developers = backDevelopers;
          });
        }

        print('Developers: $backDevelopers');

        return backDevelopers;
      }
    } catch (e) {
      print('Failed to fetch developers data. Error: $e');
    }

    return [];
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
}
