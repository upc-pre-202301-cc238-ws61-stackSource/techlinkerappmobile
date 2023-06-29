import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/company_x_message.dart';
import 'package:techlinkerappmobile/models/developer_x_message.dart';

import '../constants/colors.dart';
import '../models/developer_unique_item.dart';

class MessageItemCompany extends StatelessWidget {
  final CompanyMessage item;
  final String urlImage;
  final Function onPressed;
  const MessageItemCompany(
      {super.key,
      required this.item,
      required this.onPressed,
      required this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: primaryColor),
      child: ListTile(
        onTap: () => {print("Clicked"), onPressed()},
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            imageUrl: urlImage,
            width: 55,
            height: 64,
            fit: BoxFit.cover,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item.company.firstName} ${item.company.lastName!}',
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
            ),
            SizedBox(height: 5),
            Text(
              item.message.message.length < 22
                  ? "${item.message.message}"
                  : "${item.message.message.substring(0, 22)}...",
              style: const TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Today',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            CircleAvatar(
              backgroundColor: warningColor,
              radius: 12,
              child: Text('1', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
