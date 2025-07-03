// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:food_app/constant/app_colors.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class DragNote extends StatelessWidget {
//   const DragNote({
//     super.key,
//     required this.width,
//   });

//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           FaIcon(
//             FontAwesomeIcons.infoCircle,
//             size: 14,
//           ),
//           SizedBox(
//             width: width / 80,
//           ),
//           AutoSizeText(
//             "${AppLocalizations.of(context)!.not} :",
//             minFontSize: 14,
//             maxFontSize: 14,
//             style: GoogleFonts.poppins(
//                 color: AppColors.blackColor,
//                 fontSize: width / 25,
//                 fontWeight: FontWeight.bold),
//           ),
//           Flexible(
//             child: AutoSizeText(
//               AppLocalizations.of(context)!.dragNote,
//               minFontSize: 14,
//               maxFontSize: 14,
//               style: GoogleFonts.poppins(
//                   color: AppColors.blackColor,
//                   fontSize: width / 25,
//                   fontWeight: FontWeight.w500),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:food_app/utils/theme/provider/app_theme_provider.dart';

class DragNote extends StatelessWidget {
  const DragNote({
    super.key,
    required this.width,
    this.iconSize = 14,
    this.fontSize = 14,
  });

  final double width;
  final double iconSize;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLightTheme = themeProvider.themeData.brightness == Brightness.light;
    final textColor = isLightTheme ? AppColors.blackColor : Colors.white;
    final iconColor = isLightTheme ? AppColors.blackColor : Colors.white;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(
            FontAwesomeIcons.infoCircle,
            size: iconSize,
            color: iconColor,
          ),
          SizedBox(width: width / 80),
          AutoSizeText(
            "${AppLocalizations.of(context)!.not} :",
            minFontSize: fontSize,
            maxFontSize: fontSize,
            style: GoogleFonts.poppins(
              color: textColor,
              fontSize: width / 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: AutoSizeText(
              AppLocalizations.of(context)!.dragNote,
              minFontSize: fontSize,
              maxFontSize: fontSize,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: width / 25,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
