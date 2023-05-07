import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/screens/message_company_inbox.dart';
import 'package:techlinkerappmobile/widgets/message_item.dart';

import '../models/developer_unique_item.dart';

class CompanyMessage extends StatefulWidget {
  const CompanyMessage({super.key});

  @override
  State<CompanyMessage> createState() => _CompanyMessageState();
}

class _CompanyMessageState extends State<CompanyMessage> {
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
                  child: ListView(
                children: [
                  for (var item in DeveloperUniqueItem.developerItems())
                    MessageItem(
                        item: item,
                        onPressed: () => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CompanyMessageInbox(item: item)))
                            }),
                ],
              ))
            ],
          ),
        ));
  }
}
