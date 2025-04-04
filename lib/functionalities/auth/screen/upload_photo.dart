import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:food_app/functionalities/auth/screen/view_auth_profile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({super.key});

  @override
  State<UploadPhoto> createState() => _UploadPhotoState();
}

class _UploadPhotoState extends State<UploadPhoto> {
  final ImagePicker picker = ImagePicker();
  String profileImage = "";

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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewAuthProfile(
            profileUrl: profileImage,
          ),
        ),
      );
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ViewAuthProfile(
            profileUrl: profileImage,
          ),
        ),
      );
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
                    "Upload Your Photo Profile,", // AppLocalizations.of(context)!.uploadYourProfile,
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
                                "From Gallery",
                                // AppLocalizations.of(context)!.fromGallery,
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
                                "Take Photo",
                                // AppLocalizations.of(context)!.takePhoto,
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
    );
  }
}
