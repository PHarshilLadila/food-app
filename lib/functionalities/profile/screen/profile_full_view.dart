import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_sctring.dart';
import 'package:food_app/functionalities/profile/provider/profile_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileFullView extends StatefulWidget {
  const ProfileFullView({super.key});

  @override
  State<ProfileFullView> createState() => _ProfileFullViewState();
}

class _ProfileFullViewState extends State<ProfileFullView> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            colorFilter: ColorFilter.mode(
                // ignore: deprecated_member_use
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop),
            image: const AssetImage(
              "assets/images/Pattern.png",
            ),
            fit: kIsWeb ? BoxFit.cover : BoxFit.none,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Consumer<ProfileProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  var profileImage =
                      value.profile!.profileImage ?? AppString.defaultImage;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: AppColors.extraLightGreen,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: AppColors.lightGreen,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColors.darkGreen,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: GradientText(
                              "Here Your Profile Image",
                              // AppLocalizations.of(context)!.profileTitle,
                              // 'Find Your \nFavorite Food',
                              style: GoogleFonts.poppins(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                              gradient: const LinearGradient(
                                colors: [
                                  AppColors.lightGreen,
                                  AppColors.darkGreen,
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.09,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Center(
                          child: Image.memory(
                            base64Decode(profileImage),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
