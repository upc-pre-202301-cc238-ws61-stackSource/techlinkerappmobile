import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../models/notification_unique_item.dart';
import '../widgets/notification_item.dart';

class DeveloperNotifications extends StatefulWidget {
  const DeveloperNotifications({super.key});

  @override
  State<DeveloperNotifications> createState() => _DeveloperNotificationsState();
}

class _DeveloperNotificationsState extends State<DeveloperNotifications> {
  List<NotificationUniqueItem> companyNotifications =
      NotificationUniqueItem.notificationItems();

  bool isLoding = true;

  final urlEmittersImages = [];

  @override
  void initState() {
    super.initState();

    getNotificationsImageUrls();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
  }

  Future loadData() async {
    if (mounted) {
      setState(() => isLoding = true);
    }

    await Future.wait(urlEmittersImages
        .map((urlImage) => cacheImage(context, urlImage))
        .toList());

    if (mounted) {
      setState(() => isLoding = false);
    }
  }

  Future cacheImage(BuildContext context, String urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage), context);

  void getNotificationsImageUrls() {
    for (var item in companyNotifications) {
      urlEmittersImages.add(item.emitterIcon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Notifications",
                style: TextStyle(
                    color: textColor,
                    fontSize: 44,
                    fontWeight: FontWeight.w800),
              ),
              const Text(
                "Developer",
                style: TextStyle(
                    color: textColor,
                    fontSize: 44,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: companyNotifications.length,
                      itemBuilder: (context, index) {
                        final notification = companyNotifications[index];

                        return isLoding
                            ? Shimmer.fromColors(
                                baseColor: secondaryColor,
                                highlightColor: loadingColor,
                                child: buildSkeletonNotification(context))
                            : NotificationItem(
                                notification: notification,
                                emmiterIcon: urlEmittersImages[index],
                              );
                      }))
            ],
          )),
    );
  }

  Widget buildSkeletonNotification(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: loadingColor),
      height: 80,
    );
  }
}
