import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/models/company_unique_post.dart';

class CompanyPost extends StatelessWidget {
  final PostItem item;
  const CompanyPost({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: const NetworkImage(
                  "https://static.vecteezy.com/system/resources/previews/002/223/229/large_2x/abstract-technology-hi-tech-background-banner-template-with-copy-space-vector.jpg",
                ),
              ),
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
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item.description!,
                  textAlign: TextAlign.justify,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  ),
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
                              backgroundImage:
                                  NetworkImage(item.companyProfileImage!),
                            ),
                            const SizedBox(width: 8),
                            const Text('Remote'),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: buttonColor),
                      onPressed: () {},
                      child: const Text('Apply'),
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
