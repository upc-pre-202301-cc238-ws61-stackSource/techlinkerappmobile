import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/screens/common/flash-incorrect-message-widget.dart';

import 'package:techlinkerappmobile/screens/developer_certificate_create.dart';
import 'package:techlinkerappmobile/screens/developer_education_post.dart';

import 'package:techlinkerappmobile/models/database.dart';
import 'package:techlinkerappmobile/models/programming_language.dart';
import 'package:techlinkerappmobile/models/study_center.dart';
import 'package:techlinkerappmobile/screens/login.dart';
import 'package:techlinkerappmobile/widgets/connect_github.dart';

import 'package:techlinkerappmobile/widgets/developer_certificate.dart';
import 'package:techlinkerappmobile/widgets/developer_database.dart';
import 'package:techlinkerappmobile/widgets/developer_framework.dart';
import 'package:techlinkerappmobile/widgets/developer_programming_language.dart';
import 'package:techlinkerappmobile/widgets/developer_project.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/certificate.dart';
import '../models/company_unique_post.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/developer.dart';
import '../models/digital_profile.dart';
import '../models/education.dart';
import '../models/framework.dart';
import '../models/project.dart';
import '../services/developer_service.dart';
import '../widgets/developer_study_center.dart';
import 'common/flash-correct-message-widget.dart';
import 'developer-Database-create.dart';
import 'developer-Frameworks-create.dart';
import 'developer-ProgramingLanguajes-create.dart';
import 'developer-editProfile.dart';
import 'developer-project-post.dart';

class DeveloperProfile extends StatefulWidget {
  final int developerId;
  const DeveloperProfile({required this.developerId, super.key});

  @override
  State<DeveloperProfile> createState() => _DeveloperProfileState();
}

class _DeveloperProfileState extends State<DeveloperProfile> {
  final urlPostImages = [];
  final urlProjects = [];
  bool isLoading = true;
  bool usersIconisLoading = true;
  bool projectsIconisLoading = true;
  bool certificatesIconisLoading = true;
  bool studyCenterIconisLoading = true;
  bool apiHasBeenCalled = false;

  Developer MyDeveloper = Developer();
  DigitalProfile? digProfile;
  int educationId = 0;

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

  String githubUsername = "none";
  String githubAvatarUrl = "none";
  String githubUrl = "none";

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    developerStudyCentersAtInit.add(StudyCenter.empty());
    developerFrameworksAtInit.add(Framework.empty());
    developerDatabasesAtInit.add(Database.empty());
    developerProjectsAtInit.add(Project.empty());
    developerProgrammingLanguagesAtInit.add(ProgrammingLanguage.empty());
    developerCertificatesAtInit.add(Certificate.empty());

    // Crear un retraso para mostrar el efecto shimmer durante 2 segundos
    getDeveloperById(widget.developerId.toString()).then((developer) {
      if (mounted) {
        setState(() {
          MyDeveloper = developer;
        });
      }
      getDigitalProfileByDeveloperId(widget.developerId.toString())
          .then((digital) {
        if (mounted) {
          setState(() {
            digProfile = digital;
          });
        }
      }).then((value) {
        getEducationByDigitalProfileId(digProfile!.id.toString())
            .then((value) async {
          developerStudyCenters = await getStudyCentersByEducation(value);
          developerProjects =
              await getProjectsByDigitalProfileId(digProfile!.id.toString());
          developerFrameworks =
              await getFrameworksByDigitalProfileId(digProfile!.id.toString());
          developerDatabases =
              await getDatabasesByDigitalProfileId(digProfile!.id.toString());
          developerProgrammingLanguages =
              await getProgrammingLanguagesByDigitalProfileId(
                  digProfile!.id.toString());
          developerCertificates = await getCertficationsByEducationId(value);
          if (mounted) {
            setState(() {});
          }

          getPostImages();
          WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
        });
      });
    });

