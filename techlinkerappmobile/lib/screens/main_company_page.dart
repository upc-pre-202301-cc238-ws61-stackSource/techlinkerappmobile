import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/developer.dart';
import 'package:techlinkerappmobile/screens/company-profile.dart';
import 'package:techlinkerappmobile/screens/messages_company.dart';
import 'package:techlinkerappmobile/screens/notifications_company.dart';
import 'package:techlinkerappmobile/screens/Profile_AddProjectDeveloper.dart';
import '../constants/colors.dart';
import '../models/company.dart';
import 'home_company.dart';

class MainCompanyPage extends StatefulWidget {
  final int companyId;
  const MainCompanyPage({super.key, required this.companyId});

  @override
  State<MainCompanyPage> createState() => _MainCompanyPageState();
}

class _MainCompanyPageState extends State<MainCompanyPage> {
  int index = 0;
  Company company = Company();
  List<Widget> screens = [];

  @override
  void initState() {
    super.initState();

    company = Company(
      id: 4,
      firstName: "Tomas",
      lastName: "Pastor",
      email: "tomas@gmail.com",
      phone: "+51 923 123 345",
      password: "pass0r234",
      role: "RECRUITER",
      description: "Somos una empresa de desarrollo de software",
      image:
          "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      bannerImage: "",
      ruc: "1234567890",
      owner: "Tomas Pastor",
      name: "On Google",
      address: "Av. Amazonas N34-123",
      country: "Ecuador",
      city: "Quito",
    );

    screens = [
      CompanyHome(
        companyId: widget.companyId,
      ),
      CompanyMessage(company: company),
      CompanyNotifications(),
      CompanyProfile(company: company),
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
            const TextStyle(
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
