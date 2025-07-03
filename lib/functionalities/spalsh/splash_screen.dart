import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
import 'package:food_app/functionalities/spalsh/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String userUid = "";

  void getUserId() async {
    final databaseBox = Hive.box('userProfile');
    final id = await databaseBox.get("userid");
    debugPrint("Hive user id : $id");

    setState(() {
      userUid = id ?? "";
    });
    debugPrint("user Uid :$userUid");
  }

  @override
  void initState() {
    getUserId();
    super.initState();
    Timer(
      const Duration(seconds: 3),
      () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => userUid.isEmpty || userUid == ""
                  ? OnBoardingPage()
                  : BottomScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: kIsWeb
                ? ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop)
                : ColorFilter.mode(
                    Colors.white.withOpacity(0.6), BlendMode.dstATop),
            alignment: Alignment.topCenter,
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
              "assets/images/splash/Logo.png",
            ),
            GradientText(
              'Swift Bite',
              style:
                  GoogleFonts.viga(fontSize: 40, fontWeight: FontWeight.w400),
              gradient: const LinearGradient(
                colors: [
                  AppColors.lightGreen,
                  AppColors.darkGreen,
                ],
              ),
            ),
            Text(
              "Deliever Favorite Food",
              style:
                  GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
