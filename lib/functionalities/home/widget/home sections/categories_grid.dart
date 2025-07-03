import 'package:flutter/material.dart';
import 'package:food_app/functionalities/home/helper/list_data.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesGrid extends StatelessWidget {
  final Function(int) onCategoryTap;
  final bool isLightTheme;

  const CategoriesGrid({
    super.key,
    required this.onCategoryTap,
    required this.isLightTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 15),
          child: Text(
            "Categories",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isLightTheme ? Colors.black : Colors.white,
            ),
          ),
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double screenWidth = constraints.maxWidth;
            int crossAxisCount = 4;
            double childAspectRatio = 0.8;

            if (screenWidth > 1300) {
              crossAxisCount = 6;
              childAspectRatio = 2;
            } else if (screenWidth > 1200 && screenWidth < 1300) {
              crossAxisCount = 5;
              childAspectRatio = 2;
            } else if (screenWidth > 1000 && screenWidth < 1200) {
              crossAxisCount = 5;
              childAspectRatio = 2;
            } else if (screenWidth > 800 && screenWidth < 1000) {
              crossAxisCount = 4;
              childAspectRatio = 2;
            } else if (screenWidth > 600) {
              crossAxisCount = 3;
              childAspectRatio = 1.5;
            } else if (screenWidth > 500) {
              crossAxisCount = 3;
              childAspectRatio = 1;
            } else if (screenWidth > 350) {
              crossAxisCount = 3;
              childAspectRatio = 1;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: foodCategoriesList(context).length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: childAspectRatio,
                crossAxisCount: crossAxisCount,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => onCategoryTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isLightTheme
                          ? const Color.fromARGB(255, 238, 255, 234)
                          : const Color(0xFF333739),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(17, 0, 0, 0),
                          blurRadius: 1,
                          spreadRadius: 3,
                          offset: const Offset(2, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          foodCategoriesList(context)[index]["image"],
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            foodCategoriesList(context)[index]["name"],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: isLightTheme ? Colors.black : Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
