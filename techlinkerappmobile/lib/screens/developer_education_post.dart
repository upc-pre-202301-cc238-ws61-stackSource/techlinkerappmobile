import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'dart:math';
import 'package:table_calendar/table_calendar.dart';
import 'package:techlinkerappmobile/models/study_center.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import '../models/education.dart';
import 'common/flash-correct-message-widget.dart';

class DeveloperEducationPost extends StatefulWidget {
  final int digitalProfileId;
  const DeveloperEducationPost({super.key, required this.digitalProfileId});

  @override
  State<DeveloperEducationPost> createState() => _DeveloperEducationPostState();
}

enum Progress { InProgress, Finished }

class _DeveloperEducationPostState extends State<DeveloperEducationPost> {
  String iconUrl = '';
  String nameStudyCenter = '';
  DateTime entryDate = DateTime.now();
  DateTime graduationDate = DateTime.now();
  String description = '';
  int progress = 0;
  Progress _progressSelected = Progress.InProgress;

  final formKey = GlobalKey<FormState>();

  void imageUrlLoad() {
    Random random = Random();
    int randomNumber = random.nextInt(10) + 1;

    if (randomNumber < 5) {
      iconUrl =
          'https://images.creativemarket.com/0.1.0/ps/8618628/1820/1214/m1/fpnw/wm0/home-education-icon-online-learning-elearning-distance-thin-line-web-symbol-on-white-background-.jpg?1593177412&s=d6a36cafbdb2d8f77952c52f8ae97136';
    } else {
      iconUrl =
          'https://static.vecteezy.com/system/resources/previews/002/556/411/non_2x/teach-school-and-education-certificarte-roll-silhouette-style-icon-free-vector.jpg';
    }
  }

  Future publishEducation(String id) async {
    final education = await DeveloperService.getEducationByDigitalProfileId(id);
    print(education);
    final studyCenter = StudyCenter(
      description: description,
      education: Education.fromJson(education),
      entryDate: entryDate,
      graduationDate: graduationDate,
      iconUrl: iconUrl,
      id: 0,
      name: nameStudyCenter,
      progress: progress,
    );
    final publishStudyCenter =
        await DeveloperService.postStudyCenter(studyCenter);
    print(publishStudyCenter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF39BCFD),
                Color(0xFF4F93E9),
                Color(0xFF7176EE),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0), // Radio de borde
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5), // Sombra
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Color de fondo transparente
            elevation: 0, // Sin sombra
            title: const Text(
              'Add Education',
              style: TextStyle(
                color: cardColor,
                fontSize: 23,
                fontWeight: FontWeight.w600,
              ),
            ), // Título personalizado
            centerTitle: true,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Name of Study Center",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Study Center',
                        hintStyle: TextStyle(color: textColor),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name of study center';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        nameStudyCenter = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Entry Date",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TableCalendar(
                        firstDay: DateTime.parse('1950-01-01T00:00:00.000Z'),
                        lastDay: DateTime.parse('2023-12-31T00:00:00.000Z'),
                        focusedDay: entryDate,
                        selectedDayPredicate: (day) =>
                            isSameDay(entryDate, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            entryDate = selectedDay;
                          });
                        },
                      )),
                  SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Graduation Date",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TableCalendar(
                        firstDay: DateTime.parse('1950-01-01T00:00:00.000Z'),
                        lastDay: DateTime.parse('2023-12-31T00:00:00.000Z'),
                        focusedDay: graduationDate,
                        selectedDayPredicate: (day) =>
                            isSameDay(graduationDate, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            graduationDate = selectedDay;
                          });
                        },
                      )),
                  SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Description of career",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description of career',
                        hintStyle: TextStyle(color: textColor),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description of career';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        description = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Progress",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('In progress'),
                    leading: Radio(
                      value: Progress.InProgress,
                      groupValue: _progressSelected,
                      onChanged: (Progress? value) {
                        setState(() {
                          _progressSelected = value!;
                          progress = 0;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Finished'),
                    leading: Radio(
                      value: Progress.Finished,
                      groupValue: _progressSelected,
                      onChanged: (Progress? value) {
                        setState(() {
                          _progressSelected = value!;
                          progress = 1;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          imageUrlLoad();
                          publishEducation(widget.digitalProfileId.toString());

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: FlashCorrectMessageWidget(
                                  message: 'Education added successfully'),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0.0,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        elevation: 0,
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF39BCFD),
                              Color(0xFF4F93E9),
                              Color(0xFF7176EE),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                textAlign: TextAlign.center,
                                "Publish",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ]),
          )
        ],
      ),
    );
  }
}
