// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/localization/provider/local_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late LocalProvider appLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appLanguage = Provider.of<LocalProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    appLanguage = Provider.of<LocalProvider>(context);

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
                  Colors.white.withOpacity(0.2), BlendMode.dstATop),
              image: const AssetImage(
                "assets/images/Pattern.png",
              ),
              fit: kIsWeb ? BoxFit.cover : BoxFit.none),
        ),
        child: Consumer<LocalProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
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
                            child: GradientText(
                              // "Update Your Setting Here",
                              AppLocalizations.of(context)!.updateProfile,
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
                        height: height / 20,
                      ),
                      GradientText(
                        // "Settings",
                        AppLocalizations.of(context)!.settings,
                        style: GoogleFonts.poppins(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.blackColor,
                            AppColors.blackColor,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height / 80,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height / 50, horizontal: width / 60),
                          child: Row(
                            children: [
                              Icon(Icons.language,
                                  size: height / 30,
                                  color: AppColors.darkGreen),
                              SizedBox(
                                width: width / 30,
                              ),
                              Text(
                                // "Languages",
                                AppLocalizations.of(context)!.languages,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 222, 255, 234),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<int>(
                                    value: appLanguage.appLocal.languageCode ==
                                            "en"
                                        ? 1
                                        : appLanguage.appLocal.languageCode ==
                                                "es"
                                            ? 2
                                            : 3,
                                    borderRadius: BorderRadius.circular(15),
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    iconSize: 20,
                                    elevation: 8,
                                    style: const TextStyle(color: Colors.black),
                                    underline: Container(
                                      decoration: const ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0)),
                                        ),
                                      ),
                                    ),
                                    items: const [
                                      DropdownMenuItem(
                                        value: 1,
                                        child: Text("English"),
                                      ),
                                      DropdownMenuItem(
                                        value: 2,
                                        child: Text("Spanish"),
                                      ),
                                      DropdownMenuItem(
                                        value: 3,
                                        child: Text("Hebrew "),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      if (value == 1) {
                                        appLanguage
                                            .changeLanguage(const Locale("en"));
                                      } else if (value == 2) {
                                        appLanguage
                                            .changeLanguage(const Locale("es"));
                                      } else if (value == 3) {
                                        appLanguage
                                            .changeLanguage(const Locale("he"));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
