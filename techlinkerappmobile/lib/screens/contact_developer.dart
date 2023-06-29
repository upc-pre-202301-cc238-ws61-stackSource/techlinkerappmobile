import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/constants/colors.dart';

import 'package:techlinkerappmobile/screens/developer_certificate_create.dart';
import 'package:techlinkerappmobile/screens/developer_education_post.dart';

import 'package:techlinkerappmobile/models/database.dart';
import 'package:techlinkerappmobile/models/programming_language.dart';
import 'package:techlinkerappmobile/models/study_center.dart';
import 'package:techlinkerappmobile/screens/home_company.dart';

import 'package:techlinkerappmobile/widgets/developer_certificate.dart';
import 'package:techlinkerappmobile/widgets/developer_database.dart';
import 'package:techlinkerappmobile/widgets/developer_framework.dart';
import 'package:techlinkerappmobile/widgets/developer_programming_language.dart';
import 'package:techlinkerappmobile/widgets/developer_project.dart';
import '../models/certificate.dart';
import '../models/company.dart';
import '../models/company_unique_post.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/developer.dart';
import '../models/developer_x_message.dart';
import '../models/education.dart';
import '../models/framework.dart';
import '../models/message.dart';
import '../models/project.dart';
import '../services/company_service.dart';
import '../services/developer_service.dart';
import '../widgets/developer_study_center.dart';
import 'common/flash-correct-message-widget.dart';
import 'message_company_inbox.dart';

class ContactDeveloper extends StatefulWidget {
  final Developer developer;
  final int companyId;
  const ContactDeveloper(
      {required this.developer, required this.companyId, super.key});

  @override
  State<ContactDeveloper> createState() => _ContactDeveloperState();
}

class _ContactDeveloperState extends State<ContactDeveloper> {
  DeveloperMessage? developerMessageContact;
  final urlPostImages = [];
  final urlProjects = [];
  bool isLoading = true;
  bool usersIconisLoading = true;
  bool projectsIconisLoading = true;
  bool certificatesIconisLoading = true;
  bool studyCenterIconisLoading = true;
  bool apiHasBeenCalled = false;

  final companyPosts = PostItem.allCompanyPosts();
  List<Framework> developerFrameworks = [];
  List<Database> developerDatabases = [];
  List<Project> developerProjects = [];
  List<ProgrammingLanguage> developerProgrammingLanguages = [];
  List<Certificate> developerCertificates = [];
  List<StudyCenter> developerStudyCenters = [];

  List<StudyCenter> developerStudyCentersAtInit = [];
  List<Framework> developerFrameworksAtInit = [];
  List<Database> developerDatabasesAtInit = [];
  List<Project> developerProjectsAtInit = [];
  List<ProgrammingLanguage> developerProgrammingLanguagesAtInit = [];
  List<Certificate> developerCertificatesAtInit = [];

  final urlUserIcons = [
    "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/774095/pexels-photo-774095.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  ];

  @override
  void initState() {
    developerStudyCentersAtInit.add(StudyCenter.empty());
    developerFrameworksAtInit.add(Framework.empty());
    developerDatabasesAtInit.add(Database.empty());
    developerProjectsAtInit.add(Project.empty());
    developerProgrammingLanguagesAtInit.add(ProgrammingLanguage.empty());
    developerCertificatesAtInit.add(Certificate.empty());

    developerMessageContact =
        DeveloperMessage(developer: widget.developer, message: Message.empty());
    super.initState();
    //create delay to show shimmer 2 seconds

    getEducationByDigitalProfileId(widget.developer.id!.toString())
        .then((value) async {
      developerStudyCenters = await getStudyCentersByEducation(value);
      developerProjects =
          await getProjectsByDigitalProfileId(widget.developer.id!.toString());
      developerFrameworks = await getFrameworksByDigitalProfileId(
          widget.developer.id!.toString());
      developerDatabases = await getDatabasesByDigitalProfileId(//error
          widget.developer.id!.toString());
      developerProgrammingLanguages =
          await getProgrammingLanguagesByDigitalProfileId(
              widget.developer.id!.toString());
      developerCertificates = await getCertficationsByEducationId(value);

      if (mounted) {
        setState(() => {});
        apiHasBeenCalled = true;
      }
    });

    getPostImages();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
  }

  Future loadData() async {
    if (mounted) {
      setState(() => isLoading = true);
    }

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      await Future.wait(urlPostImages
          .map((urlImage) => cacheImage(context, urlImage))
          .toList());

      await Future.wait(urlUserIcons
          .map((urlImage) => cacheImage(context, urlImage))
          .toList());
    }

    if (mounted) {
      setState(() => {
            isLoading = false,
            usersIconisLoading = false,
            projectsIconisLoading = false,
            certificatesIconisLoading = false,
            studyCenterIconisLoading = false,
          });
    }
  }

