import 'package:flutter/material.dart';
import '../models/programming_language.dart';
import '../services/developer_service.dart';

class DeveloperProgrammingLanguage extends StatelessWidget {
  final ProgrammingLanguage programmingLanguage;
  final String programmingLanguageIcon;

  const DeveloperProgrammingLanguage(
      {required this.programmingLanguageIcon,
      required this.programmingLanguage,
      super.key});

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
                image: NetworkImage(programmingLanguageIcon),
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
                        programmingLanguage.name!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        DeveloperService.deleteProgrammingLanguage(
                            programmingLanguage.id);
                        // Lógica para eliminar el elemento
                        // Puedes implementar aquí la acción que deseas realizar al hacer clic en el icono "delete"
                      },
                      child: Icon(Icons.delete),
                    ),
                  ],
                )),
                Center(
                    child: Text(
                        programmingLanguage.description.length > 20
                            ? programmingLanguage.description!
                                    .substring(0, 20) +
                                '...'
                            : programmingLanguage.description!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16)))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void Eliminar() {}
}
