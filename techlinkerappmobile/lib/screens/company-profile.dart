import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/widgets/post_item.dart';
import '../models/company_unique_post.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(children: [
                  const SizedBox(
                    height: 60,
                  ),
                  const Center(
                    child: Text(
                      "Profile",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
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
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                          "Is the world’s leading blockchain and cryptocurrency infrastructure provider with a financial product suite that includes the largest digital asset exchange by volume.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.normal)),
                      const SizedBox(
                        height: 30,
                      ),
                      usersIconisLoading && isLoading
                          ? Shimmer.fromColors(
                              baseColor: secondaryColor!,
                              highlightColor: loadingColor,
                              child: buildSkeletonUserIcon(context),
                            )
                          : buildDeveloperIcons(),
                    ]),
              ),
              const SizedBox(
                height: 25,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  height: 335, // Adjust the height as per your requirements
                  enableInfiniteScroll: true, // Enable infinite scrolling
                  autoPlay: true, // Enable automatic sliding
                  viewportFraction: 0.9,

                  // Add more options as needed
                ),
                items: companyPosts
                    .map((item) => isLoading && usersIconisLoading
                        ? Shimmer.fromColors(
                            baseColor: secondaryColor!,
                            highlightColor: loadingColor,
                            child: skeletonPostItem(context),
                          )
                        : CompanyPost(
                            item: item,
                            urlImage: urlPostImages[int.parse(item.id!) - 1]))
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
            Text(
              'Company Name',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
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

  Widget buildDeveloperIcons() {
    return Row(
      children: [
        Container(
          width: 85,
          child: Stack(
            children: [
              Container(
                width: 37,
                height: 37,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(urlUserIcons[0]),
                ),
              ),
              Positioned(
                right: 25,
                child: Container(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(urlUserIcons[1]),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  width: 35,
                  height: 35,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(urlUserIcons[2]),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const Text(
          "+50 Developers in charge",
          style: TextStyle(
              color: textColor, fontSize: 17, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
