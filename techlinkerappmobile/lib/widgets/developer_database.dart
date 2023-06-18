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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      database.name!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ],
                )),
                Center(
                    child: Text(
                        database.description.length > 20
                            ? database.description!.substring(0, 20) + '...'
                            : database.description!,
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
