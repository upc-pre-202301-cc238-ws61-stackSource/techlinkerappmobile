import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/certificate.dart';

import 'package:url_launcher/url_launcher.dart';

class DeveloperCertificate extends StatelessWidget {
  final Certificate certificate;
  final String certificateIcon;

  const DeveloperCertificate(
      {required this.certificate, required this.certificateIcon, super.key});

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
                image: NetworkImage(certificateIcon),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  certificate.title!,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18),
                ),
                const SizedBox(height: 5),
                Text(
                    certificate.description.length > 25
                        ? certificate.description!.substring(0, 25) + '...'
                        : certificate.description!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16)),
                const SizedBox(height: 5),
                //text that shows the date of the certificate
                Text(
                  certificate!.obtainedDate.toString().substring(0, 10),
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
