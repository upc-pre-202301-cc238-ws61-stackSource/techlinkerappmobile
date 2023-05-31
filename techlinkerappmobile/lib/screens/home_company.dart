import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/screens/filter_developer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/developer_unique_item.dart';
import '../widgets/developer_item.dart';
import '../constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class CompanyHome extends StatefulWidget {
  CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  final developersItem = DeveloperUniqueItem.developerItems();
  List<dynamic> selectedSpecialityType = [];
  List<dynamic> selectedYearsOfExperience = [];
  List<dynamic> selectedFramework = [];
  List<dynamic> selectedProgrammingLanguage = [];
  List<dynamic> selectedDatabase = [];

  bool isLoding = true;

  final urlDevelopersImages = [];

  @override
  void initState() {
    super.initState();

    getDevelopersImageUrls();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
  }

  Future loadData() async {
    if (mounted) {
      setState(() => isLoding = true);
    }

    await Future.wait(urlDevelopersImages
        .map((urlImage) => cacheImage(context, urlImage))
        .toList());

    if (mounted) {
      setState(() => isLoding = false);
    }
  }

  Future cacheImage(BuildContext context, String urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage), context);

  void getDevelopersImageUrls() {
    for (var item in developersItem) {
      urlDevelopersImages.add(item.image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final filterDevelopersList = filterDevelopers();

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
                  await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeveloperFilter()))
                      .then((value) => {
                            if (value != null)
                              {
                                setState(() {
                                  selectedSpecialityType =
                                      value['selectedSpecialityType'];
                                  selectedFramework =
                                      value['selectedFramework'];
                                  selectedDatabase = value['selectedDatabase'];
                                  selectedProgrammingLanguage =
                                      value['selectedProgrammingLanguage'];
                                  selectedYearsOfExperience =
                                      value['selectedYearsOfExperience'];
                                })
                              }
                          });
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
                    padding: EdgeInsets.all(12.0),
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
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: ListView.builder(
                  itemCount: filterDevelopersList.length,
                  itemBuilder: (context, index) {
                    final developer = filterDevelopersList[index];

                    return isLoding
                        ? Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 219, 221, 225)!,
                            highlightColor: Colors.grey[200]!,
                            child: buildSkeleton(context))
                        : DeveloperItem(
                            item: developer,
                            urlImage: urlDevelopersImages[index],
                          );
                  }),
            ))
          ]),
        ));
  }

  Widget buildSkeleton(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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

  List<dynamic> filterDevelopers() {
    List<dynamic> filteredDevelopers1 = developersItem.where((specialzation) {
      return selectedSpecialityType.isEmpty ||
          selectedSpecialityType.contains(specialzation.specialityType);
    }).toList();

    List<dynamic> filteredDevelopers2 = filteredDevelopers1.where((developer) {
      return selectedFramework.isEmpty ||
          selectedFramework
              .every((framework) => developer.frameworks.contains(framework));
    }).toList();

    List<dynamic> filteredDevelopers3 = filteredDevelopers2.where((developer) {
      return selectedProgrammingLanguage.isEmpty ||
          selectedProgrammingLanguage.every(
              (language) => developer.programmingLanguage.contains(language));
    }).toList();

    List<dynamic> filteredDevelopers4 = filteredDevelopers3.where((developer) {
      return selectedDatabase.isEmpty ||
          selectedDatabase
              .every((database) => developer.database.contains(database));
    }).toList();

    return filteredDevelopers4;
  }
}
