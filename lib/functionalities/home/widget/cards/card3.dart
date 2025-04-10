import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Card3 extends StatelessWidget {
  const Card3({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        double positionTop = 25;
        double positionLeft = 150;
        double imageHeight = 120;

        if (screenWidth > 1300) {
          imageHeight = 350;
          positionTop = 80;
          positionLeft = 900;
          debugPrint("screenWidth > 1300");
        } else if (screenWidth > 1200 && screenWidth < 1300) {
          imageHeight = 500;
          positionTop = 70;
          positionLeft = 700;
          debugPrint("screenWidth > 1200 && screenWidth < 1300");
        } else if (screenWidth > 1000 && screenWidth < 1200) {
          imageHeight = 400;
          positionTop = 60;
          positionLeft = 600;
          debugPrint("screenWidth > 1000 && screenWidth < 1200");
        } else if (screenWidth > 800 && screenWidth < 1000) {
          imageHeight = 300;
          positionTop = 50;
          positionLeft = 500;
          debugPrint("screenWidth > 800 && screenWidth < 1000");
        } else if (screenWidth > 600) {
          imageHeight = 250;
          positionTop = 20;
          positionLeft = 400;
          debugPrint("screenWidth > 600 ");
        } else if (screenWidth > 500) {
          imageHeight = 200;
          positionTop = 20;
          positionLeft = 300;
          debugPrint("screenWidth > 500");
        } else if (screenWidth > 350) {
          imageHeight = 150;
          positionTop = 30;
          positionLeft = 170;
          debugPrint("screenWidth > 350");
        }
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: AppColors.lightGreen,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              gradient: LinearGradient(
                  colors: [AppColors.lightGreen, AppColors.darkGreen],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 10, left: 10, bottom: 0),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Image.asset(
                      "assets/images/home/pizzagirl.png",
                      height: imageHeight,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                  Positioned(
                    top: positionTop,
                    left: positionLeft,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width / 50, vertical: height / 60),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              "Special Deal For\nApril",
                              // AppLocalizations.of(context)!.specialDeal,
                              style: GoogleFonts.viga(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.whiteColor,
                                  AppColors.whiteColor,
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 50,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 12),
                                child: GradientText(
                                  "Buy Now",
                                  // AppLocalizations.of(context)!.buyNow,
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  gradient: const LinearGradient(
                                    colors: [
                                      AppColors.lightGreen,
                                      AppColors.darkGreen,
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
