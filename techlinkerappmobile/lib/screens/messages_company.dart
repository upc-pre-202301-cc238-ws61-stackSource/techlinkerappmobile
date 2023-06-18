import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/models/company.dart';
import 'package:techlinkerappmobile/models/developer_x_message.dart';
import 'package:techlinkerappmobile/screens/message_company_inbox.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:techlinkerappmobile/widgets/message_item.dart';

import '../models/developer.dart';
import '../models/developer_unique_item.dart';
import '../models/message.dart';
import '../services/company_service.dart';
import '../services/developer_service.dart';

class CompanyMessage extends StatefulWidget {
  final int companyId;
  const CompanyMessage({required this.companyId, super.key});

  @override
  State<CompanyMessage> createState() => _CompanyMessageState();
}

class _CompanyMessageState extends State<CompanyMessage> {
  bool isLoding = true;

  final urlMessagesIcons = [];
  List<DeveloperMessage> developerContacts = <DeveloperMessage>[];

  @override
  void initState() {
    super.initState();

    getDevelopersImageUrls();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
    getMessagesByCompanyId(widget.companyId.toString());
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
      body: Column(
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
                "Messages",
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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: developerContacts.length,
                itemBuilder: (context, index) {
                  final developer = developerContacts[index];

                  return isLoding
                      ? Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 219, 221, 225)!,
                          highlightColor: Colors.grey[200]!,
                          child: buildSkeleton(context))
                      : MessageItem(
                          item: developer,
                          onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CompanyMessageInbox(
                                        companyId: widget.companyId,
                                        item: developer),
                                  ),
                                ).then((value) {
                                  if (mounted) {
                                    setState(() {
                                      getMessagesByCompanyId(
                                          widget.companyId.toString());
                                    });
                                  }
                                }),
                              },
                          urlImage: developer.developer.image!);
                },
              ),
            ),
          ),
        ],
      ),
    );
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

  Future<Developer> getDeveloperById(String id) async {
    try {
      final developerData = await DeveloperService.getDeveloperById(id);
      if (developerData != null) {
        final developer = Developer.fromJson(developerData);
        return developer;
      }
    } catch (e) {
      print('Failed to fetch developer data. Error: $e');
    }

    return Developer.empty();
  }

  Future getMessagesByCompanyId(String id) async {
    List<Message> messages = <Message>[];
    List<Developer> myDevContacts = <Developer>[];

    try {
      final messagesData = await CompanyService.getLastMessagesByCompanyId(id);
      if (mounted) {
        messages.addAll(messagesData
            .map<Message>((message) => Message.fromJson(message))
            .toList());
      }
    } catch (e) {
      print('Failed to fetch messages data. Error: $e');
    }

    //print all messages
    for (var message in messages) {
      myDevContacts.add(await getDeveloperById(message.receiverId.toString()));
    }

    developerContacts.clear();

    //add developers from myDevContacts  and Nessage from  messages to developerContacts, before adding make sure that developer id is similar to message receiver id
    for (var developer in myDevContacts) {
      for (var message in messages) {
        if (developer.id == message.receiverId) {
          developerContacts
              .add(DeveloperMessage(developer: developer, message: message));
        }
      }
    }

    if (mounted) {
      setState(() {});
    }
  }
}
