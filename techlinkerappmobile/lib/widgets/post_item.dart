import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/models/company_unique_post.dart';
import 'package:techlinkerappmobile/models/post.dart';
import 'package:techlinkerappmobile/services/company_service.dart';

import '../screens/applicants_developer_list.dart';
import '../screens/common/flash-correct-message-widget.dart';

class CompanyPost extends StatelessWidget {
  final bool show;
  final Post item;
  const CompanyPost({super.key, required this.show, required this.item});
  Future deletePost(String id) async {
    final response = await CompanyService.deleteCompanyPostById(id);
    print(response);
  }
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
                  scale: 0.5, fit: BoxFit.cover, image: NetworkImage(item.imageUrl!)),
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
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 8),
                            Text(item.company.address!),
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
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (show == true)
                        {
                          deletePost(item.id!.toString());
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: FlashCorrectMessageWidget(
                                  message: 'Post deleted successfully'),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                            ),
                          );
                        }
                        else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: FlashCorrectMessageWidget(
                                  message: 'Notification sent'),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                            ),
                          );
                        }
                        

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
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: show
                              ? Icon(
                                  Icons.delete_forever_outlined,
                                  size: 35,
                                  color: Colors.white,
                              )
                              : Text(
                                  'Apply',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
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
