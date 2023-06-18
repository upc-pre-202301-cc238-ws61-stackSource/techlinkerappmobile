import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:techlinkerappmobile/models/database.dart';
import 'package:techlinkerappmobile/models/digital_profile.dart';
import 'package:techlinkerappmobile/models/framework.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import '../constants/colors.dart';
import 'common/flash-correct-message-widget.dart';

class DeveloperDatabasePost extends StatefulWidget {
  final DigitalProfile myDigitalProfile;
  const DeveloperDatabasePost({super.key, required this.myDigitalProfile});
  @override
  State<DeveloperDatabasePost> createState() => _DeveloperDatabasePostState();
}

class _DeveloperDatabasePostState extends State<DeveloperDatabasePost> {
  final formKey = GlobalKey<FormState>();
  String nameDatabase = "";
  String DescriptionDatabase = "";
  String IconURL = "";
  DateTime ObtainDate = DateTime.now();
  bool _isSubmitting = false;

  Future postDatabasetoDatabase(DigitalProfile digitalProfile) async {
    final PostDatabase = Database(
      id: 0,
      name: nameDatabase,
      description: DescriptionDatabase,
      iconLink: IconURL,
      digitalProfile: digitalProfile,
    );
    print(PostDatabase);
    final post = await DeveloperService.postDatabase(PostDatabase);
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
              'Add Database ',
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
                          labelText: 'name Database',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name Database';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nameDatabase = value!;
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
                          icon: Icon(Icons.description_sharp),
                          labelText: 'Description Database',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          DescriptionDatabase = value!;
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
                          labelText: 'Icon Database URL',
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
                    const SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          //Send to API
                          postDatabasetoDatabase(widget.myDigitalProfile);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: FlashCorrectMessageWidget(
                                  message: 'Database added successfully'),
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
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
