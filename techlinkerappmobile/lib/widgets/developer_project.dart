import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/project.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperProject extends StatelessWidget {
  final Project project;
  final String projectIcon;

  const DeveloperProject(
      {required this.project, required this.projectIcon, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(projectIcon),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        project.name!,textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),                GestureDetector(
                      onTap: () {
                        DeveloperService.deleteProject(project.id);
                        // Lógica para eliminar el elemento
                        // Puedes implementar aquí la acción que deseas realizar al hacer clic en el icono "delete"
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(project.description!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16)),
                const SizedBox(height: 5),
                //a row with an link icon and a text
                GestureDetector(
                  onTap: () {
                    launch(project.projectUrl!);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.link),
                      SizedBox(width: 5),
                      Flexible(
                        child: Text(
                          'Click Here',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
