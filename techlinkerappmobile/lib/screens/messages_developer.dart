import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:techlinkerappmobile/models/company.dart';
import 'package:techlinkerappmobile/models/company_x_message.dart';
import 'package:techlinkerappmobile/models/message_company.dart';
import 'package:techlinkerappmobile/services/company_service.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import 'package:techlinkerappmobile/widgets/message_item_company.dart';

import '../constants/colors.dart';
import '../models/developer.dart';
import '../models/developer_unique_item.dart';
import '../models/developer_x_message.dart';
import '../models/message.dart';
import '../widgets/message_item.dart';
import 'message_company_inbox.dart';
import 'message_developer_inbox .dart';

class DeveloperMessages extends StatefulWidget {
  final int developerId;
  const DeveloperMessages({super.key, required this.developerId});

  @override
  State<DeveloperMessages> createState() => _DeveloperMessagesState();
}

class _DeveloperMessagesState extends State<DeveloperMessages> {
  bool isLoding = true;

  final urlMessagesIcons = [];
  List<CompanyMessage> companyContacts = <CompanyMessage>[];

  @override
  void initState() {
    super.initState();

    getDevelopersImageUrls();
    WidgetsBinding.instance!.addPostFrameCallback((_) => loadData());
    getMessagesByDeveloperId(widget.developerId.toString());
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
                "Developer",
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
                itemCount: companyContacts.length,
                itemBuilder: (context, index) {
                  final company = companyContacts[index];

                  return isLoding
                      ? Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 219, 221, 225)!,
                          highlightColor: Colors.grey[200]!,
                          child: buildSkeleton(context))
                      : MessageItemCompany(
                          item: company,
                          onPressed: () => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeveloperMessageInbox(
                                        developerId: widget.developerId!,
                                        item: company),
                                  ),
                                ).then((value) {
                                  if (mounted) {
                                    setState(() {
                                      getMessagesByDeveloperId(
                                          widget.developerId.toString());
                                    });
                                  }
                                }),
                              },
                          urlImage: company.company.image!);
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

  Future<Company> getCompanyById(String id) async {
    Company company = Company();

    try {
      final companyData = await CompanyService.getCompanyById(id);
      if (mounted) {
        company = Company.fromJson(companyData);
      }
    } catch (e) {
      print('Failed to fetch company data. Error: $e');
    }

    return company;
  }

  Future getMessagesByDeveloperId(String id) async {
    List<MessageCompany> messages = <MessageCompany>[];
    List<Company> myCompanyContacts = <Company>[];

    try {
      final messagesData =
          await DeveloperService.getLastMessagesByDeveloperId(id);
      if (mounted) {
        messages.addAll(messagesData
            .map<MessageCompany>((message) => MessageCompany.fromJson(message))
            .toList());
      }
    } catch (e) {
      print('Failed to fetch messages data. Error: $e');
    }

    //print all messages
    for (var message in messages) {
      myCompanyContacts
          .add(await getCompanyById(message.receiverId.toString()));
    }

    companyContacts.clear();

    //add developers from myDevContacts  and Nessage from  messages to developerContacts, before adding make sure that developer id is similar to message receiver id
    for (var company in myCompanyContacts) {
      for (var message in messages) {
        if (company.id == message.receiverId) {
          companyContacts
              .add(CompanyMessage(company: company, message: message));
        }
      }
    }

    if (mounted) {
      setState(() {});
    }
  }
}
