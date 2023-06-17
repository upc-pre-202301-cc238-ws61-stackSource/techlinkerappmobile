import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/screens/developer-profile.dart';
import '../models/developer.dart';
import '../models/developer_unique_item.dart';
import '../constants/colors.dart';
import '../screens/contact_developer.dart';
import '../services/developer_service.dart';

class DeveloperItem extends StatelessWidget {
  final Developer item;
  final String urlImage;
  final int companyId;
  const DeveloperItem(
      {super.key,
      required this.item,
      required this.urlImage,
      required this.companyId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await getDeveloperById(item.id.toString()).then((value) => {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDeveloper(
                    developer: value,
                    companyId: companyId,
                  ),
                ),
              ),
            }); // navigateToDeveloperProfile(context)
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10, right: 1, left: 1),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 1, // Spread radius
              blurRadius: 2, // Blur radius
              offset: Offset(0, 0.5), // Offset in the y direction
            ),
          ],
        ),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              imageUrl: urlImage,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.firstName!} ${item.lastName!}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: mainCardText,
                ),
              ),
              Text(
                item.description!,
                style: const TextStyle(
                  color: secondaryCardText,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 5; i++)
                    const Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.amber,
                    ),
                ],
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.id!.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: mainCardText,
                ),
              ),
              const Text(
                'Years',
                style: TextStyle(
                  color: mainCardText,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToDeveloperProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DeveloperProfile(
          developerId: 1,
        ),
      ),
    );
  }

  Future<Developer> getDeveloperById(String id) async {
    try {
      final developerData = await DeveloperService.getDeveloperById(id);
      if (developerData != null) {
        final developer = Developer.fromJson(developerData);
        print("This is the developer $developerData");
        return developer;
      }
    } catch (e) {
      print('Failed to fetch developer data. Error: $e');
    }

    return Developer.empty();
  }
}
