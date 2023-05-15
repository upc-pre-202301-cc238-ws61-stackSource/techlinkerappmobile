import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/widgets/post_item.dart';
import '../models/company_unique_post.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final companyPosts = PostItem.allCompanyPosts();

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
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
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
                        "Company",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 44,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      const Center(
                          child: Icon(Icons.maps_home_work_outlined,
                              color: textColor, size: 150)),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Profile",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 36,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                          "Is the world’s leading blockchain and cryptocurrency infrastructure provider with a financial product suite that includes the largest digital asset exchange by volume.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.normal)),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 85,
                            child: Stack(
                              children: [
                                Container(
                                  width: 37,
                                  height: 37,
                                  child: const CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                  ),
                                ),
                                Positioned(
                                  right: 25,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    child: const CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          'https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    child: const CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                          'https://images.pexels.com/photos/774095/pexels-photo-774095.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
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
                                color: textColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      )
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
                  viewportFraction: 0.8,
                  // Add more options as needed
                ),
                items: companyPosts
                    .map((item) => CompanyPost(item: item))
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
}
