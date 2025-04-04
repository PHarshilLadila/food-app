import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_sctring.dart';
import 'package:food_app/functionalities/home/model/meal_model.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/screen/item_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MainMeals extends StatelessWidget {
  const MainMeals({
    super.key,
    required this.height,
    required this.meals,
    required this.mealPrice,
    required this.nearestRestaurant,
    required this.width,
  });

  final double height;
  final List<Meals> meals;
  final List<int> mealPrice;
  final List<Map<String, dynamic>> nearestRestaurant;
  final double width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;
        int crossAxisCount = 2;
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
          crossAxisCount = 2;
          childAspectRatio = 0.65;
        } else if (screenWidth > 350) {
          crossAxisCount = 2;
          childAspectRatio = 0.60;
        }

        return GridView.builder(
          shrinkWrap: true,
          itemCount: meals.length,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetails(
                      itemDescription: AppString.mealsDescription(context),
                      itemImage: meals[index].strMealThumb ?? "",
                      itemname: meals[index].strMeal ?? "",
                      itemPrice: mealPrice[index].toDouble(),
                      itemId: meals[index].idMeal,
                      restroName: nearestRestaurant[index]['name'],
                      restroImg: nearestRestaurant[index]['image'],
                    ),
                  ),
                ),
                child: Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    return Container(
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          alignment: Alignment.topCenter,
                          colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.4), BlendMode.dstATop),
                          image: const AssetImage(
                            "assets/images/Pattern.png",
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 15,
                            offset: const Offset(5, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  meals[index].strMealThumb!,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: -10,
                                left: -6,
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      alignment: Alignment.topCenter,
                                      image: AssetImage(
                                        "assets/images/Pattern.png",
                                      ),
                                    ),
                                  ),
                                  height: height / 18,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: AutoSizeText(
                                        "\$ ${mealPrice[index].toString()}",
                                        minFontSize: 16,
                                        maxFontSize: 18,
                                        style: GoogleFonts.poppins(
                                            color: AppColors.darkGreen,
                                            fontSize: width / 19,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.toggleFavoriteStatus(
                                      meals[index].idMeal!,
                                      mealPrice[index].toString(),
                                      nearestRestaurant[index]['name'],
                                      nearestRestaurant[index]['image'],
                                    );
                                    debugPrint("${meals.length}");
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color: meals[index].isFavorite
                                          ? Colors.red
                                          : const Color.fromARGB(
                                              255, 255, 204, 204),
                                      size: 21,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height / 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: width / 2.8,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      meals[index].strMeal!,
                                      minFontSize: 18,
                                      maxFontSize: 18,
                                      style: GoogleFonts.poppins(
                                        fontSize: width / 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        nearestRestaurant[index]['image'],
                                        height: height / 35,
                                      ),
                                      SizedBox(
                                        width: width / 100,
                                      ),
                                      AutoSizeText(
                                        nearestRestaurant[index]['name'],
                                        minFontSize: 14,
                                        maxFontSize: 18,
                                        style: GoogleFonts.poppins(
                                            color: AppColors.lightGreen,
                                            fontSize: width / 35,
                                            fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
