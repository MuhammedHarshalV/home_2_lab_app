//
import 'package:flutter/material.dart';
import 'package:icon_infoware/core/themes/colors.dart';

class PatientContactCard extends StatelessWidget {
  final String address;
  const PatientContactCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 248, 238, 210),
        border: Border(left: BorderSide(color: AppColors.appYellow, width: 6)),
        borderRadius: BorderRadius.circular(10),
      ),
      // margin: const EdgeInsets.all(20),
      // height: 140, // Adjust based on your content
      child: Stack(
        children: [
          // Background Shape
          // CustomPaint(
          //   size: Size(MediaQuery.of(context).size.width, 140),
          //   painter: NotchedCardPainter(),
          // ),

          // Content
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: const Text(
                        "Mr. Gokul",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 60),
                  ],
                ),
                // const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        address,
                        style: TextStyle(
                          color: AppColors.appBlack,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.appLightGreen,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        "Random",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 60), // Space for the floating button
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: -65,
            bottom: -65,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                shape: BoxShape.rectangle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
            ),
          ),
          // Floating Call Button
          Positioned(
            right: 5,
            bottom: 5,
            child: Container(
              // width: 70,
              // height: 70,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: const Icon(
                  Icons.phone_outlined,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
