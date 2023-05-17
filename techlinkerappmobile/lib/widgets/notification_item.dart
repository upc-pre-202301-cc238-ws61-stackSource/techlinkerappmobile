import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/notification_unique_item.dart';
import 'package:techlinkerappmobile/screens/notifications_company.dart';

import '../constants/colors.dart';

class NotificationItem extends StatelessWidget {
  final NotificationUniqueItem notification;
  final String emmiterIcon;

  const NotificationItem(
      {required this.emmiterIcon, required this.notification, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: secondaryColor),
      child: ListTile(
        onTap: () => {print("Clicked")},
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(34),
          child: CachedNetworkImage(
            imageUrl: emmiterIcon,
            width: 54,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.emitter!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
            ),
            Text(
              notification.content!,
              style: const TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
        trailing: Container(
          decoration: BoxDecoration(
            color: warningColor,
            borderRadius:
                BorderRadius.circular(30), // Adjust the radius as needed
          ),
          child: IconButton(
            icon: Icon(
              Icons.delete,
              color: textColor,
            ),
            onPressed: () {
              // Handle delete button press
            },
          ),
        ),
      ),
    );
  }
}
