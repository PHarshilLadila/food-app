// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ContainerButton extends StatelessWidget {
//   const ContainerButton({
//     super.key,
//     required this.height,
//     required this.width,
//     required this.onTap,
//     required this.icons,
//     required this.name,
//     required this.colors,
//   });

//   final double height;
//   final double width;
//   final IconData icons;
//   final void Function() onTap;
//   final String name;
//   final Color colors;

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 255, 255, 255),
//             borderRadius: BorderRadius.circular(15)),
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//               vertical: height / 50, horizontal: width / 60),
//           child: Row(
//             children: [
//               Icon(icons, size: height / 30, color: colors),
//               SizedBox(
//                 width: width / 30,
//               ),
//               Text(
//                 name,
//                 style: GoogleFonts.poppins(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const Spacer(),
//               Icon(
//                 CupertinoIcons.right_chevron,
//                 size: height / 50,
//                 color: Colors.green,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:food_app/utils/theme/provider/app_theme_provider.dart';
import 'package:food_app/constant/app_colors.dart';

class ContainerButton extends StatelessWidget {
  const ContainerButton({
    super.key,
    required this.height,
    required this.width,
    required this.onTap,
    required this.icons,
    required this.name,
    required this.colors,
  });

  final double height;
  final double width;
  final IconData icons;
  final void Function() onTap;
  final String name;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLightTheme = themeProvider.themeData.brightness == Brightness.light;

    final cardColor = isLightTheme
        ? const Color.fromARGB(255, 255, 255, 255)
        : const Color(0xFF333739);
    final textColor = isLightTheme ? AppColors.blackColor : Colors.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: cardColor, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: height / 50, horizontal: width / 60),
          child: Row(
            children: [
              Icon(icons, size: height / 30, color: colors),
              SizedBox(
                width: width / 30,
              ),
              Text(
                name,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              const Spacer(),
              Icon(
                CupertinoIcons.right_chevron,
                size: height / 50,
                color: Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
