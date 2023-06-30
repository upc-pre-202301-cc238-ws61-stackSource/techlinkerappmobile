import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/accept_terms.dart';
import 'package:techlinkerappmobile/screens/main_company_page.dart';
import 'package:techlinkerappmobile/screens/terms.dart';
import 'package:techlinkerappmobile/util/db_helper.dart';

import '../models/company.dart';
import '../models/developer.dart';
import '../models/digital_profile.dart';
import '../models/education.dart';
import '../services/company_service.dart';
import '../services/developer_service.dart';
import '../services/login_service.dart';
import 'common/flash-correct-message-widget.dart';
import 'common/flash-incorrect-message-widget.dart';
import 'main_developer_page.dart';

class RegisterFormScreen extends StatefulWidget {
  final bool isDeveloper;
  const RegisterFormScreen({super.key, required this.isDeveloper});
  @override
  _RegisterFormScreenState createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final formKey = GlobalKey<FormState>();
  DbHelper? dbHelper;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String email = '';
  String firstName = '';
  int? id;
  String lastName = '';
  String password = '';
  String phone = '';

  String address = '';
  String city = '';
  String country = '';

  String role = '';
  String name = '';
  String owner = '';
  String ruc = '';
  String bannerImage = '';
  String description = '';
  String image = '';
  bool hasPressedRegister = false;
  bool accepted = false;

  AcceptTerms? acceptTerms = AcceptTerms(id: 0, isAccepted: 0);

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
    dbHelper!.openDb();
    hasPressedRegister = false;

