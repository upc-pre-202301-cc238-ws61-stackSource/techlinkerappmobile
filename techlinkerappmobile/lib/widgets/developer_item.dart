import 'package:flutter/material.dart';
import '../models/developer_unique_item.dart';
import '../constants/colors.dart';

class DeveloperItem extends StatelessWidget {
  final DeveloperUniqueItem item;

  const DeveloperItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: secondaryColor),
      child: ListTile(
        onTap: () => {print("Clicked")},
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            item.image!,
            height: 64,
            width: 64,
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
            Text(
              "${item.specialityType!} Developer",
              style: const TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
            Row(
              children: [
                for (int i = 0; i < 5; i++)
                  const Icon(
                    Icons.star,
                    size: 18,
                    color: Colors.amber,
                  ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              item.yearsOfExperience!.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
            ),
            Text(
              'Years',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
