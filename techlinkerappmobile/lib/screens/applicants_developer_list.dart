import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../models/developer_unique_item.dart';
import '../widgets/developer_item.dart';

class ApplicantsList extends StatefulWidget {
  const ApplicantsList({super.key});

  @override
  State<ApplicantsList> createState() => _ApplicantsListState();
}

class _ApplicantsListState extends State<ApplicantsList> {
  final developersItem = DeveloperUniqueItem.developerItems();
  List<DeveloperUniqueItem> filteredDevelopers =
      DeveloperUniqueItem.developerItems();
  String devName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context),
        backgroundColor: primaryColor,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            children: [
              searchBar(),
              // Expanded(
              //     child: ListView.builder(
              //         itemCount: filteredDevelopers.length,
              //         itemBuilder: (context, index) {
              //           final developer = filteredDevelopers[index];

              //           return DeveloperItem(
              //             item: developer,
              //             urlImage: developer.image!,
              //           );
              //         }))
            ],
          ),
        ));
  }

  PreferredSizeWidget myAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Text(
        'Applicants',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
        Color(0xFF39BCFD),
        Color(0xFF4F93E9),
        Color(0xFF7176EE),
      ]))),
    );
  }

  Widget searchBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              border: InputBorder.none,
            ),
            onChanged: (value) {
              setState(() {
                devName = value;
              });
            },
          ),
        ),
        InkWell(
            onTap: () {
              List<DeveloperUniqueItem> newFilteredDevelopers = developersItem
                  .where((element) => element.name!
                      .toLowerCase()
                      .contains(devName.toLowerCase()))
                  .toList();

              setState(() {
                filteredDevelopers.clear();
                filteredDevelopers.addAll(newFilteredDevelopers);
              });
            },
            child: Icon(Icons.search)),
      ]),
    );
  }
}
