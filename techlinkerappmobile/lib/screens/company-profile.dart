import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/screens/company-create-post.dart';
import 'package:techlinkerappmobile/widgets/post_item.dart';
import '../models/company.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../models/post.dart';
import '../services/company_service.dart';
import 'company-editProfile.dart';
import 'login.dart';

class CompanyProfile extends StatefulWidget {
  final int companyId;
  const CompanyProfile({required this.companyId, super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  bool isLoading = true;
  bool usersIconisLoading = true;
  List<Post> companyPosts = [];
  Company MyCompany = Company();
  final urlUserIcons = [
    "https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/774095/pexels-photo-774095.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  ];

  @override
  void initState() {
    super.initState();
    getPostByCompanyId(widget.companyId.toString()).then((value) {
      companyPosts = value;
      setState(() {});
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        loadData();
        getCompanyById(widget.companyId.toString()).then((company) {
          MyCompany = company;
          setState(() {});
        });
      });
    });
  }

  Future loadData() async {
    if (!mounted) return; // Check if the state is mounted

    setState(() => isLoading = true);

    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return; // Check if the state is still mounted

    // await Future.wait(urlPostImages
    //     .map((urlImage) => cacheImage(context, urlImage))
    //     .toList());

    await Future.wait(
        urlUserIcons.map((urlImage) => cacheImage(context, urlImage)).toList());

    if (!mounted) return; // Check if the state is still mounted

    setState(() {
      isLoading = false;
      usersIconisLoading = false;
    });
  }

  Future cacheImage(BuildContext context, String urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage), context);

  // void getPostImages() {
  //   for (var item in companyPosts) {
  //     urlPostImages.add(item.imageUrl!);
  //   }
  // }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shouldUpdateData =
        ModalRoute.of(context)?.settings.arguments as bool?;
    if (shouldUpdateData == true) {
      getPostByCompanyId(widget.companyId.toString()).then((value) {
        companyPosts = value;
        setState(() {});
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
                child: Column(children: [
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
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(
                    height: 17,
                  ),
                  Center(
                      child: isLoading
                          ? Shimmer.fromColors(
                              baseColor: Color.fromARGB(255, 219, 221, 225)!,
                              highlightColor: Colors.grey[200]!,
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
                    Text(MyCompany.description!,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                            color: secondaryTextInBackground,
                            fontSize: 19,
                            fontWeight: FontWeight.normal)),
                    const SizedBox(
                      height: 30,
                    ),
                    usersIconisLoading && isLoading
                        ? Shimmer.fromColors(
                            baseColor: Color.fromARGB(255, 219, 221, 225)!,
                            highlightColor: Colors.grey[200]!,
                            child: buildSkeletonUserIcon(context),
                          )
                        : buildDeveloperIcons(),
                  ],
                ),
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
                            baseColor: Color.fromARGB(255, 219, 221, 225)!,
                            highlightColor: Colors.grey[200]!,
                            child: skeletonPostItem(context),
                          )
                        : CompanyPost(developerId: -1, show: true, item: item))
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
      margin: const EdgeInsets.only(bottom: 10, top: 10),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: loadingColor),
      height: 30,
    );
  }

  Widget buildProfileCard() {
    if (MyCompany == null) {
      return CircularProgressIndicator(); // Muestra un indicador de carga mientras se cargan los datos
    }
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          Container(
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
                  backgroundImage: NetworkImage(MyCompany!.image!),
                ),
                const SizedBox(height: 16),
                Text(
                  '${MyCompany!.firstName!} ${MyCompany!.lastName!}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(height: 5),
                Text(
                  MyCompany!.email!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                ),
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
                                myCompany: MyCompany,
                              )))
                      .then((value) async {
                    Map<String, dynamic> MyCompanyUpdatE = value;
                    if (mounted) {
                      setState(() {
                        MyCompany = Company.fromJson(MyCompanyUpdatE);
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
        SizedBox(width: 10),
        const Text(
          "+50 Developers",
          style: TextStyle(
              color: mainTextInBackground,
              fontSize: 17,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          width: 20,
        ),
        MaterialButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => CompanyCreatePost(
                      companyId: widget.companyId.toString(),
                    )));
          },
          color: secondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Create post",
            style: TextStyle(
              fontSize: 15,
              color: buttonTextColor,
            ),
          ),
        ),
      ],
    );
  }

  //get posts by company id
  Future<List<Post>> getPostByCompanyId(String id) async {
    try {
      final postsData = await CompanyService.getPostsByCompanyId(id);
      if (mounted) {
        final posts =
            postsData.map<Post>((post) => Post.fromJson(post)).toList();
        companyPosts = posts;
        return posts;
      }
    } catch (e) {
      print('Failed to fetch posts data. Error: $e');
    }

    return [];
  }

  Future<Company> getCompanyById(String id) async {
    try {
      final companyData = await CompanyService.getCompanyById(id);
      if (mounted) {
        final company = Company.fromJson(companyData);
        print(company);
        return company;
      }
    } catch (e) {
      print('Failed to fetch company data. Error: $e');
    }

    return Company(); // Retornar una instancia vacía de Company en caso de error
  }
}
