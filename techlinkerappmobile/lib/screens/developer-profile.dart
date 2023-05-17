import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import '../models/company_unique_post.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 34,
              ),
              const Text(
                "Profile",
                style: TextStyle(
                    color: textColor,
                    fontSize: 44,
                    fontWeight: FontWeight.w800),
              ),
              const Text(
                "Developer",
                style: TextStyle(
                    color: textColor,
                    fontSize: 44,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 17,
              ),
              Expanded(
                  child: ListView(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),

                        child: Column(children: [
                          Center(
                              child: isLoading
                                  ? Shimmer.fromColors(
                                baseColor: secondaryColor!,
                                highlightColor: loadingColor,
                                child: buildSkeletonCard(context),
                              )
                                  : buildProfileCard()),
                          const SizedBox(
                            height: 30,
                          ),
                        ]),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),

                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),

                              const Text(
                                  "Education",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)
                              ),
                              const SizedBox(
                                height: 30,
                              ),

                              const Text(
                                  "Tools / Skills",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                  "Latest projects",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                  "Certificates & Awards",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                  "Experience in companies",
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ]
                        ),
                      ),
                      const SizedBox(
                        height: 25,
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
      color: buttonColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(urlUserIcons[0]),
            ),
            const SizedBox(height: 16),
            Text(
              'Developer Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Software Engineer',
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Specialist in software development',
              style: TextStyle(
                fontSize: 16,
                color: textColor,
              ),
            ),
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
