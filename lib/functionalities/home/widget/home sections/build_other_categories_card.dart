import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/widget/grid%20and%20lists/meals_categories.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget buildOtherCategoriesCard(
    BuildContext context, bool isLightTheme, HomeProvider homeProvider) {
  final height = MediaQuery.of(context).size.height;
  final width = MediaQuery.of(context).size.width;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealsCategories(
            height: height,
            categories: homeProvider.foodCategoriesModel,
            width: width,
          ),
        ),
      );
    },
    child: Container(
      height: height / 15,
      margin: const EdgeInsets.all(2),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(17, 0, 0, 0),
            blurRadius: 1,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ],
        color: isLightTheme
            ? const Color.fromARGB(255, 238, 255, 234)
            : const Color(0xFF333739),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.category_rounded,
              color: isLightTheme ? AppColors.blackColor : Colors.white),
          SizedBox(width: width / 40),
          Text(
            AppLocalizations.of(context)!.otherCategories,
            style: GoogleFonts.poppins(
                color: isLightTheme ? AppColors.blackColor : Colors.white),
          ),
        ],
      ),
    ),
  );
}
