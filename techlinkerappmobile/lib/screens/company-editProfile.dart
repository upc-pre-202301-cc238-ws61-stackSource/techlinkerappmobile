import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/company.dart';
import 'package:techlinkerappmobile/screens/common/flash-correct-message-widget.dart';
import 'package:techlinkerappmobile/services/company_service.dart';
class EditProfileView extends StatefulWidget {
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
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    _urlController = TextEditingController();
    super.initState();
  }
  Future UpdateProfile(String id) async{
    final Profile = await CompanyService.getCompanyById(id);

    final updateProfile = Company(
        id: company.id,
        firstName: company.firstName,
        lastName: company.lastName,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        role: company.role,
        description: company.description,
        image: _urlController.text,
        bannerImage: company.bannerImage);

    final update = await CompanyService.updateProfileCompany(updateProfile);

   @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _urlController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit your profile!",
          style: TextStyle(
              color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Correo electrónico'),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Contraseña'),
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: 'Teléfono'),
                  ),
                  TextFormField(
                    controller: _urlController,
                    decoration: InputDecoration(labelText: 'URL del perfil'),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        formKey.currentState!.save();

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: FlashCorrectMessageWidget(message: "Profiled updated successfully"),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Guardar cambios'),
                  ),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