    if (mounted) {
      insertAcceptTermsInDB(acceptTerms!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isDeveloper
            ? const Text("Register Developer")
            : const Text("Register Company"),
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
          padding: EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: Theme(
                      data: ThemeData(
                        inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 5.0,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Enter First Name',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color.fromARGB(255, 236, 233, 233),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter first name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                firstName = value!;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Enter Last Name',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color.fromARGB(255, 236, 233, 233),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter last name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                lastName = value!;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Enter Email',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color.fromARGB(255, 236, 233, 233),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter email';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                email = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Enter Password',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color.fromARGB(255, 236, 233, 233),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isPasswordVisible =
                                          !_isPasswordVisible; // Alternar la visibilidad de la contraseña
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                password = value!;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_isPasswordVisible,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color.fromARGB(255, 236, 233, 233),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _isConfirmPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isConfirmPasswordVisible =
                                          !_isConfirmPasswordVisible; // Alternar la visibilidad de la contraseña
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                formKey.currentState!.save();
                                if (value!.isEmpty) {
                                  return 'Please confirm password';
                                }
                                if (value != password) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: !_isConfirmPasswordVisible,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelText: 'Enter Phone',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Color.fromARGB(255, 236, 233, 233),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter phone';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                phone = value!;
                              },
                              keyboardType: TextInputType.phone,
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            if (!widget.isDeveloper)
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Enter Address',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 236, 233, 233),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter address';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  address = value!;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            if (!widget.isDeveloper)
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Enter City',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 236, 233, 233),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter city';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  city = value!;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            if (!widget.isDeveloper)
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Enter Country',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 236, 233, 233),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter country';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  country = value!;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            if (!widget.isDeveloper)
                              TextFormField(
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  labelText: 'Enter Name of Your Company',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 236, 233, 233),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter name of comany';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  name = value!;
                                },
                                keyboardType: TextInputType.text,
                              ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            hasPressedRegister
                                ? CircularProgressIndicator()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 25),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          verifyDataToRegister();
                                          formKey.currentState!.save();
                                          if (widget.isDeveloper) {
                                            Developer developer = Developer(
                                              id: id,
                                              firstName: firstName,
                                              lastName: lastName,
                                              email: email,
                                              phone: phone,
                                              password: password,
                                              role: role,
                                              description: description,
                                              image: image,
                                              bannerImage: bannerImage,
                                            );
                                            print(
                                                'Llamando a insert developer');
                                            registerDeveloper(developer);
                                          } else {
                                            Company company = Company(
                                              id: id,
                                              firstName: firstName,
                                              lastName: lastName,
                                              email: email,
                                              phone: phone,
                                              password: password,
                                              role: role,
                                              description: description,
                                              image: image,
                                              bannerImage: bannerImage,
                                              ruc: ruc,
                                              owner: owner,
                                              name: name,
                                              address: address,
                                              country: country,
                                              city: city,
                                            );
                                            print('Llamando a insert Company');
                                            registerCompany(company);
                                          }

                                          if (mounted) {
                                            setState(() {
                                              hasPressedRegister = true;
                                            });
                                          }
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
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(15.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Text(
                                                textAlign: TextAlign.center,
                                                "Register",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void verifyDataToRegister() {
    image = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
    if (widget.isDeveloper) {
      bannerImage =
          'https://www.techyon.es/media/news/web-developer-principales-responsabilidades-y-competencias_1650467356_100.jpg';
      role = 'DEVELOPER';
      description = 'I am a developer';
    } else {
      role = 'COMPANY';
      bannerImage =
          'https://i0.wp.com/www.iedunote.com/img/23559/what-is-a-company-scaled.jpg?fit=2560%2C1696&amp;quality=100&amp;ssl=1';
      owner = 'Bill Gates';
      ruc = '123456789012345';
      description = 'I am a recruiter';
    }
  }

  Future insertAcceptTermsInDB(AcceptTerms acceptTerms) async {
    await dbHelper!.openDb();
    await dbHelper!.insertAcceptTerms(acceptTerms);
  }

  Future registerDeveloper(Developer dev) async {
    final user = await LoginService.GetUserByEmail(email);
    if (user.email == email) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              FlashIncorrectMessageWidget(message: 'Email already regystered'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      );
    } else {
      final response = await DeveloperService.insertDeveloper(dev);
      print('-----------------------User Inserted-----------------------');
      print(response);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              FlashCorrectMessageWidget(message: 'Regystered successfully'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      );
      final devCreated =
          await DeveloperService.getDeveloperById(response['id'].toString());
      final devCasted = Developer.fromJson(devCreated);
      print('-----------------------Developer Created-----------------------');
      print(devCreated);
      DigitalProfile digitalProfile = DigitalProfile(
        developer: devCasted,
        id: devCasted.id!,
        name: 'Digital Profile of ${devCasted.firstName}',
      );
      print(
          '-----------------------Digital Profile Instanced-----------------------');
      print(digitalProfile.toJson());
      final respondeDigitalProfile =
          await DeveloperService.setDigitalProfile(digitalProfile);
      print(
          '-----------------------Digital Profile Inserted-----------------------');
      print(respondeDigitalProfile);
      //Cear sus dems cosas
      final createdDigitalProfile =
          await DeveloperService.getDigitalProfileByDeveloperId(
              response['id'].toString());
      print(
          '-----------------------Digital Profile Created-----------------------');
      print(createdDigitalProfile);

      Education education = Education(
        career: 'Realated to Software Engineering',
        digitalProfile: DigitalProfile.fromJson(createdDigitalProfile),
        id: 0,
      );
      print(
          '-----------------------Education Instanced-----------------------');
      print(education.toJson());

      final responseEducation =
          await DeveloperService.setEducationPublish(education);
      print('-----------------------Education Inserted-----------------------');
      print(responseEducation);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainDeveloperPage(developerId: response['id'].toInt())));
    }
  }

  Future registerCompany(Company company) async {
    final user = await LoginService.GetUserByEmail(email);
    if (user.email == email) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              FlashIncorrectMessageWidget(message: 'Email already regystered'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      );
    } else {
      final response = await CompanyService.insertCompany(company);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              FlashCorrectMessageWidget(message: 'Regystered successfully'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      );

      final user2 = await LoginService.GetUserByEmail(email);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainCompanyPage(companyId: user2.id!)));

      print(response);
    }
  }

  Future isAcceptedTerms(AcceptTerms acceptTerms) async {
    print("--------------------------------Update------------------");
    await dbHelper!.openDb();
    final response = await dbHelper!.getLatestAcceptTerms();

    setState(() {
      print(response);
      if (response.isAccepted == 1) {
        accepted = true;
      } else {
        accepted = false;
      }
    });
  }
}
