import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/models/post.dart';
import 'package:techlinkerappmobile/services/company_service.dart';
import '../models/company_unique_post.dart';
import '../widgets/job_offer_item.dart';
import '../widgets/post_item.dart';
import '../constants/colors.dart';

class DeveloperHome extends StatefulWidget {
  final int developerId;
  const DeveloperHome({super.key, required this.developerId});

  @override
  State<DeveloperHome> createState() => _DeveloperHomeState();
}

class _DeveloperHomeState extends State<DeveloperHome> {
  final urlPostImages = [];

  bool isLoading = true;

  List<Post> companyPosts = [];

  @override
  void initState() {
    super.initState();

    //create delay to show shimmer 2 seconds
    getAllCompanyPosts().then((value) {
      companyPosts = value;
      getPostImages();
      WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
      if (mounted) {
        setState(() {});
      }
    });
  }

  Future loadData() async {
    if (!mounted) return; // Check if the state is mounted

    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return; // Check if the state is still mounted

    await Future.wait(urlPostImages
        .map((urlImage) => cacheImage(context, urlImage))
        .toList());

    if (!mounted) return; // Check if the state is still mounted

    setState(() {
      isLoading = false;
    });
  }

  Future cacheImage(BuildContext context, String urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage), context);

  void getPostImages() {
    for (var item in companyPosts) {
      urlPostImages.add(item.imageUrl!);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  "Job",
                  style: TextStyle(
                      color: cardColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "Offers",
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                  itemCount: companyPosts.isEmpty ? 3 : companyPosts.length,
                  itemBuilder: (context, index) => Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: companyPosts.isEmpty
                        ? Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 219, 221, 225)!,
                            highlightColor: Colors.grey[200]!,
                            child: skeletonPostItem(context),
                          )
                        : CompanyPost(
                            developerId: widget.developerId,
                            show: false,
                            item: companyPosts[index]),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }

  Widget skeletonPostItem(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(154, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 320,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
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
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  //get all company posts
  Future<List<Post>> getAllCompanyPosts() async {
    try {
      final companyPostsData = await CompanyService.getAllPosts();
      if (mounted) {
        final companyPosts = companyPostsData
            .map<Post>((companyPost) => Post.fromJson(companyPost))
            .toList();
        return companyPosts;
      }
    } catch (e) {
      print('Failed to fetch company posts data. Error: $e');
    }

    return [];
  }
}
