import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/developer_study_center.dart';

class DeveloperStudyCenter extends StatelessWidget {
  final StudyCenterUniqueItem studyCenter;
  final String studyCenterIcon;

  const DeveloperStudyCenter(
      {required this.studyCenter, required this.studyCenterIcon, super.key});

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
                image: NetworkImage(studyCenterIcon),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  studyCenter.name!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(height: 5),
                Text(studyCenter.description!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16)),
                const SizedBox(height: 5),
                //text that shows the date of the studyCenter
                Text(
                  studyCenter.graduationDate!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}