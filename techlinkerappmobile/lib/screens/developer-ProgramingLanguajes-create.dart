import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:techlinkerappmobile/models/digital_profile.dart';
import 'package:techlinkerappmobile/models/programming_language.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import '../constants/colors.dart';
import 'common/flash-correct-message-widget.dart';

class DeveloperLanguajePost extends StatefulWidget {
  final DigitalProfile myDigitalProfile;
  const DeveloperLanguajePost({super.key, required this.myDigitalProfile});

  @override
  State<DeveloperLanguajePost> createState() => _DeveloperLanguajePostState();
}

class _DeveloperLanguajePostState extends State<DeveloperLanguajePost> {
  final formKey = GlobalKey<FormState>();
  String nameLanguaje = "";
  String DescriptionLangauje = "";
  String IconURL = "";
  DateTime ObtainDate = DateTime.now();
  bool _isSubmitting = false;

  Future postLanguajetoDatabase(DigitalProfile digitalProfile) async {
    final PostLanguaje = ProgrammingLanguage(
      id: 0,
      name: nameLanguaje,
      description: DescriptionLangauje,
      iconLink: IconURL,
      digitalProfile: digitalProfile,
    );
    print(PostLanguaje);
    final post = await DeveloperService.postProgramingLanguaje(PostLanguaje);
    print(post);
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
              bottom: Radius.circular(5.0), // Radio de borde
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
            title: Text(
              'Post Experience Languaje ',
              style: TextStyle(
                color: cardColor,
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ), // Título personalizado
            centerTitle: true,
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
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal:
                                  12.0), // Ajusta el tamaño del campo de texto
                          icon: Icon(Icons.drive_file_rename_outline),
                          labelText: 'name Languaje',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name Languaje';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nameLanguaje = value!;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 20.0, top: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal:
                                  12.0), // Ajusta el tamaño del campo de texto
                          icon: Icon(Icons.description),
                          labelText: 'Description Programing Languaje',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          DescriptionLangauje = value!;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25.0, right: 20.0, top: 8.0),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal:
                                  12.0), // Ajusta el tamaño del campo de texto
                          icon: Icon(Icons.link),
                          labelText: 'Icon Languaje URL',
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
                    const SizedBox(height: 16.0),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          //Send to API
                          postLanguajetoDatabase(widget.myDigitalProfile);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: FlashCorrectMessageWidget(
                                  message:
                                      'Programing Languaje added successfully'),
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
                )),
          ],
        ),
      ),
    );
  }
}
