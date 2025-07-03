// // ignore_for_file: deprecated_member_use

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/constant/app_colors.dart';
// import 'package:food_app/constant/app_gredient_text.dart';
// import 'package:food_app/localization/provider/local_provider.dart';
// import 'package:food_app/utils/theme/provider/app_theme_provider.dart';
// import 'package:food_app/utils/theme/widget/theme_switcher_widget.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class SettingScreen extends StatefulWidget {
//   const SettingScreen({super.key});

//   @override
//   State<SettingScreen> createState() => _SettingScreenState();
// }

// class _SettingScreenState extends State<SettingScreen> {
//   late LocalProvider appLanguage;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     appLanguage = Provider.of<LocalProvider>(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     appLanguage = Provider.of<LocalProvider>(context);
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final isLightTheme = themeProvider.themeData.brightness == Brightness.light;

//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               alignment: Alignment.topCenter,
//               colorFilter: ColorFilter.mode(
//                   Colors.white.withOpacity(0.2), BlendMode.dstATop),
//               image: const AssetImage(
//                 "assets/images/Pattern.png",
//               ),
//               fit: kIsWeb ? BoxFit.cover : BoxFit.none),
//         ),
//         child: Consumer<LocalProvider>(
//           builder: (BuildContext context, value, Widget? child) {
//             return SafeArea(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: Padding(
//                               padding: const EdgeInsets.only(right: 12),
//                               child: Container(
//                                 margin: EdgeInsets.all(2),
//                                 decoration: BoxDecoration(
//                                   color: AppColors.extraLightGreen,
//                                   borderRadius: BorderRadius.circular(15),
//                                   border: Border.all(
//                                     color: AppColors.lightGreen,
//                                     width: 0.5,
//                                   ),
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: const Icon(
//                                     Icons.arrow_back_ios_new,
//                                     color: AppColors.darkGreen,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             child: GradientText(
//                               // "Update Your Setting Here",
//                               AppLocalizations.of(context)!.updateProfile,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 30, fontWeight: FontWeight.bold),
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   AppColors.lightGreen,
//                                   AppColors.darkGreen,
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 20,
//                       ),
//                       GradientText(
//                         // "Settings",
//                         AppLocalizations.of(context)!.settings,
//                         style: GoogleFonts.poppins(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                         gradient: const LinearGradient(
//                           colors: [
//                             AppColors.blackColor,
//                             AppColors.blackColor,
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: height / 60,
//                       ),
//                       SettingListTile(
//                           height: height,
//                           width: width,
//                           isLanguageSelector: true,
//                           settingTileName:
//                               AppLocalizations.of(context)!.languages,
//                           appLanguage: appLanguage),
//                       SizedBox(
//                         height: height / 80,
//                       ),
//                       SettingListTile(
//                         height: height,
//                         width: width,
//                         settingTileName:
//                             "${AppLocalizations.of(context)!.theme} (${isLightTheme ? AppLocalizations.of(context)!.light : AppLocalizations.of(context)!.dark})",
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class SettingListTile extends StatefulWidget {
//   const SettingListTile({
//     super.key,
//     required this.height,
//     required this.width,
//     this.appLanguage,
//     this.isLanguageSelector = false,
//     required this.settingTileName,
//   });
//   final String settingTileName;
//   final double height;
//   final double width;
//   final LocalProvider? appLanguage;
//   final bool isLanguageSelector;

//   @override
//   State<SettingListTile> createState() => _SettingListTileState();
// }

// class _SettingListTileState extends State<SettingListTile> {
//   bool isLightTheme = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 255, 255, 255),
//           borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: EdgeInsets.symmetric(
//             vertical: widget.height / 50, horizontal: widget.width / 60),
//         child: Row(
//           children: [
//             Icon(Icons.language,
//                 size: widget.height / 30, color: AppColors.darkGreen),
//             SizedBox(
//               width: widget.width / 30,
//             ),
//             Text(
//               widget.settingTileName,
//               // "Languages",
//               // AppLocalizations.of(context)!.languages,
//               style: GoogleFonts.poppins(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             Spacer(),
//             widget.isLanguageSelector == true
//                 ? Container(
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 222, 255, 234),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: DropdownButton<int>(
//                         value: widget.appLanguage?.appLocal.languageCode == "en"
//                             ? 1
//                             : widget.appLanguage?.appLocal.languageCode == "es"
//                                 ? 2
//                                 : 3,
//                         borderRadius: BorderRadius.circular(15),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         iconSize: 20,
//                         elevation: 8,
//                         style: const TextStyle(color: Colors.black),
//                         underline: Container(
//                           decoration: const ShapeDecoration(
//                             shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(15.0)),
//                             ),
//                           ),
//                         ),
//                         items: const [
//                           DropdownMenuItem(
//                             value: 1,
//                             child: Text("English"),
//                           ),
//                           DropdownMenuItem(
//                             value: 2,
//                             child: Text("Spanish"),
//                           ),
//                           DropdownMenuItem(
//                             value: 3,
//                             child: Text("Hebrew "),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           if (value == 1) {
//                             widget.appLanguage
//                                 ?.changeLanguage(const Locale("en"));
//                           } else if (value == 2) {
//                             widget.appLanguage
//                                 ?.changeLanguage(const Locale("es"));
//                           } else if (value == 3) {
//                             widget.appLanguage
//                                 ?.changeLanguage(const Locale("he"));
//                           }
//                         },
//                       ),
//                     ),
//                   )
//                 : Container(
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 222, 255, 234),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: ThemeSwitcher(),

//                       // Switch(
//                       //   activeColor: Colors.green,
//                       //   value: isLightTheme,
//                       //   onChanged: (value) {
//                       //     setState(() {
//                       //       isLightTheme = value;
//                       //     });
//                       //   },
//                       // ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/localization/provider/local_provider.dart';
import 'package:food_app/utils/theme/provider/app_theme_provider.dart';
import 'package:food_app/utils/theme/widget/theme_switcher_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingListTileState extends State<SettingListTile> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkTheme = themeProvider.themeData.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          if (!isDarkTheme)
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: widget.height / 50, horizontal: widget.width / 60),
        child: Row(
          children: [
            Icon(
              widget.isLanguageSelector ? Icons.language : Icons.brightness_6,
              size: widget.height / 30,
              color: isDarkTheme ? Colors.green : AppColors.darkGreen,
            ),
            SizedBox(width: widget.width / 30),
            Text(
              widget.settingTileName,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isDarkTheme ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            widget.isLanguageSelector
                ? _buildLanguageDropdown(isDarkTheme)
                : _buildThemeSwitcher(isDarkTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme
            ? Colors.grey[700]
            : const Color.fromARGB(255, 222, 255, 234),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButton<int>(
          value: widget.appLanguage?.appLocal.languageCode == "en"
              ? 1
              : widget.appLanguage?.appLocal.languageCode == "es"
                  ? 2
                  : 3,
          borderRadius: BorderRadius.circular(15),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          iconSize: 20,
          elevation: 8,
          style: TextStyle(
            color: isDarkTheme ? Colors.white : Colors.black,
          ),
          underline: Container(),
          dropdownColor: isDarkTheme ? Colors.grey[800] : Colors.white,
          items: [
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
              child: Text("Hebrew"),
            ),
          ],
          onChanged: (value) {
            if (value == 1) {
              widget.appLanguage?.changeLanguage(const Locale("en"));
            } else if (value == 2) {
              widget.appLanguage?.changeLanguage(const Locale("es"));
            } else if (value == 3) {
              widget.appLanguage?.changeLanguage(const Locale("he"));
            }
          },
        ),
      ),
    );
  }

  Widget _buildThemeSwitcher(bool isDarkTheme) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkTheme
            ? Colors.grey[700]
            : const Color.fromARGB(255, 222, 255, 222),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: ThemeSwitcher(),
      ),
    );
  }
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkTheme = themeProvider.themeData.brightness == Brightness.dark;
    final appLanguage = Provider.of<LocalProvider>(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isDarkTheme
              ? ThemeData.dark().scaffoldBackgroundColor
              : Colors.white,
          image: DecorationImage(
            alignment: Alignment.topCenter,
            colorFilter: ColorFilter.mode(
              isDarkTheme
                  ? Colors.black.withOpacity(0.3)
                  : Colors.white.withOpacity(0.2),
              BlendMode.dstATop,
            ),
            image: const AssetImage("assets/images/Pattern.png"),
            fit: kIsWeb ? BoxFit.cover : BoxFit.none,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context, height, width, isDarkTheme),
                  SizedBox(height: height / 20),
                  _buildSettingsHeader(context, isDarkTheme),
                  SizedBox(height: height / 60),
                  SettingListTile(
                    height: height,
                    width: width,
                    isLanguageSelector: true,
                    settingTileName: AppLocalizations.of(context)!.languages,
                    appLanguage: appLanguage,
                  ),
                  SizedBox(height: height / 80),
                  SettingListTile(
                    height: height,
                    width: width,
                    settingTileName:
                        "${AppLocalizations.of(context)!.theme} (${isDarkTheme ? AppLocalizations.of(context)!.dark : AppLocalizations.of(context)!.light})",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(
      BuildContext context, double height, double width, bool isDarkTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color:
                    isDarkTheme ? Colors.grey[800] : AppColors.extraLightGreen,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isDarkTheme ? Colors.lightGreen : AppColors.lightGreen,
                  width: 0.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: isDarkTheme ? Colors.tealAccent : AppColors.darkGreen,
                ),
              ),
            ),
          ),
        ),
        Flexible(
          child: GradientText(
            AppLocalizations.of(context)!.updateProfile,
            style:
                GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
            gradient: LinearGradient(
              colors: [AppColors.lightGreen, AppColors.darkGreen],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsHeader(BuildContext context, bool isDarkTheme) {
    return GradientText(
      AppLocalizations.of(context)!.settings,
      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
      gradient: LinearGradient(
        colors: [
          isDarkTheme ? Colors.white : AppColors.blackColor,
          isDarkTheme ? Colors.white70 : AppColors.blackColor,
        ],
      ),
    );
  }
}

class SettingListTile extends StatefulWidget {
  const SettingListTile({
    super.key,
    required this.height,
    required this.width,
    this.appLanguage,
    this.isLanguageSelector = false,
    required this.settingTileName,
  });

  final String settingTileName;
  final double height;
  final double width;
  final LocalProvider? appLanguage;
  final bool isLanguageSelector;

  @override
  State<SettingListTile> createState() => _SettingListTileState();
}
