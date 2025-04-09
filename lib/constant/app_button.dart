import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomeButton extends StatelessWidget {
  final double? heights;
  final double? widths;
  final String? name;
  final void Function()? ontap;
  const CustomeButton({
    super.key,
    this.heights,
    this.widths,
    this.name,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key("myCustomButtonKey"),
      onTap: ontap,
      child: Container(
        width: widths,
        height: heights,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: const LinearGradient(
            begin: Alignment(-0.95, 0.0),
            end: Alignment(1.0, 0.0),
            colors: [
              Color(0xff53E88B),
              Color(0xff15BE77),
            ],
            stops: [0.0, 1.0],
          ),
        ),
        child: Center(
          child: AutoSizeText(
            name!,
            minFontSize: 16,
            maxFontSize: 18,
            style: GoogleFonts.poppins(color: AppColors.whiteColor, fontSize: MediaQuery.of(context).size.width / 30, fontWeight: FontWeight.w700),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