  Future cacheImage(BuildContext context, String urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage), context);

  void getPostImages() {
    for (var item in companyPosts) {
      urlPostImages.add(item.imageUrl!);
    }
  }

  Future notifyToDeveloper(String id, String idReceiver) async {
    final response = await CompanyService.getCompanyById(id);
    Company company = Company.fromJson(response);
    await CompanyService.sendNotificationFromCompanyToDeveloper(id, idReceiver,
        'Company ${company.firstName} is interest in your profile');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView(
            children: [
              //create an app back width ios back icon and "Developer Profile" text

              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF39BCFD),
                      Color(0xFF4F93E9),
                      Color(0xFF7176EE),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    //create a row with back icon and "Developer Profile" text
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const Text(
                          "Developer Profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 17),
                    Center(
                      child: isLoading
                          ? Shimmer.fromColors(
                              baseColor: Color.fromARGB(255, 219, 221, 225)!,
                              highlightColor: Colors.grey[200]!,
                              child: buildSkeletonCard(context),
                            )
                          : buildProfileCard(),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Contact Options',
                        textAlign: TextAlign.justify,
                        style: const TextStyle(
                            color: textColor,
                            fontSize: 19,
                            fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 120),
                child: Row(
                  children: [
                    ElevatedButton(
                        onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompanyMessageInbox(
                                      companyId: widget.companyId!,
                                      item: developerMessageContact!),
                                ),
                              ),
                            },
                        child: Icon(Icons.message)),
                    const SizedBox(
                      width: 40,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          notifyToDeveloper(widget.companyId!.toString(),
                              widget.developer.id!.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: FlashCorrectMessageWidget(
                                  message: 'Notification sent successfully'),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                            ),
                          );
                        },
                        child: Icon(Icons.notification_add)),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Education",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 250, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  autoPlay: false, // Enable automatic sliding
                  viewportFraction: 0.8,
                ),
                items: (developerStudyCenters.isEmpty
                        ? developerStudyCentersAtInit
                        : developerStudyCenters)
                    .map((item) => developerStudyCenters.isEmpty
                        ? apiHasBeenCalled
                            ? skeletonAddItem()
                            : Shimmer.fromColors(
                                baseColor: Color.fromARGB(255, 219, 221, 225)!,
                                highlightColor: Colors.grey[200]!,
                                child: skeletonPostItem(context),
                              )
                        : DeveloperStudyCenter(
                            studyCenter: item, studyCenterIcon: item.iconUrl!))
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Frameworks",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  // Enable automatic sliding
                  viewportFraction: developerFrameworks.isEmpty ? 0.7 : 0.5,

                  // Add more options as needed
                ),
                items: (developerFrameworks.isEmpty
                        ? developerFrameworksAtInit
                        : developerFrameworks)
                    .map((item) => developerFrameworks.isEmpty
                        ? apiHasBeenCalled
                            ? skeletonAddItem()
                            : Shimmer.fromColors(
                                baseColor: Color.fromARGB(255, 219, 221, 225)!,
                                highlightColor: Colors.grey[200]!,
                                child: skeletonPostItem(context),
                              )
                        : DeveloperFramework(
                            framework: item, frameworkIcon: item.iconLink!))
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Database",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  // Enable automatic sliding
                  viewportFraction: developerDatabases.isEmpty ? 0.7 : 0.5,

                  // Add more options as needed
                ),
                items: (developerDatabases.isEmpty
                        ? developerDatabasesAtInit
                        : developerDatabases)
                    .map((item) => developerDatabases.isEmpty
                        ? apiHasBeenCalled
                            ? skeletonAddItem()
                            : Shimmer.fromColors(
                                baseColor: Color.fromARGB(255, 219, 221, 225)!,
                                highlightColor: Colors.grey[200]!,
                                child: skeletonPostItem(context),
                              )
                        : DeveloperDatabase(
                            database: item, databaseIcon: item.iconLink!))
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Programming Languages",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  // Enable automatic sliding
                  viewportFraction:
                      developerProgrammingLanguages.isEmpty ? 0.7 : 0.5,

                  // Add more options as needed
                ),
                items: (developerProgrammingLanguages.isEmpty
                        ? developerProgrammingLanguagesAtInit
                        : developerProgrammingLanguages)
                    .map((item) => developerProgrammingLanguages.isEmpty
                        ? apiHasBeenCalled
                            ? skeletonAddItem()
                            : Shimmer.fromColors(
                                baseColor: Color.fromARGB(255, 219, 221, 225)!,
                                highlightColor: Colors.grey[200]!,
                                child: skeletonPostItem(context),
                              )
                        : DeveloperProgrammingLanguage(
                            programmingLanguage: item,
                            programmingLanguageIcon: item.iconLink!))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Projects",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 250, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  autoPlay: false, // Enable automatic sliding
                  viewportFraction: developerProjects.isEmpty ? 0.7 : 0.5,

                  // Add more options as needed
                ),
                items: (developerProjects.isEmpty
                        ? developerProjectsAtInit
                        : developerProjects)
                    .map((item) => developerProjects.isEmpty
                        ? apiHasBeenCalled
                            ? skeletonAddItem()
                            : Shimmer.fromColors(
                                baseColor: Color.fromARGB(255, 219, 221, 225)!,
                                highlightColor: Colors.grey[200]!,
                                child: skeletonPostItem(context),
                              )
                        : DeveloperProject(
                            project: item, projectIcon: item.iconUrl!))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Certificates & Awards",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 240, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  // Enable automatic sliding
                  viewportFraction: 0.6,

                  // Add more options as needed
                ),
                items: (developerCertificates.isEmpty
                        ? developerCertificatesAtInit
                        : developerCertificates)
                    .map((item) => developerCertificates.isEmpty
                        ? apiHasBeenCalled
                            ? skeletonAddItem()
                            : Shimmer.fromColors(
                                baseColor: Color.fromARGB(255, 219, 221, 225)!,
                                highlightColor: Colors.grey[200]!,
                                child: skeletonPostItem(context),
                              )
                        : DeveloperCertificate(
                            certificate: item, certificateIcon: item.iconUrl!))
                    .toList(),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          )),
        ],
      )),
    );
  }

  Widget skeletonAddItem() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(154, 228, 228, 228),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.transparent,
          ),
          const SizedBox(height: 10),
          Text(
            "No Data Yet",
            style: TextStyle(
              color: Color.fromARGB(255, 169, 169, 169),
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget skeletonPostItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(154, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 20,
            color: Colors.grey[200],
            margin: EdgeInsets.only(bottom: 10),
          ),
          Container(
            width: double.infinity,
            height: 12,
            color: Colors.grey[200],
            margin: EdgeInsets.only(bottom: 6),
          ),
          Container(
            width: double.infinity,
            height: 12,
            color: Colors.grey[200],
          ),
        ],
      ),
    );
  }

  Widget buildSkeletonUserIcon(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: loadingColor),
      height: 30,
    );
  }

  Card buildProfileCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(widget.developer.image!),
            ),
            const SizedBox(height: 16),
            Text(
              '${widget.developer.firstName!} ${widget.developer.lastName!}',
              style: const TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 5),
            Text(
              widget.developer.email!,
              style: const TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget buildSkeletonCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 65),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(152, 255, 255, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, top: 10),
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: loadingColor,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 150,
            height: 18,
            color: loadingColor,
          ),
          const SizedBox(height: 8),
          Container(
            width: 200,
            height: 16,
            color: loadingColor,
          ),
        ],
      ),
    );
  }

  //get education by digital profile id
  Future<String> getEducationByDigitalProfileId(String id) async {
    try {
      final educationData =
          await DeveloperService.getEducationByDigitalProfileId(id);
      if (mounted) {
        final education = Education.fromJson(educationData);
        return education.id.toString();
      }
    } catch (e) {
      print('Failed to fetch education data. Error: $e');
    }

    return "";
  }

  // get study centers by education id
  Future<List<StudyCenter>> getStudyCentersByEducation(
      String educationId) async {
    try {
      final studyCentersData =
          await DeveloperService.getStudyCentersByEducationId(educationId);
      if (mounted) {
        final studyCenters = studyCentersData
            .map<StudyCenter>(
                (studyCenter) => StudyCenter.fromJson(studyCenter))
            .toList();
        return studyCenters;
      }
    } catch (e) {
      print('Failed to fetch study centers data. Error: $e');
    }

    return [];
  }

  //get projects by digital profile id
  Future<List<Project>> getProjectsByDigitalProfileId(String id) async {
    try {
      final projectsData =
          await DeveloperService.getProjectsByDigitalProfileId(id);
      if (mounted) {
        final projects = projectsData
            .map<Project>((project) => Project.fromJson(project))
            .toList();
        return projects;
      }
    } catch (e) {
      print('Failed to fetch projects data. Error: $e');
    }

    return [];
  }

  //get frameworks by digital profile id
  Future<List<Framework>> getFrameworksByDigitalProfileId(String id) async {
    try {
      final frameworksData =
          await DeveloperService.getFrameworksByDigitalProfileId(id);
      if (mounted) {
        final frameworks = frameworksData
            .map<Framework>((framework) => Framework.fromJson(framework))
            .toList();
        return frameworks;
      }
    } catch (e) {
      print('Failed to fetch frameworks data. Error: $e');
    }

    return [];
  }

  //get databases by digital profile id
  Future<List<Database>> getDatabasesByDigitalProfileId(String id) async {
    try {
      final databasesData =
          await DeveloperService.getDatabasesByDigitalProfileId(id);
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

  //get programming languages by digital profile id
  Future<List<ProgrammingLanguage>> getProgrammingLanguagesByDigitalProfileId(
      String id) async {
    try {
      final programmingLanguagesData =
          await DeveloperService.getProgrammingLanguagesByDigitalProfileId(id);
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

  //get certifications by digital profile id
  Future<List<Certificate>> getCertficationsByEducationId(String id) async {
    try {
      final certificationsData =
          await DeveloperService.getCertificationsByEducationId(id);
      if (mounted) {
        final certifications = certificationsData
            .map<Certificate>(
                (certificate) => Certificate.fromJson(certificate))
            .toList();
        return certifications;
      }
    } catch (e) {
      print('Failed to fetch certifications data. Error: $e');
    }

    return [];
  }
}
