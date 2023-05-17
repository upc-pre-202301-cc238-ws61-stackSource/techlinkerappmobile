import 'package:flutter/material.dart';
import '../models/job_offer.dart';
import '../constants/colors.dart';

class JobOfferItem extends StatelessWidget{
  final JobOffer item;

  const JobOfferItem({super.key, required this.item});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor),
        color: secondaryColor,
      ),

      child: Center(
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding (
                padding: EdgeInsets.all(1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.image!,
                    height: 150,
                    width: 350,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 6.0, top: 6.0),
                child: Text(
                  item.title!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: textColor,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left:6.0, top: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.add_location,
                          size: 16,
                          color: Colors.white,
                        ),
                        Text(
                          item.location!,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                          ),
                        ),
                        Expanded (
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: (){
                                },
                                child: Text('Apply for', style: TextStyle(color: buttonTextColor)),
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(100, 20),
                                  backgroundColor: buttonColor,
                                ),
                              ),
                            )
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.business,
                          size: 16,
                          color: Colors.white,
                        ),
                        Text(
                          item.company!,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}