import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/developer_certificate_item.dart';
import 'package:techlinkerappmobile/models/developer_study_center.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;



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
  DateTime ObtainDate = DateTime.now();
  bool _isSubmitting = false;

  Future<DeveloperCertificateItem> postCertificateToDataBase(String id) async {
    final education = await DeveloperService.getEducationByDigitalProfileId(id);
    print(education);
    final postCertificate = DeveloperCertificateItem(
      id: 0,
      title: TittleCertificate,
      description: DescriptionCertificate,
      iconUrl: IconURL,
      obtainedDate: ObtainDate,
      education: Education.fromJson(education),
    );

    final post = await DeveloperService.postCertificate(postCertificate);
    print(post);
    return post;
  }
  
  void _submitForm(String id) async {

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        _isSubmitting = true;
      });
      // Enviar los datos a la API
      final response = await postCertificateToDataBase(id);
      setState(() {
        _isSubmitting = false;
      });
      if (response != null) {
        // Solicitud exitosa
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Certificate created successfully'),
          ),
        );
        Navigator.pop(context);
      } else {
        // Solicitud con error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create post. Please try again.'),
          ),
        );
      }
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
                        return 'Please enter a url of picture from certificate';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      IconURL = value!;
                    },
                  ),
                ),

                TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Date',
                      ),
                      style: 
                        TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
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
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _isSubmitting ? null : () => _submitForm('1'),
                  child: _isSubmitting
                      ? CircularProgressIndicator()
                      : Text('Submit'),
                ),
              ],
            ),)
          ],
        ),
      ),
    );
  }
}
