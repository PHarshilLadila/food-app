import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class NearestRestauranst extends StatelessWidget {
  const NearestRestauranst({
    super.key,
    required this.height,
    required this.nearestRestaurant,
    required this.width,
  });

  final double height;
  final List<Map<String, dynamic>> nearestRestaurant;
  final double width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        int crossAxisCount = 2;
        double childAspectRatio = 0.8;

        if (screenWidth > 1300) {
          // Desktop view
          crossAxisCount = 6;
          childAspectRatio = 0.9;
        } else if (screenWidth > 1200 && screenWidth < 1300) {
          // Desktop view
          crossAxisCount = 6;
          childAspectRatio = 0.8;
        } else if (screenWidth > 1000 && screenWidth < 1200) {
          // Tablet view
          crossAxisCount = 5;
          childAspectRatio = 0.75;
        } else if (screenWidth > 800 && screenWidth < 1000) {
          crossAxisCount = 4;
          childAspectRatio = 0.7;
        } else if (screenWidth > 600) {
          crossAxisCount = 3;
          childAspectRatio = 0.85;
        } else if (screenWidth > 500) {
          crossAxisCount = 2;
          childAspectRatio = 0.65;
        } else if (screenWidth > 350) {
          crossAxisCount = 2;
          childAspectRatio = 0.60;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: nearestRestaurant.length,
          // physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              child: Container(
                width: width / 2.3,
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 15,
                      offset: const Offset(5, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        nearestRestaurant[index]['image'],
                        height: height / 6,
                      ),
                      SizedBox(
                        height: height / 200,
                      ),
                      Text(
                        nearestRestaurant[index]['name'],
                        style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height / 150,
                      ),
                      Text(
                        nearestRestaurant[index]['duration'],
                        style: GoogleFonts.poppins(
                            color: AppColors.blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
