// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_sctring.dart';
import 'package:food_app/constant/app_textform_field.dart';
import 'package:food_app/functionalities/auth/providers/auth_provider.dart';
import 'package:food_app/functionalities/profile/provider/profile_provider.dart';
import 'package:food_app/functionalities/profile/screen/update_profie_image.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? profileImage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final profileProvider =
          Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.getUserData().then((_) {
        if (profileProvider.profile != null) {
          setState(() {
            nameController.text = profileProvider.profile?.name ?? '';
            emailController.text = profileProvider.profile?.email ?? '';
            fNameController.text = profileProvider.profile?.fname ?? '';
            lNameController.text = profileProvider.profile?.lname ?? '';
            mobileController.text = profileProvider.profile?.mobile ?? '';
            addressController.text = profileProvider.profile?.location ?? '';
            profileImage = profileProvider.profile?.profileImage;
          });
        }
      });
    });
  }

  Future<void> updateProfile() async {
    try {
      final authProvider = Provider.of<AuthProviders>(context, listen: false);
      await authProvider.updateName(nameController.text.trim());
      await authProvider.updateEmail(emailController.text.trim());
      await authProvider.updateFname(fNameController.text.trim());
      await authProvider.updateLname(lNameController.text.trim());
      await authProvider.updateMobile(mobileController.text.trim());
      await authProvider.updateLocation(addressController.text.trim());
      if (profileImage != null) {
        await authProvider.addImageProfile(profileImage ?? '');
      }
      await Provider.of<ProfileProvider>(context, listen: false).getUserData();
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Profile updated successfully!"),
      //     backgroundColor: AppColors.darkGreen,
      //   ),
      // );
      appTostMessage(
        context,
        ToastificationType.success,
        "Profile updated successfully!",
        "assets/images/done.png",
      );
      setState(() {});
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text("Error updating profile: ${e.toString()}"),
      //     backgroundColor: Colors.red,
      //   ),
      // );
      appTostMessage(
        context,
        ToastificationType.error,
        "Error updating profile: ${e.toString()}",
        "assets/images/wronge.png",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, value, child) {
          if (value.profile == null) {
            return Center(child: myProccesser());
          }

          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.2), BlendMode.dstATop),
                image: const AssetImage(
                  "assets/images/Pattern.png",
                ),
                fit: kIsWeb ? BoxFit.cover : BoxFit.none,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double screenWidth = constraints.maxWidth;
                      double textFieldWidth = double.infinity;

                      if (screenWidth > 1300) {
                        debugPrint("screenWidth > 1300");
                        textFieldWidth = height / 1.5;
                      } else if (screenWidth > 1200 && screenWidth < 1300) {
                        textFieldWidth = height / 1.5;
                        debugPrint("screenWidth > 1200 && screenWidth < 1300");
                      } else if (screenWidth > 1000 && screenWidth < 1200) {
                        textFieldWidth = height / 1.5;
                        debugPrint("screenWidth > 1000 && screenWidth < 1200");
                      } else if (screenWidth > 800 && screenWidth < 1000) {
                        textFieldWidth = height / 1.7;
                        debugPrint("screenWidth > 800 && screenWidth < 1000");
                      } else if (screenWidth > 600) {
                        textFieldWidth = width / 1.7;
                        debugPrint("screenWidth > 600 ");
                      } else if (screenWidth > 500) {
                        textFieldWidth = double.infinity;
                        debugPrint("screenWidth > 500");
                      } else if (screenWidth > 350) {
                        textFieldWidth = double.infinity;
                        debugPrint("screenWidth > 350");
                      }

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 5.0, bottom: 5, left: 12, right: 12),
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
                              ),
                              Flexible(
                                child: Semantics(
                                  value: "Here Your Profile",
                                  //  AppLocalizations.of(context)!
                                  //       .profileTitle,
                                  readOnly: true,
                                  label: "Profile Page Title'",
                                  header: true,
                                  hint: 'Profile Page Title',
                                  onTapHint: 'Profile Page Title',
                                  child: GradientText(
                                    "Update Your Profile Here",
                                    // AppLocalizations.of(context)!.updateProfile,
                                    // 'Find Your \nFavorite Food',
                                    style: GoogleFonts.poppins(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppColors.lightGreen,
                                        AppColors.darkGreen,
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          FutureBuilder(
                            future: Future.delayed(Duration(seconds: 2)),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.darkGreen,
                                                width: 0.5),
                                            shape: BoxShape.circle),
                                        child: ClipOval(
                                          child: SizedBox.fromSize(
                                            size: Size.fromRadius(70),
                                            child: snapshot.connectionState !=
                                                    ConnectionState.done
                                                ? myProccesser()
                                                : profileImage != null &&
                                                        profileImage!.isNotEmpty
                                                    ? Image.memory(
                                                        base64Decode(
                                                            profileImage ?? ''),
                                                        fit: BoxFit.cover)
                                                    : Image.memory(
                                                        base64Decode(AppString
                                                            .defaultImage),
                                                        fit: BoxFit.cover),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            var result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateProfieImage()),
                                            );
                                            if (result != null &&
                                                result is String) {
                                              setState(() {
                                                profileImage = result;
                                              });
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  color: AppColors.darkGreen,
                                                  width: 0.5,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color:
                                                          const Color.fromARGB(
                                                              41, 11, 199, 11),
                                                      blurRadius: 5,
                                                      offset: Offset(2, 4))
                                                ]),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                "assets/images/edit.png",
                                                height: height / 35,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "User Name",
                                // AppLocalizations.of(context)!.userName,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                  width: textFieldWidth,
                                  child: SizedBox(
                                      child: buildProfileField(
                                          "User Name", nameController))),
                              SizedBox(
                                height: height / 60,
                              ),
                              Text(
                                "Email",
                                // AppLocalizations.of(context)!.email,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                  width: textFieldWidth,
                                  child: buildProfileField(
                                      "Email", emailController)),
                              SizedBox(
                                height: height / 60,
                              ),
                              Text(
                                "First Name",
                                // AppLocalizations.of(context)!.firstName,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                  width: textFieldWidth,
                                  child: buildProfileField(
                                      "First Name", fNameController)),
                              SizedBox(
                                height: height / 60,
                              ),
                              Text(
                                "Last Name",
                                // AppLocalizations.of(context)!.lastName,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                  width: textFieldWidth,
                                  child: buildProfileField(
                                      "Last Name", lNameController)),
                              SizedBox(
                                height: height / 60,
                              ),
                              Text(
                                "Mobile Number",
                                // AppLocalizations.of(context)!.mobileNumber,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                  width: textFieldWidth,
                                  child: buildProfileField(
                                      "Mobile", mobileController)),
                              SizedBox(
                                height: height / 60,
                              ),
                              Text(
                                "Location",
                                // AppLocalizations.of(context)!.location,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                  width: textFieldWidth,
                                  child: buildProfileField(
                                      "Address", addressController)),
                            ],
                          ),
                          const SizedBox(height: 30),
                          CustomeButton(
                            heights: 50,
                            widths: textFieldWidth,
                            name: "Done",
                            ontap: updateProfile,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildProfileField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: CustomeTextFormField(
        maxline: 1,
        textEditingController: controller,
        obscureText: false,
        fillColor: Colors.white,
        borderColor: AppColors.darkGreen,
        enabledColor: AppColors.darkGreen,
        focusedColor: AppColors.darkGreen,
      ),
    );
  }
}
