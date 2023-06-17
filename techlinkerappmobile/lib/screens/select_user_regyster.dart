import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/screens/register_form_screen.dart';

import '../constants/colors.dart';
import 'login.dart';

class SelectUserRegyster extends StatelessWidget {
  const SelectUserRegyster({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.center, 
                children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF39BCFD),
                        Color(0xFF4F93E9),
                        Color(0xFF7176EE),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(children: <Widget> [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return LoginPage();
                                },
                              ));
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Reygister",
                      style: TextStyle(
                          color: cardColor,
                          fontSize: 40,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "as a",
                      style: TextStyle(
                          color: cardColor,
                          fontSize: 41,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 25,
                    )
                  ]),
                ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Developer', style: TextStyle(color: Colors.blueAccent, fontSize: 30, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 15),
                    Image(
                      image: AssetImage('lib/assets/icons/developer.jpg'),
                      height: 150,  // Altura de la imagen
                      width: 200,
                      fit: BoxFit.cover,
                      //color: Colors.black54,
                      colorBlendMode: BlendMode.darken,
                      ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                          // Acción cuando se presiona el botón "developer"
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterFormScreen(isDeveloper: true,)));
                      },
                      child: Text('Developer', style: TextStyle(fontSize: 18)),
                    ),
                    const SizedBox(height: 30),
                    Text('Company', style: TextStyle(color: textColor, fontSize: 30, fontWeight: FontWeight.w800),),
                    const SizedBox(height: 15),
                    Image(
                      image: AssetImage('lib/assets/icons/corporate-business-people.jpg'),
                      height: 150,  // Altura de la imagen
                      width: 200,
                      fit: BoxFit.cover,
                      //color: Colors.black54,
                      colorBlendMode: BlendMode.darken,
                      ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Acción cuando se presiona el botón "company"
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterFormScreen(isDeveloper: false,)));
                      },
                      child: Text('Recruiter', style: TextStyle(fontSize: 18)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
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