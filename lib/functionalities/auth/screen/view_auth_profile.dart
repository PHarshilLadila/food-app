import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_sctring.dart';
import 'package:food_app/functionalities/auth/screen/set_location.dart';
import 'package:food_app/functionalities/auth/screen/upload_photo.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ViewAuthProfile extends StatefulWidget {
  final String? profileUrl;
  const ViewAuthProfile({super.key, this.profileUrl});

  @override
  State<ViewAuthProfile> createState() => _ViewAuthProfileState();
}

class _ViewAuthProfileState extends State<ViewAuthProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: height * 0.03,
                width: width * 0.8,
                decoration: BoxDecoration(
                  color: AppColors.lightOrange,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.darkOrange,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: const Image(
          image: AssetImage('assets/images/Pattern.png'),
          fit: BoxFit.cover,
        ),
      ),
      backgroundColor: const Color(0xffFEFEFF),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double screenWidth = constraints.maxWidth;
              double containerWidth = width / 1.5;
              double containerHeight = height / 3;

              if (screenWidth > 1300) {
                debugPrint("screenWidth > 1300");
                containerWidth = width / 4;
                containerHeight = height / 2.5;
              } else if (screenWidth > 1200 && screenWidth < 1300) {
                containerWidth = width / 4;
                containerHeight = height / 3;
                debugPrint("screenWidth > 1200 && screenWidth < 1300");
              } else if (screenWidth > 1000 && screenWidth < 1200) {
                containerWidth = width / 3.5;
                containerHeight = height / 3;
                debugPrint("screenWidth > 1000 && screenWidth < 1200");
              } else if (screenWidth > 800 && screenWidth < 1000) {
                containerWidth = width / 3;
                containerHeight = height / 3;
                debugPrint("screenWidth > 800 && screenWidth < 1000");
              } else if (screenWidth > 600) {
                containerWidth = width / 2.5;
                containerHeight = height / 3;
                debugPrint("screenWidth > 600 ");
              } else if (screenWidth > 500) {
                containerWidth = width / 2;
                containerHeight = height / 3;
                debugPrint("screenWidth > 500");
              } else if (screenWidth > 350) {
                containerWidth = width / 2;
                containerHeight = height / 3;
                debugPrint("screenWidth > 350");
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  GradientText(
                    "Your Uploaded Profile Picture,",
                    // AppLocalizations.of(context)!.yourUploadedPhoto,
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.w600),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.blackColor,
                        AppColors.blackColor,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  GradientText(
                    "This data will be displayed in your account profile for security,",
                    // AppLocalizations.of(context)!.proccessData,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.blackColor,
                        AppColors.blackColor,
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 240, 255, 246),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 15,
                              offset: const Offset(5, 20)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.memory(
                          fit: BoxFit.cover,
                          height: containerHeight,
                          width: containerWidth,
                          base64Decode(
                            widget.profileUrl ?? AppString.defaultImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Update Image?",
                        // AppLocalizations.of(context)!.isUploadImage,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SetLocation(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.darkGreen,
              behavior: SnackBarBehavior.floating,
              content: Text("Your Profile picture added successfully."),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: Container(
          width: width * 0.4,
          height: height * 0.06,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
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
            child: Text(
              "Next",
              // AppLocalizations.of(context)!.next,
              style: GoogleFonts.poppins(
                  color: AppColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
