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
  bool isNotificationVisible = true;

  Future<void> deleteNotification(String id, String notificationId) async {
    try {
      await DeveloperService.deleteNotificationIdByDeveloperIdOrCompanyId(id, notificationId);
      widget.refreshNotifications();
      setState(() {
        isNotificationVisible = false;
      });
    } catch (e) {
      print('Failed to delete notification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isNotificationVisible) {
      return Container(); // Return an empty container if the notification is not visible
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10, top: 10, right: 1, left: 1),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 0.5),
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
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor,
              ),
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
            borderRadius: BorderRadius.circular(30),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              deleteNotification(
                widget.notification.reciverId.toString(),
                widget.notification.id.toString(),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: FlashCorrectMessageWidget(
                    message: 'Notification deleted successfully',
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
