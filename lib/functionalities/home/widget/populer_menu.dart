import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class PopulerMenu extends StatelessWidget {
  const PopulerMenu({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/home/item1.png",
            height: height / 12,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Green Noddle",
                  style: GoogleFonts.poppins(
                      color: AppColors.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: width / 3,
                ),
                Text(
                  "\$ 15",
                  style: GoogleFonts.poppins(
                      color: AppColors.darkOrange,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
