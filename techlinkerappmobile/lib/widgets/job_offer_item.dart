import 'package:flutter/material.dart';
import 'package:techlinkerappmobile/models/company_unique_post.dart';
import '../constants/colors.dart';
import '../models/post.dart';

class JobOfferCompay extends StatelessWidget {
  final Post item;

  const JobOfferCompay({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor),
        color: Colors.white,
      ),
      child: Center(
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(1.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.imageUrl!,
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
                padding: EdgeInsets.only(left: 6.0, top: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.description!,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: textColor,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.add_location,
                          size: 16,
                          color: Colors.white,
                        ),
                        Text(
                          item.title!,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Apply for',
                                style: TextStyle(color: buttonTextColor)),
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(100, 20),
                              backgroundColor: buttonColor,
                            ),
                          ),
                        )),
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
                          item.title!,
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
