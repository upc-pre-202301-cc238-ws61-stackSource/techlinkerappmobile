import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class NotificationItem extends StatefulWidget {
  final Notification notification;
  //
  final String emmiterIcon;

  NotificationItem(
      {required this.emmiterIcon,  required this.notification, super.key});

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {

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
            imageUrl: widget.emmiterIcon,
            width: 54,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.notification.emitter!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
            ),
            Text(
              widget.notification.content!,
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