    getGithubData();
  }

  Future loadData() async {
    if (mounted) {
      setState(() {
        isLoading = true;
        studyCenterIconisLoading = true;
      });
    }

    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    if (mounted) {
      await Future.wait(urlPostImages
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
            apiHasBeenCalled = true,
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

  @override
  Widget build(BuildContext context) {
    final shouldUpdateData =
        ModalRoute.of(context)?.settings.arguments as bool?;
    if (shouldUpdateData == true) {
      getEducationByDigitalProfileId(widget.developerId.toString())
          .then((value) async {
        developerStudyCenters = await getStudyCentersByEducation(value);
        developerProjects =
            await getProjectsByDigitalProfileId(widget.developerId.toString());
        developerFrameworks = await getFrameworksByDigitalProfileId(
            widget.developerId.toString());
        developerDatabases =
            await getDatabasesByDigitalProfileId(widget.developerId.toString());
        developerProgrammingLanguages =
            await getProgrammingLanguagesByDigitalProfileId(
                widget.developerId.toString());
        developerCertificates = await getCertficationsByEducationId(value);
        if (mounted) {
          setState(() {});
        }
      });
    }
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView(
            children: [
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
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return LoginPage();
                              },
                            ));
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 20),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Center(
                      child: Text(
                        "Profile",
                        style: TextStyle(
                          color: cardColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
              githubUsername == "none"
                  ? Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 10, left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                GithubCard(developerId: widget.developerId),
                          ).then((value) {
                            if (mounted && value != null && value[0] != "") {
                              setState(() {
                                githubUsername = value[0];
                                githubAvatarUrl = value[1];
                                githubUrl = value[2];
                              });
                              setGithubData();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: FlashIncorrectMessageWidget(
                                      message: 'User not found!'),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  elevation: 0.0,
                                ),
                              );
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 225, 221,
                                226), // Set the button background color
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                'https://cdn-icons-png.flaticon.com/512/25/25231.png',
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 8),
                              Text('Connect to GitHub',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 30, bottom: 10, left: 20, right: 20),
                      child: GestureDetector(
                        onTap: () {
                          print("THIS IS THE GITHUB URL: ");
                          print(githubUrl);
                          if (githubUrl != "none") launch(githubUrl);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF7176EE),
                                Color(0xFF4F93E9),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.topRight,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                child: ClipOval(
                                  child: Image.network(
                                    githubAvatarUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(githubUsername,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              Spacer(),
                              Image.network(
                                'https://cdn-icons-png.flaticon.com/512/25/25231.png',
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    githubUsername = "none";
                                    githubAvatarUrl = "none";
                                    githubUrl = "none";
                                  });
                                  setGithubData();
                                },
                                child: Icon(
                                  Icons.cleaning_services_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              )
                            ],
                          ),
                        ),
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
                    child: MyDeveloper.description != null
                        ? Text(MyDeveloper!.description!,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                color: textColor,
                                fontSize: 20,
                                fontWeight: FontWeight.normal))
                        : Text(""),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeveloperEducationPost(
                                digitalProfileId: digProfile!.id),
                          ),
                        ).then((value) async {
                          await getStudyCentersByEducation(
                                  digProfile!.id.toString())
                              .then((value) {
                            if (mounted) {
                              setState(() {
                                developerStudyCenters = value;
                              });
                            }
                          });
                        });
                      },
                      child: const Icon(
                        Icons.add_circle_outline_outlined,
                        color: textColor,
                        size: 30,
                      ),
                    )
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
                            ? skeletonAddItem(context, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DeveloperEducationPost(
                                            digitalProfileId: digProfile!.id),
                                  ),
                                );
                              })
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeveloperFrameworkRegister(
                                myDigitalProfile: digProfile!),
                          ),
                        );
                      },
                      child: Icon(
                        Icons.add_circle_outline_outlined,
                        color: textColor,
                        size: 30,
                      ),
                    )
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
                            ? skeletonAddItem(context, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DeveloperFrameworkRegister(
                                            myDigitalProfile: digProfile!),
                                  ),
                                );
                                print("Add Framework");
                              })
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeveloperDatabasePost(
                                myDigitalProfile: digProfile!),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add_circle_outline_outlined,
                        color: textColor,
                        size: 30,
                      ),
                    )
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
                            ? skeletonAddItem(context, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeveloperDatabasePost(
                                        myDigitalProfile: digProfile!),
                                  ),
                                );
                              })
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeveloperLanguajePost(
                                myDigitalProfile: digProfile!),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add_circle_outline_outlined,
                        color: textColor,
                        size: 30,
                      ),
                    )
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
                            ? skeletonAddItem(context, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeveloperLanguajePost(
                                        myDigitalProfile: digProfile!),
                                  ),
                                );
                                print("Add Programming Language");
                              })
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeveloperProjectPost(
                                myDigitalProfile: digProfile!),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add_circle_outline_outlined,
                        color: textColor,
                        size: 30,
                      ),
                    )
                  ],
                ),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200, // Adjust the height as per your requirements
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
                            ? skeletonAddItem(context, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeveloperProjectPost(
                                        myDigitalProfile: digProfile!),
                                  ),
                                );
                                print("Add Project");
                              })
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
                    const Text(
                      "Certificates & Awards",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeveloperCertificateRegister(
                              digitalProfileId: digProfile!.id,
                            ),
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add_circle_outline_outlined,
                        color: textColor,
                        size: 30,
                      ),
                    )
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
                            ? skeletonAddItem(context, () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DeveloperCertificateRegister(
                                            digitalProfileId: digProfile!.id),
                                  ),
                                );
                              })
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

  Widget skeletonAddItem(BuildContext context, Function onPressed) {
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
          ElevatedButton(
            onPressed: () {
              // Llama a la función onPressed cuando se presiona el botón
              onPressed();
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              elevation: 0,
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      "Add",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
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

  Widget buildProfileCard() {
    if (MyDeveloper == null) {
      return CircularProgressIndicator();
    }
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        alignment: Alignment
            .topRight, // Alinea el botón en la esquina superior derecha
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyDeveloper.image != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(MyDeveloper!.image!),
                      )
                    : const CircleAvatar(
                        radius: 50,
                      ),
                const SizedBox(height: 16),
                Text(
                  '${MyDeveloper!.firstName!} ${formatLastName(MyDeveloper!.lastName!)}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(height: 5),
                MyDeveloper.email != null
                    ? Text(
                        MyDeveloper!.email!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: textColor,
                        ),
                      )
                    : Text(""),
                const SizedBox(height: 8),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (_) => EditProfileView(
                      myDeveloper: MyDeveloper,
                    ),
                  ))
                      .then((value) async {
                    Map<String, dynamic> MyDeveloperUpdatE = value;
                    if (mounted && MyDeveloperUpdatE != null) {
                      setState(() {
                        MyDeveloper = Developer.fromJson(MyDeveloperUpdatE);
                      });
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: Colors.blue, // Cambia el color del icono aquí
                  ),
                ),
              ),
            ),
          ),
        ],
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
        if (mounted) {
          setState(() {
            educationId = education.id!;
          });
        }
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

  Future<Developer> getDeveloperById(String id) async {
    try {
      final developerData = await DeveloperService.getDeveloperById(id);
      if (mounted) {
        final develop = Developer.fromJson(developerData);
        return develop;
      }
    } catch (e) {
      print('Failed to fetch developer data. Error: $e');
    }

    return Developer(); // Retornar una instancia vacía de Developer en caso de error
  }

  Future getDigitalProfileByDeveloperId(String id) async {
    try {
      final digitalProfileData =
          await DeveloperService.getDigitalProfileByDeveloperId(id);
      if (mounted) {
        final digitalProfile = DigitalProfile.fromJson(digitalProfileData);
        return digitalProfile;
      }
    } catch (e) {
      print('Failed to fetch developer data. Error: $e');
    }
  }

  void setGithubData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username_${widget.developerId}', githubUsername);
    prefs.setString('avatar_url_${widget.developerId}', githubAvatarUrl);
    prefs.setString('github_url_${widget.developerId}', githubUrl);

    getGithubData();
  }

  void getGithubData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username =
        prefs.getString('username_${widget.developerId}') ?? "none";
    String avatar =
        prefs.getString('avatar_url_${widget.developerId}') ?? "none";
    String url = prefs.getString('github_url_${widget.developerId}') ?? "none";

    setState(() {
      githubUsername = username;
      githubAvatarUrl = avatar;
      githubUrl = url;
    });
    print("Github Credentials");

    print("Github Username: $githubUsername");
    print("Github Avatar: $githubAvatarUrl");
    print("Github Url: $githubUrl");
  }

  String formatLastName(String lastName) {
    List<String> parts = lastName.split(' ');
    String formattedLastName = parts.join('\n');
    return formattedLastName;
  }
}
