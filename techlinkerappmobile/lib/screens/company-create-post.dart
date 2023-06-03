import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/company_unique_item.dart';
import 'package:techlinkerappmobile/models/company_unique_post.dart';
import 'package:techlinkerappmobile/screens/common/flash-correct-message-widget.dart';
import 'package:techlinkerappmobile/services/company_service.dart';

import '../constants/colors.dart';

class CompanyCreatePost extends StatefulWidget {
  const CompanyCreatePost({super.key});

  @override
  State<CompanyCreatePost> createState() => _CompanyCreatePostState();
}

enum Title { BackendDeveloper, FrontendDeveloper, FullStackDeveloper, MobileDeveloper, UXUIDesigner, DataScientist, Other }

class _CompanyCreatePostState extends State<CompanyCreatePost> {
 
  String titlePost = 'Backend Developer';
  String descriptionPost = '';
  String imageUrlPost = '';
  
  Title _titleSelected = Title.BackendDeveloper;

  final formKey = GlobalKey<FormState>();

  void createPost(String id) async {
    final company = await CompanyService.getCompanyById(id);
    final postJob =
    final post = await CompanyService.setCompanyPost(postJob);
    if(post != null){
      descriptionPost = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create a Post of Job',
          style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
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
              const Text(
                "Select developer's you need",
                style: TextStyle(color: Colors.black, fontSize: 20.0)),
              const SizedBox(height: 16.0),
              ListTile(
                title: const Text('Backend Developer'),
                leading: Radio<Title>(
                  value: Title.BackendDeveloper,
                  groupValue: _titleSelected,
                  onChanged: (Title? value) {
                    setState(() {
                      _titleSelected = value!;
                      titlePost = 'Backend Developer';
                      imageUrlPost = 'https://www.simplilearn.com/ice9/free_resources_article_thumb/How_to_Become_a_Back_End_Developer.jpg';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Frontend Developer'),
                leading: Radio(
                  value: Title.FrontendDeveloper,
                  groupValue: _titleSelected,
                  onChanged: (Title? value) {
                    setState(() {
                      _titleSelected = value!;
                      titlePost = 'Frontend Developer';
                      imageUrlPost = "https://media.licdn.com/dms/image/D5612AQG2wFDFDltiNg/article-cover_image-shrink_720_1280/0/1675322684139?e=2147483647&v=beta&t=R_9OphmuNCHhnP3GTyVyOtlHqxxF8CFBIdJTyGz98Rw";
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Fullstack Developer'),
                leading: Radio(
                  value: Title.FullStackDeveloper,
                  groupValue: _titleSelected,
                  onChanged: (Title? value) {
                    setState(() {
                      _titleSelected = value!;
                      titlePost = 'Fullstack Developer';
                      imageUrlPost = 'https://thetapacademy.com/wp-content/uploads/2022/10/full-stack-web-developer-1024x1024.jpg';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Mobile Developer'),
                leading: Radio(
                  value: Title.MobileDeveloper,
                  groupValue: _titleSelected,
                  onChanged: (Title? value) {
                    setState(() {
                      _titleSelected = value!;
                      titlePost = 'Mobile Developer';
                      imageUrlPost = 'https://iwdtechnologies.com/blog/wp-content/uploads/2020/05/app-development-services.jpg';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('UXUI Designer'),
                leading: Radio(
                  value: Title.UXUIDesigner,
                  groupValue: _titleSelected,
                  onChanged: (Title? value) {
                    setState(() {
                      _titleSelected = value!;
                      titlePost = 'UXUI Designer';
                      imageUrlPost = 'https://www.acquisition-international.com/wp-content/uploads/2021/09/UI-UX-Design.jpg';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Data Scientist'),
                leading: Radio(
                  value: Title.DataScientist,
                  groupValue: _titleSelected,
                  onChanged: (Title? value) {
                    setState(() {
                      _titleSelected = value!;
                      titlePost = 'Data Scientist';
                      imageUrlPost = 'https://bernardmarr.com/wp-content/uploads/2022/11/The-Top-5-Data-Science-And-Analytics-Trends-In-2023.jpg';
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('Other'),
                leading: Radio(
                  value: Title.Other,
                  groupValue: _titleSelected,
                  onChanged: (Title? value) {
                    setState(() {
                      _titleSelected = value!;
                      imageUrlPost = 'https://www.simplilearn.com/ice9/free_resources_article_thumb/tester-or-developer-what-suits-you-the-most.jpg';
                    });
                  },
                ),
              ),
              if (_titleSelected == Title.Other)
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 20.0, top: 8.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Specify developer type',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      titlePost = value!;
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
                    descriptionPost = value!;
                  },
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
          ),
          ),
          ],
        ),
      ),
    );
  }
}