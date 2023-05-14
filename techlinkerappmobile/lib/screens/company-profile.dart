import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/widgets/post_item.dart';
import '../models/company_unique_post.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final companyPosts = PostItem.allCompanyPosts();

    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: ListView(
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
                  Center(
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
                  SizedBox(
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
                              child: CircleAvatar(
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
                                child: CircleAvatar(
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
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage(
                                      'https://images.pexels.com/photos/774095/pexels-photo-774095.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "+50 Developers in charge",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w800),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  for (int i = 0; i < companyPosts.length; i++)
                    CompanyPost(item: companyPosts[i]),
                  SizedBox(
                    height: 25,
                  ),
                ],
              )),
            ],
          )),
    );
  }
}
