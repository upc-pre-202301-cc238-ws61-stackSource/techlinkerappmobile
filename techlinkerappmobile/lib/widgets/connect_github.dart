import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/common/flash-correct-message-widget.dart';

class GithubCard extends StatefulWidget {
  final int developerId;
  const GithubCard({required this.developerId, super.key});

  @override
  State<GithubCard> createState() => _GithubCardState();
}

class _GithubCardState extends State<GithubCard> {
  TextEditingController _usernameController = TextEditingController();

  String _username = '';
  String _avatarUrl = '';
  String _githubUrl = '';

  void _connectAccount(String username, BuildContext context) async {
    try {
      if (username == '') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                FlashCorrectMessageWidget(message: 'Enter a valid username'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        );
        return;
      }

      final response = await DeveloperService.getGithubData(username);

      if (response != null && response['login'] != null) {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString('username_${widget.developerId}', response['login']);
          prefs.setString(
              'avatar_url_${widget.developerId}', response['avatar_url']);
          prefs.setString(
              'github_url_${widget.developerId}', response['html_url']);
        });

        print(response['login']);
        print(response['avatar_url']);
        print(response['html_url']);

        setState(() {
          _username = response['login'];
          _avatarUrl = response['avatar_url'];
          _githubUrl = response['html_url'];
        });

        Navigator.pop(context,
            [response['login'], response['avatar_url'], response['html_url']]);
      } else {
        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.height * 0.25),
        Card(
          margin: EdgeInsets.all(32.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'GitHub Username',
                  ),
                ),
                const SizedBox(height: 16.0),
                _usernameController.text == ''
                    ? ElevatedButton(
                        onPressed: () {},
                        child: const Text('Connect Account'),
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 182, 192,
                              200), // Cambiar el color de fondo del botón
                          onPrimary: Colors
                              .white, // Cambiar el color del texto del botón
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          _connectAccount(_usernameController.text, context);
                        },
                        child: const Text('Connect Account'),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
