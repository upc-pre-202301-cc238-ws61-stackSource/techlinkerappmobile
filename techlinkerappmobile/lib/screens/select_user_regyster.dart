import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/screens/register_form_screen.dart';

import '../constants/colors.dart';
import 'login.dart';

class SelectUserRegyster extends StatelessWidget {
  const SelectUserRegyster({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return LoginPage();
                                    },
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Register",
                          style: TextStyle(
                            color: cardColor,
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                child: Column(
                  children: [
                    Card(
                      color: cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          // Action to execute when the card is clicked (for Developer)
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterFormScreen(
                                isDeveloper: true,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  scale: 0.5,
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'lib/assets/icons/developer.jpg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Developer',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: mainCardText,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Find a job that suits you',
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: secondaryCardText,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Add additional information or buttons as needed
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Card(
                      color: cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      child: InkWell(
                        onTap: () {
                          // Action to execute when the card is clicked (for Company)
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RegisterFormScreen(
                                isDeveloper: false,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                image: DecorationImage(
                                  scale: 0.5,
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'lib/assets/icons/corporate-business-people.jpg',
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Company',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: mainCardText,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    'Find the developer you need',
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: secondaryCardText,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      // Add additional information or buttons as needed
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
