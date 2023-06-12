import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AddProjectDeveloper extends StatefulWidget {

  @override
  State<AddProjectDeveloper> createState() => AddProjectDeveloperState();
}

class AddProjectDeveloperState extends State<AddProjectDeveloper> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF2F1F7),
      appBar: AppBar(
        toolbarHeight: 280, // Ajusta el valor de la altura del AppBar según tus necesidades
        elevation: 0, // Oculta la sombra del AppBar
        backgroundColor: Colors.transparent, // Establece un fondo transparente para el AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient:  LinearGradient(
              colors: [
                Color(0xFF39BCFD),
                Color(0xFF4F93E9),
                Color(0xFF7176EE),
              ],
            ),
          ),
          child: Column(
            children:<Widget> [
              Padding(
                padding: const EdgeInsets.only(top:35,bottom: 10),
                child: Text("Lastest Projects",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              CircleAvatar(
                backgroundImage:
                CachedNetworkImageProvider("https://ejemplo.com/imagen.jpg"),
                radius: 45,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15,bottom: 5),
                child: Text("Name Usuario",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text("Developer Enginner",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      endDrawer: Drawer(
        child: Container(
          color: const Color(0xFF4F93E9),
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF4F93E9),),
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    title: const Text('Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),),
                    onTap: () {},
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    title: const Text('Notifications',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),),
                    onTap: () { },
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    title: const Text('Messages',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),),
                    onTap: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body:Container(
        child: Column(
          children: [
            Form(child:
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 35,right: 35,bottom: 20,top:20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Ajusta el tamaño del campo de texto
                      icon:Icon(Icons.link) ,
                      hintText: 'Project   URL',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35,right: 35,bottom: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Ajusta el tamaño del campo de texto
                      icon:Icon(Icons.folder_open) ,
                      hintText: 'Name Project',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35,right: 35,bottom: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0), // Ajusta el tamaño del campo de texto
                      icon:Icon(Icons.pending_actions) ,
                      hintText: 'Description',
                      labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      hintStyle: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text("Publish",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight:FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black54,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 35),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                )
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
