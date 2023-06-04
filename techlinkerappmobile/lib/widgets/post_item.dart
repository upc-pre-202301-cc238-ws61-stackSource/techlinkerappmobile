import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/models/company_unique_post.dart';
import 'package:techlinkerappmobile/models/post.dart';

import '../screens/applicants_developer_list.dart';

class CompanyPost extends StatelessWidget {
  final Post item;
  final String urlImage;
  const CompanyPost({super.key, required this.urlImage, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(urlImage)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title!,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: mainCardText),
                ),
                const SizedBox(height: 5),
                Text(
                  item.description!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: secondaryCardText),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.location_on),
                            SizedBox(width: 8),
                            Text('New York, NY'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundImage: NetworkImage(item.imageUrl),
                            ),
                            const SizedBox(width: 8),
                            const Text('Remote'),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ApplicantsList()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .transparent, // Set the background color to transparent
                        elevation: 0, // Remove the button's shadow
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
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Applicants',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
