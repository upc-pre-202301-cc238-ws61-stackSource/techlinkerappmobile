import 'package:flutter/material.dart';

import '../constants/colors.dart';

class DeveloperFilter extends StatefulWidget {
  const DeveloperFilter({super.key});

  @override
  State<DeveloperFilter> createState() => _DeveloperFilterState();
}

class _DeveloperFilterState extends State<DeveloperFilter> {
  // State for selected options
  final selectedYearsOfExperience = [];
  final selectedFramework = [];
  final selectedProgrammingLanguage = [];
  final selectedDatabase = [];
  double ticknessWidth = 0.7;
  double verticalWith = 10;

  final yearsOfExperienceOptions = ['Intern', '1 - 2', '3 - 5', '5+'];
  final frameworkOptions = [
    'Angular',
    'ASP.NET Core',
    'Django',
    'Vue',
    'React Native'
  ];
  final programmingLanguageOptions = [
    'JavaScript',
    'TypeScript',
    'Python',
    'Java',
    'C#',
    'C++',
  ];
  final databaseOptions = [
    'MySQL',
    'Oracle',
    'PostgreSQL',
    'SQL Server',
    'MongoDB'
  ];

  Widget buildFilterScreen() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 35),

            const Text(
              'Years of experience',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w400, color: textColor),
            ),
            SizedBox(height: verticalWith),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: yearsOfExperienceOptions
                    .map((yearOfExperience) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(yearOfExperience),
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  if (yearOfExperience == 'Intern') {
                                    selectedYearsOfExperience.clear();
                                  } else {
                                    selectedYearsOfExperience.remove('Intern');
                                  }
                                  selectedYearsOfExperience
                                      .add(yearOfExperience);
                                } else {
                                  selectedYearsOfExperience
                                      .remove(yearOfExperience);
                                }
                              });
                            },
                            selected: selectedYearsOfExperience
                                .contains(yearOfExperience),
                          ),
                        ))
                    .toList(),
              ),
            ),
            SizedBox(height: verticalWith),
            Divider(thickness: ticknessWidth, color: textColor),
            SizedBox(height: verticalWith),

            // Framework filter
            const Text(
              'Framework',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w400, color: textColor),
            ),
            SizedBox(height: verticalWith),
            Row(
              children: frameworkOptions
                  .take(3)
                  .map((framework) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(framework),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedFramework.add(framework);
                              } else {
                                selectedFramework.remove(framework);
                              }
                            });
                          },
                          selected: selectedFramework.contains(framework),
                        ),
                      ))
                  .toList(),
            ),
            Row(
              children: frameworkOptions
                  .skip(3)
                  .map((framework) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(framework),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedFramework.add(framework);
                              } else {
                                selectedFramework.remove(framework);
                              }
                            });
                          },
                          selected: selectedFramework.contains(framework),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: verticalWith),
            Divider(thickness: ticknessWidth, color: textColor),

            SizedBox(height: verticalWith),

            const Text(
              'Programming Language',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w400, color: textColor),
            ),
            SizedBox(height: verticalWith),
            Row(
              children: programmingLanguageOptions
                  .take(3)
                  .map((programmingLanguage) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(programmingLanguage),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedProgrammingLanguage
                                    .add(programmingLanguage);
                              } else {
                                selectedProgrammingLanguage
                                    .remove(programmingLanguage);
                              }
                            });
                          },
                          selected: selectedProgrammingLanguage
                              .contains(programmingLanguage),
                        ),
                      ))
                  .toList(),
            ),
            Row(
              children: programmingLanguageOptions
                  .skip(3)
                  .map((programmingLanguage) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(programmingLanguage),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedProgrammingLanguage
                                    .add(programmingLanguage);
                              } else {
                                selectedProgrammingLanguage
                                    .remove(programmingLanguage);
                              }
                            });
                          },
                          selected: selectedProgrammingLanguage
                              .contains(programmingLanguage),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: verticalWith),
            Divider(thickness: ticknessWidth, color: textColor),

            SizedBox(height: verticalWith),

            const Text(
              'Databases',
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w400, color: textColor),
            ),
            SizedBox(height: verticalWith),
            Row(
              children: databaseOptions
                  .take(3)
                  .map((database) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(database),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedDatabase.add(database);
                              } else {
                                selectedDatabase.remove(database);
                              }
                            });
                          },
                          selected: selectedDatabase.contains(database),
                        ),
                      ))
                  .toList(),
            ),
            Row(
              children: databaseOptions
                  .skip(3)
                  .map((database) => Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(database),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedDatabase.add(database);
                              } else {
                                selectedDatabase.remove(database);
                              }
                            });
                          },
                          selected: selectedDatabase.contains(database),
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: verticalWith),
            Divider(thickness: ticknessWidth, color: textColor),
            //create a button for closing the filters overlay
            SizedBox(height: verticalWith),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop({
                  'selectedFramework': selectedFramework,
                  'selectedProgrammingLanguage': selectedProgrammingLanguage,
                  'selectedDatabase': selectedDatabase,
                  'selectedYearsOfExperience': selectedYearsOfExperience
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Filter Developers',
                            style: TextStyle(color: cardColor, fontSize: 17))
                      ])),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: const SizedBox(height: 5),
        title: Row(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.filter_list, color: textColor),
            ),
            const SizedBox(width: 8),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Filter Developers',
                style: TextStyle(
                  color: textColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop({
                  'selectedFramework': [],
                  'selectedProgrammingLanguage': [],
                  'selectedDatabase': [],
                  'selectedYearsOfExperience': []
                });
              },
              child: const Icon(Icons.close, color: textColor, size: 30),
            ),
          ],
        ),
      ),
      backgroundColor: primaryColor,
      body: buildFilterScreen(),
    );
  }
}
