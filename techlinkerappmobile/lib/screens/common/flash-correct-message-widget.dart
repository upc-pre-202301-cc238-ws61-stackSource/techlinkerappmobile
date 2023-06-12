import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class FlashCorrectMessageWidget extends StatelessWidget {
  final String message;
  const FlashCorrectMessageWidget({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          height: 90,
          decoration: const BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Row(
            children: [
            const SizedBox(width: 48.0),
            Expanded(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              const Text(
                'Good job!',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                message,
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 18.0
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              ],
            ),
          ),
        ],
        )
        ),
        Positioned(
          top: -15,
          left: 0,
          child: Stack(
            alignment: Alignment.center,
            children: const [
              CircleAvatar(
              backgroundColor: buttonColor,
              radius: 15.0,
            ),
        Icon(
          Icons.check,
          color: primaryColor,
          size: 18.0,
          ),
          ]
          ),
          ),
        ],
    );
  }
}