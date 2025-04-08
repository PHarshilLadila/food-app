import 'package:flutter/material.dart';
import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileDone extends StatefulWidget {
  const ProfileDone({super.key});

  @override
  State<ProfileDone> createState() => _ProfileDoneState();
}

class _ProfileDoneState extends State<ProfileDone> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFEFEFF),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              opacity: 80,
              image: AssetImage(
                "assets/images/newpattern.png",
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/login/done.png",
                height: height * 0.2,
              ),
              SizedBox(
                height: height * 0.03,
              ),
              GradientText(
                // AppLocalizations.of(context)!.congrats,
                "Congrats!",
                style: GoogleFonts.poppins(
                    fontSize: 40, fontWeight: FontWeight.w600),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.lightGreen,
                    AppColors.darkGreen,
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              GradientText(
                // AppLocalizations.of(context)!.profileReady,
                "Your Profile Is Ready To Use",
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w400),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.blackColor,
                    AppColors.blackColor,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomScreen()),
            (route) => false,
          );
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.darkGreen,
              behavior: SnackBarBehavior.floating,
              content: Text("Nice! Your Profile is Ready to Use"),
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
              // AppLocalizations.of(context)!.letsStarts,

              "Let's Start",
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
