import 'package:flutter/material.dart';
import '../models/programming_language.dart';

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
                    child: Text(
                  programmingLanguage.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18),
                )),
                Center(
                    child: Text(programmingLanguage.description!,
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
