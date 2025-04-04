// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateProfieImage extends StatefulWidget {
  const UpdateProfieImage({
    super.key,
  });

  @override
  State<UpdateProfieImage> createState() => _UpdateProfieImageState();
}

class _UpdateProfieImageState extends State<UpdateProfieImage> {
  final ImagePicker picker = ImagePicker();
  String profileImage = '';

  // @override
  // void initState() {
  //   super.initState();
  //   // Future.microtask(() {

  //   // });
  //   Provider.of<AuthProviders>(context, listen: false)
  //       .addImageProfile(profileImage);
  //   // setState(() {});
  // }

  Future getImageFromGallery() async {
    final image = await ImagePicker().pickImage(
      imageQuality: 20,
      source: ImageSource.gallery,
    );
    if (image != null) {
      final imageTemp = XFile(image.path);
      Uint8List imageBytes = await imageTemp.readAsBytes();
      String base64image = base64Encode(imageBytes);
      setState(() {
        profileImage = base64image;
        Provider.of<AuthProviders>(context, listen: false)
            .addImageProfile(profileImage);
      });
      Navigator.pop(context, profileImage);
    }
  }

  Future getImageFromCamera() async {
    final image = await ImagePicker().pickImage(
      imageQuality: 20,
      source: ImageSource.camera,
    );
    if (image != null) {
      final imageTemp = XFile(image.path);
      Uint8List imageBytes = await imageTemp.readAsBytes();
      String base64image = base64Encode(imageBytes);
      setState(() {
        profileImage = base64image;
        Provider.of<AuthProviders>(context, listen: false)
            .addImageProfile(profileImage);
      });
      Navigator.pop(context, profileImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        leading: Padding(
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
              double containerWidth = double.infinity;

              if (screenWidth > 1300) {
                debugPrint("screenWidth > 1300");
                containerWidth = height / 1.5;
              } else if (screenWidth > 1200 && screenWidth < 1300) {
                containerWidth = height / 1.5;
                debugPrint("screenWidth > 1200 && screenWidth < 1300");
              } else if (screenWidth > 1000 && screenWidth < 1200) {
                containerWidth = height / 1.5;
                debugPrint("screenWidth > 1000 && screenWidth < 1200");
                // Tablet view
              } else if (screenWidth > 800 && screenWidth < 1000) {
                containerWidth = height / 1.7;
                debugPrint("screenWidth > 800 && screenWidth < 1000");
              } else if (screenWidth > 600) {
                containerWidth = width / 1.7;
                debugPrint("screenWidth > 600 ");
              } else if (screenWidth > 500) {
                containerWidth = double.infinity;
                debugPrint("screenWidth > 500");
              } else if (screenWidth > 350) {
                containerWidth = double.infinity;
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
                    'Upload Your Photo \nProfile',
                    style: GoogleFonts.poppins(
                        fontSize: 30, fontWeight: FontWeight.bold),
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
                    'This data will be displayed in your account profile for security',
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
                    height: height * 0.03,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        getImageFromGallery();
                      },
                      child: Container(
                        width: containerWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 250, 255, 251),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 12,
                              offset: Offset(2, 5),
                              color: Color.fromARGB(255, 219, 219, 219),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/login/gallery.png",
                                height: height * 0.1,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              GradientText(
                                'From Gallery',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        getImageFromCamera();
                      },
                      child: Container(
                        width: containerWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 250, 255, 251),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 12,
                              offset: Offset(2, 5),
                              color: Color.fromARGB(255, 219, 219, 219),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 25.0),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/login/camera.png",
                                height: height * 0.1,
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              GradientText(
                                'Take Photo',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: GestureDetector(
      //   onTap: () {
      //     // Sentry.captureMessage("Press Done Button From Update Profile Image");
      //     Navigator.pop(context);
      //     Provider.of<AuthProviders>(context, listen: false)
      //         .addImageProfile(profileImage);
      //   },
      //   child: Container(
      //     width: width * 0.4,
      //     height: height * 0.06,
      //     decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(15.0),
      //       gradient: const LinearGradient(
      //         begin: Alignment(-0.95, 0.0),
      //         end: Alignment(1.0, 0.0),
      //         colors: [
      //           Color(0xff53E88B),
      //           Color(0xff15BE77),
      //         ],
      //         stops: [0.0, 1.0],
      //       ),
      //     ),
      //     child: Center(
      //       child: Text(
      //         "Done",
      //         style: GoogleFonts.poppins(
      //             color: AppColors.whiteColor,
      //             fontSize: 16,
      //             fontWeight: FontWeight.w400),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
