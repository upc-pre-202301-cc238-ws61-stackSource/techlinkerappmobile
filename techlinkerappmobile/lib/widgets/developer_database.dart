import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/database.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';

class DeveloperDatabase extends StatelessWidget {
  final Database database;
  final String databaseIcon;

  const DeveloperDatabase(
      {required this.databaseIcon, required this.database, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Container(
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                fit: BoxFit.contain,
                image: NetworkImage(databaseIcon),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 60.0),
                          child: Text(
                  database.name!,
                  style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                ),
                        ),
                        GestureDetector(
                          onTap: () {
                            DeveloperService.deleteDatabase(database.id);
                            // Lógica para eliminar el elemento
                            // Puedes implementar aquí la acción que deseas realizar al hacer clic en el icono "delete"
                          },
                          child: Icon(Icons.delete),
                        ),
                      ],
                    )),
                Center(
                    child: Text(database.description!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
