// import 'package:flutter/material.dart';

// class DeveloperProject extends StatelessWidget {
//   final DeveloperProjectItem project;
//   final String projectIcon;

//   const DeveloperProject(
//       {required this.project, required this.projectIcon, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       elevation: 2,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(height: 10),
//           Container(
//             height: 80,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(10),
//                 topRight: Radius.circular(10),
//               ),
//               image: DecorationImage(
//                 fit: BoxFit.contain,
//                 image: NetworkImage(projectIcon),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                     child: Text(
//                   project.name!,
//                   style: const TextStyle(
//                       fontWeight: FontWeight.w700, fontSize: 18),
//                 )),
//                 Center(
//                     child: Text(project.description!,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w400, fontSize: 16)))
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
