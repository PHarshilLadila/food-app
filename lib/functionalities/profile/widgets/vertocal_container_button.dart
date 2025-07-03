// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class VerticalContainerButton extends StatelessWidget {
//   const VerticalContainerButton({
//     super.key,
//     required this.onTap,
//     required this.iconData,
//     required this.iconColor,
//     required this.text,
//   });

//   final void Function() onTap;
//   final IconData iconData;
//   final Color iconColor;
//   final String text;

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: height / 7,
//         width: width / 4,
//         decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 228, 227, 222),
//             borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 25),
//           child: Column(
//             children: [
//               Icon(
//                 iconData,
//                 // Icons.redeem,
//                 size: 30,
//                 color: iconColor,
//               ),
//               const SizedBox(height: 10),
//               Flexible(
//                 child: AutoSizeText(
//                   text,
//                   overflow: TextOverflow.ellipsis, maxLines: 1,
//                   minFontSize: 14, maxFontSize: 16,
//                   // " Gifts ",
//                   style: GoogleFonts.poppins(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:food_app/utils/theme/provider/app_theme_provider.dart';
import 'package:food_app/constant/app_colors.dart';

class VerticalContainerButton extends StatelessWidget {
  const VerticalContainerButton({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.iconColor,
    required this.text,
  });

  final void Function() onTap;
  final IconData iconData;
  final Color iconColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLightTheme = themeProvider.themeData.brightness == Brightness.light;

    final cardColor = isLightTheme
        ? const Color.fromARGB(255, 228, 227, 222)
        : const Color(0xFF333739);
    final textColor = isLightTheme ? AppColors.blackColor : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height / 7,
        width: width / 4,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 25),
          child: Column(
            children: [
              Icon(
                iconData,
                size: 30,
                color: iconColor,
              ),
              const SizedBox(height: 10),
              Flexible(
                child: AutoSizeText(
                  text,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  minFontSize: 14,
                  maxFontSize: 16,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
