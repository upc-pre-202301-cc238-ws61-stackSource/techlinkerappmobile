import 'package:flutter/material.dart';

import '../constants/colors.dart';

class SelectUserRegyster extends StatelessWidget {
  const SelectUserRegyster({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  "Reygister",
                  style: TextStyle(
                      color: cardColor,
                      fontSize: 40,
                      fontWeight: FontWeight.w800),
                ),
                Text(
                  "as a",
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
            const SizedBox(height: 15),
            ],
          ),
      ),
    );
  }
}