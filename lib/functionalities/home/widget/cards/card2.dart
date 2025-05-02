import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Card2 extends StatelessWidget {
  const Card2({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: AppColors.lightGreen,
          child: Container(
            height: height / 4.5,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              gradient: LinearGradient(
                colors: [
                  Color(0xffE9F7BA),
                  Color(0xffE9F7BA),
                ],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 150,
                      width: 250,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(31, 118, 90, 109),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GradientText(
                              AppLocalizations.of(context)!.specialDeal,
                              style: GoogleFonts.viga(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xff6B3A5B),
                                  Color(0xff6B3A5B),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height / 60,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12),
                                child: GradientText(
                                  AppLocalizations.of(context)!.buyNow,
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
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset(
                      "assets/images/home/myveggies.png",
                      width: width / 2,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
