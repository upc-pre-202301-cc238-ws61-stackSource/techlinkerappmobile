import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:techlinkerappmobile/models/certificate.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import '../constants/colors.dart';
import '../models/education.dart';
import 'common/flash-correct-message-widget.dart';

class DeveloperCertificateRegister extends StatefulWidget {
  final int digitalProfileId;
  const DeveloperCertificateRegister({Key? key, required this.digitalProfileId})
      : super(key: key);

  @override
  State<DeveloperCertificateRegister> createState() =>
      _DeveloperCertificateRegisterState();
}

class _DeveloperCertificateRegisterState
    extends State<DeveloperCertificateRegister> {
  final TextEditingController _obtainedDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String TittleCertificate = "";
  String DescriptionCertificate = "";
  String IconURL = "";
  DateTime ObtainDate = DateTime.now();
  bool _isSubmitting = false;

  Future postCertificateToDataBase(String id) async {
    final education = await DeveloperService.getEducationByDigitalProfileId(id);
    print(education);
    final postCertificate = Certificate(
      id: 0,
      title: TittleCertificate,
      description: DescriptionCertificate,
      iconUrl: IconURL,
      obtainedDate: ObtainDate,
      education: Education.fromJson(education),
    );

    final post = await DeveloperService.postCertificate(postCertificate);
    print(post);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Certificate"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF39BCFD),
                Color(0xFF4F93E9),
                Color(0xFF7176EE),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 20.0, top: 8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Tittle',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        TittleCertificate = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 20.0, top: 8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        DescriptionCertificate = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 20.0, top: 8.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Icon Certificate URL',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a URL';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        IconURL = value!;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 20.0, top: 8.0),
                    child: Text(
                      'Select date of Obtained Certificate',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TableCalendar(
                        firstDay: DateTime.parse('1950-01-01T00:00:00.000Z'),
                        lastDay: DateTime.parse('2023-12-31T00:00:00.000Z'),
                        focusedDay: ObtainDate,
                        selectedDayPredicate: (day) =>
                            isSameDay(ObtainDate, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            ObtainDate = selectedDay;
                          });
                        },
                      )),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        //Send to API
                        postCertificateToDataBase(
                            widget.digitalProfileId.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: FlashCorrectMessageWidget(
                                message: 'Certificate added successfully'),
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
                      width: 150,
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
                              "Submit",
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
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
