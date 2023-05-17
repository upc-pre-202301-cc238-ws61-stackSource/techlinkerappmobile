import 'package:flutter/material.dart';
import '../models/company_unique_post.dart';
import '../widgets/job_offer_item.dart';
import '../constants/colors.dart';

class DeveloperHome extends StatelessWidget {
  const DeveloperHome({super.key});

  @override
  Widget build(BuildContext context) {
    final companyPosts = PostItem.allCompanyPosts();
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 34,
            ),
            const Text(
              "Job",
              style: TextStyle(
                  color: textColor,
                  fontSize: 44,
                  fontWeight: FontWeight.w800),
            ),
            const Text(
              "Offers",
              style: TextStyle(
                  color: textColor,
                  fontSize: 44,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 17,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: companyPosts.length,
                itemBuilder: (context, index) => CompanyPost(
                  item: companyPosts[index],
                ),
              ),
            ),

          ]),
        ));
  }
}

