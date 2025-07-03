import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_textform_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final VoidCallback onClear;

  const AppSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isLightTheme = Theme.of(context).brightness == Brightness.light;
    final width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Expanded(
          child: CustomeTextFormField(
            textEditingController: controller,
            onChanged: onChanged,
            obscureText: false,
            borderColor: isLightTheme
                ? const Color.fromARGB(255, 252, 255, 252)
                : const Color(0xFF232323),
            disabledColor: isLightTheme
                ? const Color.fromARGB(255, 252, 255, 252)
                : const Color(0xFF232323),
            enabledColor: isLightTheme
                ? const Color.fromARGB(255, 252, 255, 252)
                : const Color(0xFF232323),
            focusedColor: isLightTheme
                ? AppColors.darkOrange.withOpacity(1.0)
                : Colors.white70,
            hintText: AppLocalizations.of(context)!.search,
            fillColor:
                isLightTheme ? AppColors.lightOrange : const Color(0xFF333739),
            hintcolors: isLightTheme
                ? AppColors.darkOrange.withOpacity(1.0)
                : Colors.white70,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                "assets/images/home/search.png",
                height: MediaQuery.of(context).size.height / 100,
              ),
            ),
            sufixIcon: IconButton(
              onPressed: onClear,
              icon: const Icon(
                Icons.clear,
                color: AppColors.darkOrange,
              ),
            ),
          ),
        ),
        SizedBox(width: width / 30),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color:
                isLightTheme ? AppColors.lightOrange : const Color(0xFF333739),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: isLightTheme ? Colors.grey.shade100 : Colors.black12,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/images/home/Filter.png",
              height: MediaQuery.of(context).size.height / 35,
            ),
          ),
        ),
      ],
    );
  }
}
