import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/framework.dart';
import 'package:techlinkerappmobile/services/developer_service.dart';

class DeveloperFramework extends StatelessWidget {
  final Framework framework;
  final String frameworkIcon;

  const DeveloperFramework(
      {required this.frameworkIcon, required this.framework, super.key});

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
                image: NetworkImage(frameworkIcon),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    framework.name!,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
                Center(
                    child: Text(
                        framework.description!.length > 20
                            ? framework.description!.substring(0, 20) + '...'
                            : framework.description!,
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
