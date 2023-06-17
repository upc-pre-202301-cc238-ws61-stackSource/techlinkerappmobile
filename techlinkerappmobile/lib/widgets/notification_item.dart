import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/screens/common/flash-correct-message-widget.dart';

import '../constants/colors.dart';
import '../models/notify.dart';
import '../models/user.dart';
import '../services/developer_service.dart';

class NotificationItem extends StatefulWidget {
  final Notify notification;
  final User emitterId;
  final VoidCallback refreshNotifications;
  //

  NotificationItem({
    required this.emitterId,
    required this.notification,
    required this.refreshNotifications,
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {

  Future deleteNotificationByDeveloperId(String id, String notificationId) async {
    try {
      await DeveloperService.deleteNotificationIdByDeveloperIdOrCompanyId(id, notificationId);
      widget.refreshNotifications();
    } catch (e) {
      print('Failed to delete notification: $e');
    }
  }

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
            imageUrl: widget.emitterId.image ?? '',
            width: 54,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.emitterId.firstName} ${widget.emitterId.lastName}' ?? '',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
            ),
            Text(
              widget.notification.content ?? '',
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
              deleteNotificationByDeveloperId(widget.notification.reciverId.toString(), widget.notification.id.toString());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: FlashCorrectMessageWidget(message: 'Notification deleted successfully'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
              );
              // Handle delete button press
            },
          ),
        ),
      ),
    );
  }
}
