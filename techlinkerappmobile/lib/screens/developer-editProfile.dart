import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/developer.dart';
import 'package:techlinkerappmobile/screens/common/flash-correct-message-widget.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';

class EditProfileView extends StatefulWidget {
  final Developer myDeveloper;
  const EditProfileView({required this.myDeveloper, Key? key})
      : super(key: key);
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late TextEditingController _urlController;
  late Developer developer;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _urlController = TextEditingController();
    super.initState();
  }

  Future UpdateProfile(String id) async {
    final profile = await DeveloperService.getDeveloperById(id);
    final updatedDeveloper = Developer.fromJson(profile);
    if (mounted) {
      setState(() {
        developer = updatedDeveloper;
      });
    }

    final updateProfile = Developer(
      id: updatedDeveloper.id,
      firstName: updatedDeveloper.firstName,
      lastName: updatedDeveloper.lastName,
      email: _emailController.text,
      phone: _phoneController.text,
      password: _passwordController.text,
      role: updatedDeveloper.role,
      description: updatedDeveloper.description,
      image: _urlController.text,
      bannerImage: updatedDeveloper.bannerImage,
    );
    final update = await DeveloperService.updateProfileDeveloper(updateProfile);
    return update;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    if (!value.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain uppercase letters';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain special characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a phone number';
    }
    if (value.length != 9) {
      return 'Phone number must have 9 digits';
    }
    return null;
  }

  String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a profile URL';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil"),
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, widget.myDeveloper.toJson());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: ListView(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration:
                        InputDecoration(labelText: 'Correo electrónico'),
                    validator: validateEmail,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                    validator: validatePassword,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Teléfono'),
                    validator: validatePhone,
                  ),
                  TextFormField(
                    controller: _urlController,
                    decoration: InputDecoration(labelText: 'URL del perfil'),
                    validator: validateUrl,
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Map<String, dynamic> updateProfileDeveloper =
                            await UpdateProfile(
                                widget.myDeveloper.id.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: FlashCorrectMessageWidget(
                                message: "Profile updated successfully"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                          ),
                        );
                        Navigator.pop(context, updateProfileDeveloper);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      elevation: 0,
                    ),
                    child: Container(
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
                              "Guardar Cambios",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
