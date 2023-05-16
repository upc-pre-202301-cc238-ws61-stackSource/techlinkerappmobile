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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 34,
            ),
            const Text(
              "Polular",
              style: TextStyle(
                  color: textColor, fontSize: 44, fontWeight: FontWeight.w800),
            ),
            const Text(
              "Developers",
              style: TextStyle(
                  color: textColor, fontSize: 44, fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 17,
            ),
            ElevatedButton(
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
                                selectedFramework = value['selectedFramework'];
                                selectedDatabase = value['selectedDatabase'];
                                selectedProgrammingLanguage =
                                    value['selectedProgrammingLanguage'];
                                selectedYearsOfExperience =
                                    value['selectedYearsOfExperience'];
                              })
                            }
                        });
              },
              child: Row(children: const [
                Icon(Icons.filter_list, color: textColor),
                Text('Filter Developers',
                    style: TextStyle(color: textColor, fontSize: 17))
              ]),
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("All Developers",
                style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w700)),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: filterDevelopersList.length,
                    itemBuilder: (context, index) {
                      final developer = filterDevelopersList[index];

                      return isLoding
                          ? Shimmer.fromColors(
                              baseColor: secondaryColor,
                              highlightColor: loadingColor,
                              child: buildSkeleton(context))
                          : DeveloperItem(
                              item: developer,
                              urlImage: urlDevelopersImages[index],
                            );
                    }))
          ]),
        ));
  }

  Widget buildSkeleton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: loadingColor),
      height: 100,
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
