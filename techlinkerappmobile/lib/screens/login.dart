import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:techlinkerappmobile/screens/select_user_regyster.dart';

import '../services/login_service.dart';
import 'common/error_dialog.dart';
import 'common/flash-correct-message-widget.dart';
import 'main_company_page.dart';
import 'main_developer_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String emailTyped = '';
  String passwordTyped = '';

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image(
            image: AssetImage('lib/assets/icons/hands_logo.jpg'),
            fit: BoxFit.cover,
            color: Color.fromARGB(164, 0, 0, 0),
            colorBlendMode: BlendMode.darken,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200,
                height: 100,
                child: Image.asset(
                  'lib/assets/icons/techlinkerlogo.png',
                  fit: BoxFit.cover,
                  // color: Colors.black54,
                  // colorBlendMode: BlendMode.darken,
                ),
              ),
              Form(
                key: formKey,
                child: Theme(
                  data: ThemeData(
                    brightness: Brightness.dark,
                    primarySwatch: Colors.cyan,
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Email',
                            border: OutlineInputBorder(),
                            filled: true,
                            //fillColor: Colors.grey[200],
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            emailTyped = value!;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Enter Password',
                            border: OutlineInputBorder(),
                            filled: true,
                            //fillColor: Colors.grey[200],
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            passwordTyped = value!;
                          },
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: MaterialButton(
                            height: 40.0,
                            minWidth: 100.0,
                            color: Colors.blueAccent,
                            textColor: Colors.black87,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                verifyInitUser(emailTyped);
                              }
                            },
                            splashColor: Colors.redAccent,
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SelectUserRegyster()));
                          },
                          child: Text('Register',
                              style: TextStyle(fontSize: 20.0)),
                          splashColor: Colors.redAccent,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void verifyInitUser(String email) async {
    final user = await LoginService.GetUserByEmail(email);
    if (user.email != '') {
      if (user.password == passwordTyped) {
        print(user.id);
        if (user.role!.toUpperCase() == 'DEVELOPER') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MainDeveloperPage(developerId: user.id!)));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainCompanyPage(companyId: user.id!)));
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                FlashCorrectMessageWidget(message: 'Logged in successfully'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        );
      } else {
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                ErrorDialog().build(context, 'Wrong password'));
      }
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) =>
              ErrorDialog().build(context, 'User not regystered'));
    }
  }
}
