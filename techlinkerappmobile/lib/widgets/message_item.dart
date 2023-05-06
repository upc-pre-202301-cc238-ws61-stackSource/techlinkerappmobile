import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/developer_unique_item.dart';

class MessageItem extends StatelessWidget {
  final DeveloperUniqueItem item;
  final Function onPressed;
  const MessageItem({super.key, required this.item, required this.onPressed});

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
          child: Image.network(
            item.image!,
            height: 64,
            width: 56,
            fit: BoxFit.cover,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.name!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
            ),
            SizedBox(height: 5),
            Text(
              "${item.name!} Developer",
              style: const TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Date',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            CircleAvatar(
              backgroundColor: warningColor,
              radius: 12,
              child: Text('2', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
