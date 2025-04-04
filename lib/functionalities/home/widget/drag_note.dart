import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DragNote extends StatelessWidget {
  const DragNote({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(
            FontAwesomeIcons.infoCircle,
            size: 14,
          ),
          SizedBox(
            width: width / 80,
          ),
          AutoSizeText(
            "Note ",
            minFontSize: 14,
            maxFontSize: 14,
            style: GoogleFonts.poppins(
                color: AppColors.blackColor,
                fontSize: width / 25,
                fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: AutoSizeText(
              " : Drag & Drop Item (with Longpress) in to Cart, Ensure that Drop the Item in Middel of Cart Box.",
              minFontSize: 14,
              maxFontSize: 14,
              style: GoogleFonts.poppins(
                  color: AppColors.blackColor,
                  fontSize: width / 25,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
