import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constants/colors.dart';
import '../models/developer_unique_item.dart';
import '../widgets/message_item.dart';
import 'message_company_inbox.dart';

class DeveloperMessages extends StatefulWidget {
  const DeveloperMessages({super.key});

  @override
  State<DeveloperMessages> createState() => _DeveloperMessagesState();
}

class _DeveloperMessagesState extends State<DeveloperMessages> {
  bool isLoding = true;

  final urlMessagesIcons = [];

  @override
  void initState() {
    super.initState();

    getDevelopersImageUrls();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
  }

  Future loadData() async {
    if (mounted) {
      setState(() => isLoding = true);
    }

    await Future.wait(urlMessagesIcons
        .map((urlImage) => cacheImage(context, urlImage))
        .toList());

    if (mounted) {
      setState(() => isLoding = false);
    }
  }

  Future cacheImage(BuildContext context, String urlImage) =>
      precacheImage(CachedNetworkImageProvider(urlImage), context);

  void getDevelopersImageUrls() {
    for (var item in DeveloperUniqueItem.developerItems()) {
      urlMessagesIcons.add(item.image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 34,
              ),
              const Text(
                "Developer",
                style: TextStyle(
                    color: textColor,
                    fontSize: 44,
                    fontWeight: FontWeight.w800),
              ),
              const Text(
                "Messages",
                style: TextStyle(
                    color: textColor,
                    fontSize: 44,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 17,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: DeveloperUniqueItem.developerItems().length,
                      itemBuilder: (context, index) {
                        final developer =
                            DeveloperUniqueItem.developerItems()[index];

                        return isLoding
                            ? Shimmer.fromColors(
                                baseColor: secondaryColor,
                                highlightColor: loadingColor,
                                child: buildSkeleton(context))
                            : MessageItem(
                                item: developer,
                                onPressed: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CompanyMessageInbox(
                                                      item: developer)))
                                    },
                                urlImage: urlMessagesIcons[index]);
                      }))
            ],
          ),
        ));
  }

  Widget buildSkeleton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: secondaryColor, radius: 35),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: secondaryColor,
                width: MediaQuery.of(context).size.width * 0.6,
                height: 25,
              ),
              SizedBox(height: 5),
              Container(
                color: secondaryColor,
                width: MediaQuery.of(context).size.width * 0.3,
                height: 15,
              )
            ],
          )
        ],
      ),
    );
  }
}
