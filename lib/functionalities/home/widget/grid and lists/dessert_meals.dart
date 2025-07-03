import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_string.dart';
import 'package:food_app/functionalities/home/model/dessert_model.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/screen/item_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DessertMeals extends StatefulWidget {
  final double height;
  final List<DessertModel> dessertMeals;
  final List<int> dessertMealPrice;
  final List<Map<String, dynamic>> nearestRestaurant;
  final double width;
  const DessertMeals(
      {super.key,
      required this.height,
      required this.dessertMeals,
      required this.dessertMealPrice,
      required this.nearestRestaurant,
      required this.width});

  @override
  State<DessertMeals> createState() => _DessertMealsState();
}

class _DessertMealsState extends State<DessertMeals> {
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
          itemCount: widget.dessertMeals.length,
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
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetails(
                      itemDescription: AppString.mealsDescription(context),
                      itemImage: widget.dessertMeals[index].image ?? "",
                      itemname: widget.dessertMeals[index].name ?? "",
                      itemPrice: widget.dessertMealPrice[
                              index % widget.dessertMealPrice.length]
                          .toDouble(),
                      itemId: widget.dessertMeals[index].id.toString(),
                      restroName: widget.nearestRestaurant[index]['name'],
                      restroImg: widget.nearestRestaurant[index]['image'],
                    ),
                  ),
                ),
                child: Consumer<HomeProvider>(
                  builder: (BuildContext context, HomeProvider value,
                      Widget? child) {
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    widget.dessertMeals[index].image ?? "",
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
                                    height: widget.height / 16,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: AutoSizeText(
                                          "\$ ${widget.dessertMealPrice[index]}",
                                          minFontSize: 16,
                                          maxFontSize: 18,
                                          style: GoogleFonts.poppins(
                                              color: AppColors.darkGreen,
                                              fontSize: widget.width / 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: -10,
                                  top: -10,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        value.toggleFavoriteStatus(
                                          value.dessertModel[index].id!
                                              .toString(),
                                          widget.dessertMealPrice[index]
                                              .toString(),
                                          widget.nearestRestaurant[index]
                                              ['name'],
                                          widget.nearestRestaurant[index]
                                              ['image'],
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: FaIcon(
                                            FontAwesomeIcons.solidHeart,
                                            color: widget.dessertMeals[index]
                                                    .isFavorite
                                                ? Colors.red
                                                : const Color.fromARGB(
                                                    255, 255, 204, 204),
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: widget.height / 60),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: widget.width / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      widget.dessertMeals[index].name!,
                                      textAlign: TextAlign.start,
                                      minFontSize: 16,
                                      maxFontSize: 16,
                                      style: GoogleFonts.poppins(
                                          color: AppColors.blackColor,
                                          fontSize: widget.width / 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
