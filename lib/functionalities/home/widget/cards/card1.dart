import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Card1 extends StatelessWidget {
  const Card1({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        double cardHeight = height / 4.5;
        // double cardWidth = 0.8;

        if (screenWidth > 1300) {
          cardHeight = height / 3;
          debugPrint("screenWidth > 1300");
        } else if (screenWidth > 1200 && screenWidth < 1300) {
          cardHeight = height / 4.5;
          debugPrint("screenWidth > 1200 && screenWidth < 1300");
        } else if (screenWidth > 1000 && screenWidth < 1200) {
          cardHeight = height / 4.5;
          debugPrint("screenWidth > 1000 && screenWidth < 1200");
        } else if (screenWidth > 800 && screenWidth < 1000) {
          cardHeight = height / 4.5;
          debugPrint("screenWidth > 800 && screenWidth < 1000");
        } else if (screenWidth > 600) {
          cardHeight = height / 4.5;
          debugPrint("screenWidth > 600 ");
        } else if (screenWidth > 500) {
          cardHeight = height / 4.5;
          debugPrint("screenWidth > 500");
        } else if (screenWidth > 350) {
          cardHeight = height / 4.5;
          debugPrint("screenWidth > 350");
        }
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: AppColors.lightGreen,
          child: Container(
            height: cardHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              gradient: LinearGradient(
                  colors: [AppColors.lightGreen, AppColors.darkGreen],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
              image: DecorationImage(
                scale: 2,
                alignment: Alignment.topCenter,
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/home/opacities.png",
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 10, left: 10, bottom: 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        "assets/images/home/ice.png",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width / 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GradientText(
                          "Special Deal For March",
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
                                  fontSize: 16, fontWeight: FontWeight.w500),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
