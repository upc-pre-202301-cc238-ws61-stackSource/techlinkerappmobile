import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/notification_item.dart';
import '../constants/colors.dart';
import '../models/notify.dart';
import '../models/user.dart';
import '../services/company_service.dart';

class CompanyNotifications extends StatefulWidget {
  final int UserId;

  const CompanyNotifications({super.key, required this.UserId});

  @override
  State<CompanyNotifications> createState() => _CompanyNotificationsState();
}

class _CompanyNotificationsState extends State<CompanyNotifications> {
  List<Notify> companyNotifications = [];
  List<User?> emitters = [];
  bool isLoading = true;

  final urlEmittersImages = [];

  @override
  void initState() {
    super.initState();
    getNotificationsByCompanyId(widget.UserId.toString());
  }

  Future refreshNotifications() async {
    await getNotificationsByCompanyId(widget.UserId.toString()); // Actualiza el ID del desarrollador según sea necesario
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
    for (var item in companyNotifications) {
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
            child: Column(children: const [
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Company",
                  style: TextStyle(
                      color: cardColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "Notifications",
                  style: TextStyle(
                      color: cardColor,
                      fontSize: 41,
                      fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 25,)
              ]
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: RefreshIndicator(
                onRefresh: refreshNotifications,
                child: ListView.builder(
                  itemCount: companyNotifications.length,
                  itemBuilder: (context, index) {
                    final notification = companyNotifications[index];

                    return isLoading
                        ? Shimmer.fromColors(
                      baseColor: Color.fromARGB(255, 219, 221, 225)!,
                      highlightColor: Colors.grey[200]!,
                      child: buildSkeletonNotification(context),
                    )
                        : NotificationItem(
                      notification: notification,
                      emitterId: emitters[index] ?? User.empty(),
                      refreshNotifications: refreshNotifications,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      )),
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
            //create a circle for simulating the image of avatar
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
  Future getNotificationsByCompanyId(String id) async {
    try {
      final notificationsData = await CompanyService.getNotificationsByCompanyId(id);
      if (mounted) {
        setState(() {
          if (notificationsData != null) {
            companyNotifications = notificationsData
                .map<Notify>((notification) => Notify.fromJson(notification))
                .toList();
            emitters = companyNotifications
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
