import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/auth/screen/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:rive/rive.dart' as rive;

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var bodyStyle = GoogleFonts.poppins(fontSize: 19.0);
    var pageDecoration = PageDecoration(
      imageFlex: 2,
      imageAlignment: Alignment.bottomCenter,
      titleTextStyle:
          const TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      pageMargin: const EdgeInsets.all(30),
      imagePadding: const EdgeInsets.all(8),
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: Image.asset(
              "assets/images/splash/Logo.png",
              height: 50,
            ),
          ),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Find your  Comfort Food here",
          body:
              "Here You Can find a chef or dish for every taste and color. Enjoy!",
          image: Image.asset(
            "assets/images/onboarding/img1.png",
            height: 350,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Food Ninja is Where Your Comfort Food Lives",
          body: "Enjoy a fast and smooth food delivery at your doorstep.",
          image: Image.asset(
            "assets/images/onboarding/img2.png",
            height: 350,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Order your Favorite Food here",
          body:
              "Here You Can find a chef or dish for every taste and color. Enjoy!",
          image: const SizedBox(
            width: double.infinity,
            height: 500,
            child: rive.RiveAnimation.asset(
              "assets/rive/whiteriv.riv",
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      dotsDecorator: const DotsDecorator(activeColor: AppColors.darkGreen),
      onDone: () => _onIntroEnd(context),
      done: Container(
        width: width * 0.5,
        height: height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
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
            "Done",
            style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
      next: Container(
        width: width * 0.5,
        height: height * 0.06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
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
            style: GoogleFonts.poppins(
                color: AppColors.whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
