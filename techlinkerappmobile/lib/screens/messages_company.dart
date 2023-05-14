import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/screens/message_company_inbox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techlinkerappmobile/widgets/message_item.dart';

import '../models/developer_unique_item.dart';

class CompanyMessage extends StatefulWidget {
  const CompanyMessage({super.key});

  @override
  State<CompanyMessage> createState() => _CompanyMessageState();
}

class _CompanyMessageState extends State<CompanyMessage> {
  bool isLoding = false;

  final urlMessagesIcons = [];

  @override
  void initState() {
    super.initState();

    getDevelopersImageUrls();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
  }

  Future loadData() async {
    setState(() => isLoding = true);

    await Future.wait(urlMessagesIcons
        .map((urlImage) => cacheImage(context, urlImage))
        .toList());

    setState(() => isLoding = false);
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
                "Company",
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
                            ? buildSkeleton(context)
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
