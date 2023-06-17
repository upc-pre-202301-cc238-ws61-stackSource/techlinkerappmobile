import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/developer.dart';
import 'package:techlinkerappmobile/screens/developer-profile.dart';
import 'package:techlinkerappmobile/screens/messages_developer.dart';
import 'package:techlinkerappmobile/screens/notifications_developer.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import '../constants/colors.dart';
import '../screens/home_developer.dart';

class MainDeveloperPage extends StatefulWidget {
  final int developerId;
  const MainDeveloperPage({super.key, required this.developerId});

  @override
  State<MainDeveloperPage> createState() => _MainDeveloperPageState();
}

class _MainDeveloperPageState extends State<MainDeveloperPage> {
  int index = 0;
  List<Widget> screens = [];
  Developer developer = Developer();

  @override
  void initState() {
    super.initState();
    screens = [
      DeveloperHome(
        developerId: widget.developerId,
      ),
      DeveloperMessages(developerId: widget.developerId),
      DeveloperNotifications(),
      DeveloperProfile(developerId: widget.developerId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: thirdColor,
          iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: textColor),
          ),
          labelTextStyle: MaterialStateProperty.all(
            TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, -2),
              ),
            ],
            gradient: LinearGradient(
              colors: [
                const Color(0xFF39BCFD),
                const Color(0xFF4F93E9),
                const Color(0xFF7176EE),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: NavigationBar(
            height: 90,
            backgroundColor: Colors.white,
            selectedIndex: index,
            onDestinationSelected: (index) {
              setState(() {
                this.index = index;
              });
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.messenger_outline),
                label: 'Messages',
              ),
              NavigationDestination(
                icon: Icon(Icons.notifications_none_outlined),
                label: 'Notifications',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_2_outlined),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
