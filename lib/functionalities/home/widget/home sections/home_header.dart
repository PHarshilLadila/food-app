import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: GradientText(
            AppLocalizations.of(context)!.homeTitle,
            style:
                GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
            gradient: const LinearGradient(
              colors: [AppColors.lightGreen, AppColors.darkGreen],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade100
                      : Colors.black12,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/home/notification.png",
                height: MediaQuery.of(context).size.height / 30,
                width: MediaQuery.of(context).size.width / 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
