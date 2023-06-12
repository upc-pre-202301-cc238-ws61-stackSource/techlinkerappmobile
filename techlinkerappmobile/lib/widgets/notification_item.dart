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
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
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
