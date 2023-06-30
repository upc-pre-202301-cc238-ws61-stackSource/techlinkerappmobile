import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:techlinkerappmobile/constants/colors.dart';
import 'package:techlinkerappmobile/models/company.dart';
import 'package:techlinkerappmobile/screens/common/flash-correct-message-widget.dart';
import 'package:techlinkerappmobile/services/company_service.dart';


class EditProfileView extends StatefulWidget {
  final Company myCompany;
  const EditProfileView({required this.myCompany, Key? key}) : super(key: key);
  @override
  _EditProfileViewState createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _phoneController;
  late TextEditingController _urlController;
  late Company company;
  final formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  late File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    _emailController = TextEditingController(text: widget.myCompany.email);
    _passwordController = TextEditingController(text: widget.myCompany.password);
    _phoneController = TextEditingController(text: widget.myCompany.phone);
    _urlController = TextEditingController(text: widget.myCompany.image);
    super.initState();
  }

  Future<bool> _checkCameraAndStoragePermissions() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.status;
    PermissionStatus storagePermissionStatus = await Permission.storage.status;

    if (cameraPermissionStatus.isGranted && storagePermissionStatus.isGranted) {
      return true;
    }

    Map<Permission, PermissionStatus> permissionStatuses = await [
      Permission.camera,
      Permission.storage,
    ].request();

    return permissionStatuses[Permission.camera]!.isGranted &&
        permissionStatuses[Permission.storage]!.isGranted;
  }

  Future getImage(ImageSource source) async {
    bool hasPermissions = await _checkCameraAndStoragePermissions();

    if (!hasPermissions) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text( 'Se necesitan permisos para acceder a la cámara y la galería.'),
            action: SnackBarAction(
              label: 'Solicitar permisos',
              onPressed: () {
                _checkCameraAndStoragePermissions();
              },
            )
        ),
      );
    }

    final pickedFile = await picker.getImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future UpdateProfile(String id) async {
    final profile = await CompanyService.getCompanyById(id);
    final updatedCompany = Company.fromJson(profile);

    if (mounted) {
      setState(() {
        company = updatedCompany;
      });
    }

    final updateProfile = Company(
      id: updatedCompany.id,
      firstName: updatedCompany.firstName,
      lastName: updatedCompany.lastName,
      email: _emailController.text.isNotEmpty ? _emailController.text : updatedCompany.email,
      phone: _phoneController.text.isNotEmpty ? _phoneController.text : updatedCompany.phone,
      password: _passwordController.text.isNotEmpty ? _passwordController.text : updatedCompany.password,
      role: updatedCompany.role,
      description: updatedCompany.description,
      image: _urlController.text.isNotEmpty ? _urlController.text : updatedCompany.image,
      bannerImage: updatedCompany.bannerImage,
      ruc: updatedCompany.ruc,
      owner: updatedCompany.owner,
      name: updatedCompany.name,
      address: updatedCompany.address,
      country: updatedCompany.country,
      city: updatedCompany.city,
    );

    final update = await CompanyService.updateProfileCompany(updateProfile);
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
    if (value?.isEmpty ?? true) {
      return null; // Campo opcional
    }
    if (!value!.contains('@')) {
      return 'Invalid email format';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value?.isEmpty ?? true) {
      return null; // Campo opcional
    }
    if (!value!.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain uppercase letters';
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain special characters';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value?.isEmpty ?? true) {
      return null; // Campo opcional
    }
    if (value!.length != 9) {
      return 'Phone number must have 9 digits';
    }
    return null;
  }

  String? validateUrl(String? value) {
    if (value?.isEmpty ?? true) {
      return null; // Campo opcional
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
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
            Navigator.pop(context, widget.myCompany.toJson());
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 16),
        child: ListView(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Correo electrónico'),
                    validator: validateEmail,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                        labelText: 'Contraseña',
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                        ),
                    ),
                    validator: validatePassword,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Teléfono'),
                    validator: validatePhone,
                  ),
                  TextFormField(
                    controller: _urlController,
                    decoration: InputDecoration(labelText: 'URL de perfil'),
                    validator: validateUrl,
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Seleccionar una imagen'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  GestureDetector(
                                    child: const Text('Tomar una foto'),
                                    onTap: () {
                                      getImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: GestureDetector(
                                      child: const Text('Elegir una foto de la galería'),
                                      onTap: () {
                                        getImage(ImageSource.gallery);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
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
                          children: <Widget>[
                            Icon(Icons.add_a_photo, color: Colors.white),
                            SizedBox(width: 10),
                            Text(
                              'Cambiar imagen de perfil',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        Map<String, dynamic> updateProfileCompany =
                        await UpdateProfile(widget.myCompany.id.toString());
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: FlashCorrectMessageWidget(
                                message: "Profile updated successfully"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                          ),
                        );
                        Navigator.pop(context, updateProfileCompany);
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


