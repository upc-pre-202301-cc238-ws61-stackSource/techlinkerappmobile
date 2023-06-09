import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../models/notification_unique_item.dart';
import '../models/user.dart';

import 'package:techlinkerappmobile/services/developer_service.dart';
import 'package:techlinkerappmobile/models/notify.dart';

import '../widgets/notification_item.dart';

class DeveloperNotifications extends StatefulWidget {
  final int UserId;
  const DeveloperNotifications({Key? key, required this.UserId})
      : super(key: key);

  @override
  State<DeveloperNotifications> createState() => _DeveloperNotificationsState();
}

class _DeveloperNotificationsState extends State<DeveloperNotifications> {
  List<Notify> developerNotifications = [];
  List<User?> emitters = [];
  bool isLoading = true;
  final urlEmittersImages = <String>[];

  bool apiCall = false;
  int numberOfNotifications = 10;

  @override
  void initState() {
    super.initState();
    getNotificationsByDeveloperId(widget.UserId.toString()).then((value) {
      if (mounted) {
        setState(() {
          apiCall = true;
          numberOfNotifications = 1;
        });
      }
    });
  }

  Future refreshNotifications() async {
    await getNotificationsByDeveloperId(widget.UserId
        .toString()); // Actualiza el ID del desarrollador según sea necesario
  }

  Future loadData() async {
    if (mounted) {
      setState(() => isLoading = true);
    }

    await Future.wait(urlEmittersImages
        .map((urlImage) => cacheImage(context, urlImage))
        .toList());

    if (mounted) {
      setState(() => isLoading = false);
    }
  }

  Future cacheImage(BuildContext context, String urlImage) async {
    if (urlImage.isNotEmpty) {
      await precacheImage(CachedNetworkImageProvider(urlImage), context);
    }
  }

  void getNotificationsImageUrls() {
    urlEmittersImages.clear();
    for (var item in developerNotifications) {
      final user = item.emitterId?.image;
      if (user != null && user.isNotEmpty) {
        urlEmittersImages.add(user);
      }
    }

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF39BCFD),
                    Color(0xFF4F93E9),
                    Color(0xFF7176EE),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: const [
                  SizedBox(height: 40),
                  Text(
                    "Developer",
                    style: TextStyle(
                      color: cardColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    "Notifications",
                    style: TextStyle(
                      color: cardColor,
                      fontSize: 41,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 25),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: RefreshIndicator(
                  onRefresh: refreshNotifications,
                  child: ListView.builder(
                    itemCount: developerNotifications.isEmpty
                        ? numberOfNotifications
                        : developerNotifications.length,
                    itemBuilder: (context, index) {
                      if (developerNotifications.isEmpty) {
                        return apiCall
                            ? const Padding(
                                padding: EdgeInsets.only(top: 100),
                                child: Center(
                                  child: Text(
                                    'You dont have notifications',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            : Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: buildSkeletonNotification(context),
                              );
                      } else {
                        final notification = developerNotifications[index];
                        return NotificationItem(
                          notification: notification,
                          emitterId: emitters[index] ?? User.empty(),
                          refreshNotifications: refreshNotifications,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget buildSkeletonNotification(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color.fromARGB(154, 255, 255, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    width: 150,
                    height: 13,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Future getNotificationsByDeveloperId(String id) async {
    try {
      final notificationsData =
          await DeveloperService.getNotificationsByDeveloperId(id);
      if (mounted) {
        setState(() {
          if (notificationsData != null) {
            developerNotifications = notificationsData
                .map<Notify>((notification) => Notify.fromJson(notification))
                .toList();
            emitters = developerNotifications
                .map<User?>((notification) => notification.emitterId)
                .toList();
            getNotificationsImageUrls();
          }
        });
      }
    } catch (e) {
      print('Failed to get notifications: $e');
    }
  }
}
