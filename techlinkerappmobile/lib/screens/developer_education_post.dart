import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'dart:math';
import 'package:techlinkerappmobile/models/developer_study_center.dart';
import  'package:techlinkerappmobile/services/developer_service.dart';

class DeveloperEducationPost extends StatefulWidget {
  const DeveloperEducationPost({super.key});

  @override
  State<DeveloperEducationPost> createState() => _DeveloperEducationPostState();
}

class _DeveloperEducationPostState extends State<DeveloperEducationPost> {

  String career = '';
  String iconUrl = '';
  String nameStudyCenter = '';
  String entryDate = '';
  String graduationDate = '';
  String description = '';
  String progress = '';

  final formKey = GlobalKey<FormState>();

  void imageUrlLoad(){
    Random random = Random();
    int randomNumber = random.nextInt(10) + 1;

    if(randomNumber < 5){
      iconUrl = 'https://us.123rf.com/450wm/iconsdom/iconsdom2012/iconsdom201201095/160378070-icono-de-la-universidad-signo-de-vector-negro-con-trazos-editables-ilustraci%C3%B3n-del-concepto.jpg?ver=6';
    }else{
      iconUrl = 'https://static.vecteezy.com/system/resources/previews/002/556/411/non_2x/teach-school-and-education-certificarte-roll-silhouette-style-icon-free-vector.jpg';
    }
  }


  void publishEducation(String id) async {

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
            title: Text('Developer Education',
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

      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Text(
                      "Career",
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
                        labelText: 'Name of Career',
                        hintStyle: TextStyle(color: textColor),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value !.isEmpty) {
                          return 'Please enter a name of career';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        career = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      validator: (value){
                        if(value !.isEmpty) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Entry Date',
                        hintStyle: TextStyle(color: textColor),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value !.isEmpty) {
                          return 'Please enter a entry date';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        entryDate = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Graduation Date',
                        hintStyle: TextStyle(color: textColor),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value !.isEmpty) {
                          return 'Please enter a graduation date';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        graduationDate = value!;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                      validator: (value){
                        if(value !.isEmpty) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Progress',
                        hintStyle: TextStyle(color: textColor),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value){
                        if(value !.isEmpty) {
                          return 'Please enter a progress';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        progress = value!;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: ElevatedButton(
                      
                        onPressed: () {
                          imageUrlLoad();
                          if(formKey.currentState!.validate()){
                            formKey.currentState!.save();

                            print('Career: $career');
                            print('Study Center: $nameStudyCenter');
                            print('Entry Date: $entryDate');
                            print('Graduation Date: $graduationDate');
                            print('Description of career: $description');
                            print('Progress: $progress');
                          }
                        },
                        child: Text('Publish'),
                    ),
                  ),
                      ]
                    ),
                  )
                  
                ],
              ),
            )
          ]
        )
      ),
    );
  }
}
