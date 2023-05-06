import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/screens/messages_company.dart';

import '../constants/colors.dart';
import 'home_company.dart';

class MainCompanyPage extends StatefulWidget {
  const MainCompanyPage({super.key});

  @override
  State<MainCompanyPage> createState() => _MainCompanyPageState();
}

class _MainCompanyPageState extends State<MainCompanyPage> {
  int index = 0;

  final screens = [
    CompanyHome(),
    CompanyMessage(),
    Center(child: Text("Mail3", style: TextStyle(color: Colors.blue))),
    Center(child: Text("Mail4", style: TextStyle(color: Colors.blue))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: secondaryColor,
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: Colors.white),
          ),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: NavigationBar(
          height: 90,
          backgroundColor: buttonColor,
          selectedIndex: index,
          onDestinationSelected: (index) {
            setState(() {
              this.index = index;
            });
          },
          destinations: [
            NavigationDestination(icon: Icon(Icons.home_filled), label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.messenger_outline), label: 'Messages'),
            NavigationDestination(
                icon: Icon(Icons.person_2_outlined), label: 'profile'),
            NavigationDestination(
                icon: Icon(Icons.notifications_none_outlined),
                label: 'notifications'),
          ],
        ),
      ),
    );
  }
}
