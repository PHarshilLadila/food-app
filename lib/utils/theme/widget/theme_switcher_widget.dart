// import 'package:flutter/material.dart';
// import 'package:food_app/utils/theme/provider/app_theme_provider.dart';
// import 'package:provider/provider.dart';

// class ThemeSwitcher extends StatefulWidget {
//   const ThemeSwitcher({super.key});

//   @override
//   State<ThemeSwitcher> createState() => _ThemeSwitcherState();
// }

// class _ThemeSwitcherState extends State<ThemeSwitcher> {
//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final isLightTheme = themeProvider.themeData.brightness == Brightness.dark;

//     return Switch(
//       thumbIcon: WidgetStatePropertyAll(
//         Icon(
//           !isLightTheme ? Icons.light_mode : Icons.dark_mode,
//           color: !isLightTheme ? Colors.amber : Colors.white,
//         ),
//       ),
//       activeColor: Colors.green,
//       value: !isLightTheme,
//       onChanged: (value) {
//         themeProvider.setThemeData(
//           value ? ThemeData.light() : ThemeData.dark(),
//         );
//         setState(() {});
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/utils/theme/provider/app_theme_provider.dart';
import 'package:provider/provider.dart';

class ThemeSwitcher extends StatefulWidget {
  const ThemeSwitcher({super.key});

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkTheme = themeProvider.themeData.brightness == Brightness.dark;

    return Switch(
      thumbIcon: WidgetStatePropertyAll(
        Icon(
          isDarkTheme ? Icons.dark_mode : Icons.light_mode,
          color: isDarkTheme ? Colors.blueGrey : Colors.amber,
        ),
      ),
      activeColor: Colors.white,
      inactiveThumbColor: AppColors.darkGreen,
      activeTrackColor: Colors.lightGreen.withOpacity(0.3),
      trackOutlineColor: WidgetStatePropertyAll(Colors.green),
      inactiveTrackColor: Colors.white12,
      value: isDarkTheme,
      onChanged: (value) {
        themeProvider.setThemeData(
          value ? ThemeData.dark() : ThemeData.light(),
        );
      },
    );
  }
}
