import 'package:flutter/material.dart';
import '../models/job_offer.dart';
import '../widgets/job_offer_item.dart';
import '../constants/colors.dart';

class DeveloperHome extends StatefulWidget {
  DeveloperHome({super.key});
  @override
  State<DeveloperHome> createState() => _DeveloperHomeState();
}

class _DeveloperHomeState extends State<DeveloperHome> {
  final jobOffersItem = JobOffer.jobOffers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 34,
            ),
            const Text(
              "Job",
              style: TextStyle(
                  color: textColor,
                  fontSize: 44,
                  fontWeight: FontWeight.w800),
            ),
            const Text(
              "Offers",
              style: TextStyle(
                  color: textColor,
                  fontSize: 44,
                  fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 17,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: jobOffersItem.length,
                itemBuilder: (context, index) => JobOfferItem(
                  item: jobOffersItem[index],
                ),
              ),
            ),

          ]),
        ));
  }
}