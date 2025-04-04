import 'package:flutter/material.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:google_fonts/google_fonts.dart';

class ThreeAvatarErrorHandler extends StatefulWidget {
  const ThreeAvatarErrorHandler({super.key});

  @override
  State<ThreeAvatarErrorHandler> createState() =>
      ThreeAvatarErrorHandler3DAvatarErrorHandlerState();
}

class ThreeAvatarErrorHandler3DAvatarErrorHandlerState
    extends State<ThreeAvatarErrorHandler> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/pagenotfound.png",
              width: 250,
              height: 250,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Oops..! Sorry 3D Avatar Only Available for Mobile Application",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          CustomeButton(
            heights: 40,
            widths: 100,
            name: "Back",
            ontap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
