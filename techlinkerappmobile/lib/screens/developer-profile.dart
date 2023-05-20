import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/models/developer_framework_item.dart';
import 'package:techlinkerappmobile/widgets/developer_framework.dart';
import '../models/company_unique_post.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../widgets/job_offer_item.dart';

class DeveloperProfile extends StatefulWidget {
  const DeveloperProfile({super.key});

  @override
  State<DeveloperProfile> createState() => _DeveloperProfileState();
}

class _DeveloperProfileState extends State<DeveloperProfile> {
  final urlPostImages = [];
  bool isLoading = true;
  bool usersIconisLoading = true;
  final companyPosts = PostItem.allCompanyPosts();
  final developerFrameworks =
      DeveloperFrameworkItem.listOfDeveloperFrameworks();

  final urlUserIcons = [
    "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/774095/pexels-photo-774095.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  ];

  @override
  void initState() {
    super.initState();

    //create delay to show shimmer 2 seconds

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
                    const SizedBox(height: 60),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                        "This is a developer profile decription, here you can see the developer's skills, education, experience, projects and certificates.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.normal)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ]),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Education",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 375, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  autoPlay: true, // Enable automatic sliding
                  viewportFraction: 1,

                  // Add more options as needed
                ),
                items: companyPosts
                    .map((item) => isLoading && usersIconisLoading
                        ? Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 219, 221, 225)!,
                            highlightColor: Colors.grey[200]!,
                            child: skeletonPostItem(context),
                          )
                        : CompanyPost(item: item))
                    .toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Tools / Skills",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  // Enable automatic sliding
                  viewportFraction: 0.6,

                  // Add more options as needed
                ),
                items: developerFrameworks
                    .map((item) => isLoading && usersIconisLoading
                        ? Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 219, 221, 225)!,
                            highlightColor: Colors.grey[200]!,
                            child: skeletonPostItem(context),
                          )
                        : DeveloperFramework(
                            framework: item, frameworkIcon: item.iconLink!))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text("Latest projects",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 375, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  autoPlay: true, // Enable automatic sliding
                  viewportFraction: 1,

                  // Add more options as needed
                ),
                items: companyPosts
                    .map((item) => isLoading && usersIconisLoading
                        ? Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 219, 221, 225)!,
                            highlightColor: Colors.grey[200]!,
                            child: skeletonPostItem(context),
                          )
                        : CompanyPost(item: item))
                    .toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text("Certificates & Awards",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 200, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  // Enable automatic sliding
                  viewportFraction: 0.6,

                  // Add more options as needed
                ),
                items: developerFrameworks
                    .map((item) => isLoading && usersIconisLoading
                        ? Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 219, 221, 225)!,
                            highlightColor: Colors.grey[200]!,
                            child: skeletonPostItem(context),
                          )
                        : DeveloperFramework(
                            framework: item, frameworkIcon: item.iconLink!))
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
        margin: EdgeInsets.symmetric(horizontal: 50),
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
              backgroundImage: NetworkImage(urlUserIcons[0]),
            ),
            const SizedBox(height: 16),
            const Text(
              'Company Name',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 5),
            const Text(
              'john.doe@example.com',
              style: TextStyle(
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
}
