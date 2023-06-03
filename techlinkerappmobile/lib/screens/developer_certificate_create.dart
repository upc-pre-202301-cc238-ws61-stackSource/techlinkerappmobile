

import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/developer_certificate_item.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';




class DeveloperCertificateRegister extends StatefulWidget {
  const DeveloperCertificateRegister({Key? key}) : super(key: key);

  @override
  State<DeveloperCertificateRegister> createState() => _DeveloperCertificateRegisterState();
}

class _DeveloperCertificateRegisterState extends State<DeveloperCertificateRegister> {
  final TextEditingController _obtainedDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String TittleCertificate = "";
  String DescriptionCertificate = "";
  String IconURL = "";
  String ObtainDate ="";
  void createPost(String id) async {
    final developer = await DeveloperService.getDeveloperById(id);
    final postCertificate = DeveloperCertificateItem(
        id: id,
        title: TittleCertificate,
        description: DescriptionCertificate,
        iconUrl: IconURL,
        obtainedDate: ObtainDate);

    final post = await DeveloperService.setCompanyPost(postCertificate);
    if(post!=null){
      DescriptionCertificate = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Post your certificate!",
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Form(key:formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 8.0),
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
                  padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 8.0),
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
                  padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Picture',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a picture from certificate';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      IconURL = value!;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 8.0),
                  child: InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(2000),
                        maxTime: DateTime(2100),
                        onConfirm: (date) {
                          String formattedDate = "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
                          setState(() {
                            _obtainedDateController.text = formattedDate;
                          });
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.en,
                      );
                    },
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date',
                      ),
                      controller: _obtainedDateController,
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a date';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        ObtainDate = value!;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      //Send to API
                      //createPost('11');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: FlashCorrectMessageWidget(message: 'Post created successfully'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,

                        ),
                      );
                      Navigator.pop(context);

                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
