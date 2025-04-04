import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQTab extends StatelessWidget {
  const FAQTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "FAQ Content",
        style: GoogleFonts.poppins(
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
