import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/home/model/food_categories_model.dart';
import 'package:food_app/functionalities/home/screen/item_details.dart';
import 'package:google_fonts/google_fonts.dart';

class MealsCategories extends StatelessWidget {
  const MealsCategories({
    super.key,
    required this.height,
    required this.categories,
    required this.width,
  });

  final double height;
  final List<Category> categories;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            colorFilter: ColorFilter.mode(
                // ignore: deprecated_member_use
                Colors.white.withOpacity(0.4),
                BlendMode.dstATop),
            image: const AssetImage(
              "assets/images/Pattern.png",
            ),
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double screenWidth = constraints.maxWidth;
              int crossAxisCount = 3;
              double childAspectRatio = 0.8;

              if (screenWidth > 1300) {
                // Desktop view
                crossAxisCount = 6;
                childAspectRatio = 0.9;
              } else if (screenWidth > 1200 && screenWidth < 1300) {
                // Desktop view
                crossAxisCount = 6;
                childAspectRatio = 0.8;
              } else if (screenWidth > 1000 && screenWidth < 1200) {
                // Tablet view
                crossAxisCount = 5;
                childAspectRatio = 0.75;
              } else if (screenWidth > 800 && screenWidth < 1000) {
                crossAxisCount = 4;
                childAspectRatio = 0.7;
              } else if (screenWidth > 600) {
                crossAxisCount = 3;
                childAspectRatio = 0.85;
              } else if (screenWidth > 500) {
                crossAxisCount = 3;
                childAspectRatio = 0.65;
              } else if (screenWidth > 350) {
                crossAxisCount = 3;
                childAspectRatio = 0.78;
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
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
                          SizedBox(
                            width: width / 30,
                          ),
                          Flexible(
                            child: GradientText(
                              'Meal Categories',
                              style: GoogleFonts.poppins(
                                  fontSize: 30, fontWeight: FontWeight.w400),
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
                      SizedBox(height: height / 50),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: childAspectRatio,
                        ),
                        itemCount: categories.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 3),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemDetails(
                                    itemDescription: categories[index]
                                            .strCategoryDescription ??
                                        "",
                                    itemImage:
                                        categories[index].strCategoryThumb ??
                                            "",
                                    itemname:
                                        categories[index].strCategory ?? "",
                                    itemPrice: 15,
                                  ),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 238, 255, 234),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            const Color.fromARGB(17, 0, 0, 0),
                                        blurRadius: 1,
                                        spreadRadius: 3,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            categories[index].strCategoryThumb!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 140,
                                      ),
                                      Text(
                                        categories[index].strCategory!,
                                        style: GoogleFonts.poppins(
                                          color: AppColors.blackColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
