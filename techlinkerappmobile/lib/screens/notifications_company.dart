import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/models/notification_unique_item.dart';
import 'package:techlinkerappmobile/widgets/notification_item.dart';

import '../constants/colors.dart';
import '../models/notify.dart';
import '../models/user.dart';
import '../services/company_service.dart';

class CompanyNotifications extends StatefulWidget {
  const CompanyNotifications({super.key});

  @override
  State<CompanyNotifications> createState() => _CompanyNotificationsState();
}

class _CompanyNotificationsState extends State<CompanyNotifications> {
  List<Notify> companyNotifications = <Notify>[];
  User? emitterId;


  bool isLoding = true;

  final urlEmittersImages = [];

  @override
  void initState() async {
    super.initState();
    await getNotificationsByCompanyId('1');
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
      urlEmittersImages.add(item.emitterId!.image);
    }
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
              SizedBox(
                height: 25,
              )
            ]),
          ),
          const SizedBox(height: 20),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ListView.builder(
                itemCount: companyNotifications.length,
                itemBuilder: (context, index) {
                  final notification = companyNotifications[index];

                  return isLoding
                      ? Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 219, 221, 225)!,
                          highlightColor: Colors.grey[200]!,
                          child: buildSkeletonNotification(context))
                      : NotificationItem(
                          notification: notification,
                          emitterId: urlEmittersImages[index],
                        );
                }),
          )),
          const SizedBox(height: 10),
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
  Future<void> getNotificationsByCompanyId(String id) async {
    try {
      final notificationsData = await CompanyService.getNotificationsByCompanyId(id);
      if (mounted) {
        setState(() {
          companyNotifications = notificationsData
              .map<Notify>((notification) => Notify.fromJson(notification))
              .toList();
        });
      }
    } catch (e) {
      print('Failed to get notifications: $e');
    }
  }
}
