// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:food_app/constant/app_colors.dart';
// import 'package:food_app/constant/app_sctring.dart';
// import 'package:food_app/functionalities/home/model/canadian_meal_model.dart';
// import 'package:food_app/functionalities/home/screen/item_details.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CanadianMeals extends StatelessWidget {
//   const CanadianMeals({
//     super.key,
//     required this.height,
//     required this.canadianMeal,
//     required this.canadianMealPrice,
//     required this.nearestRestaurant,
//     required this.width,
//   });

//   final double height;
//   final List<CanadianMealModel> canadianMeal;
//   final List<int> canadianMealPrice;
//   final List<Map<String, dynamic>> nearestRestaurant;
//   final double width;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       itemCount: canadianMeal.length,
//       physics: const NeverScrollableScrollPhysics(),
//       scrollDirection: Axis.vertical,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisSpacing: 0,
//         childAspectRatio: 0.8,
//         crossAxisCount: kIsWeb ? 6 : 2,
//       ),
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: InkWell(
//             onTap: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ItemDetails(
//                   itemDescription: AppString.mealsDescription(context),
//                   itemImage: canadianMeal[index].strMealThumb ?? "",
//                   itemname: canadianMeal[index].strMeal ?? "",
//                   itemPrice: canadianMealPrice[index],
//                   itemId: canadianMeal[index].idMeal,
//                   restroName: nearestRestaurant[index]['name'],
//                   restroImg: nearestRestaurant[index]['image'],
//                 ),
//               ),
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: AppColors.whiteColor,
//                 borderRadius: BorderRadius.circular(15),
//                 image: DecorationImage(
//                   alignment: Alignment.topCenter,
//                   colorFilter: ColorFilter.mode(
//                       Colors.white.withOpacity(0.4), BlendMode.dstATop),
//                   image: const AssetImage(
//                     "assets/images/Pattern.png",
//                   ),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade200,
//                     blurRadius: 15,
//                     offset: const Offset(5, 10),
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Stack(
//                       children: [
//                         Center(
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(15),
//                             child: Image.network(
//                               canadianMeal[index].strMealThumb!,
//                               height: 150,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: -10,
//                           left: kIsWeb ? 25 : -10,
//                           child: Container(
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white,
//                               image: DecorationImage(
//                                 alignment: Alignment.topCenter,
//                                 image: AssetImage(
//                                   "assets/images/Pattern.png",
//                                 ),
//                               ),
//                             ),
//                             height: height / 16,
//                             child: Center(
//                               child: Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: AutoSizeText(
//                                   minFontSize: 16,
//                                   maxFontSize: 18,
//                                   "\$ ${canadianMealPrice[index].toString()}",
//                                   style: GoogleFonts.poppins(
//                                       color: AppColors.darkGreen,
//                                       fontSize: width / 19,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           right: -10,
//                           top: -10,
//                           child: InkWell(
//                             overlayColor: const WidgetStatePropertyAll(
//                                 Colors.transparent),
//                             onTap: () {},
//                             child: Container(
//                               decoration: const BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: Colors.white,
//                                 image: DecorationImage(
//                                   alignment: Alignment.topCenter,
//                                   image: AssetImage(
//                                     "assets/images/Pattern.png",
//                                   ),
//                                 ),
//                               ),
//                               child: const Padding(
//                                 padding: EdgeInsets.all(12.0),
//                                 child: FaIcon(FontAwesomeIcons.solidHeart,
//                                     color: Colors.red),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: height / 60,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: SizedBox(
//                         width: width / 2,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             AutoSizeText(
//                               minFontSize: 18,
//                               maxFontSize: 18,
//                               canadianMeal[index].strMeal!,
//                               textAlign: TextAlign.start,
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.blackColor,
//                                   fontSize: width / 30,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_sctring.dart';
import 'package:food_app/functionalities/home/model/canadian_meal_model.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/screen/item_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CanadianMeals extends StatelessWidget {
  const CanadianMeals({
    super.key,
    required this.height,
    required this.canadianMeal,
    required this.canadianMealPrice,
    required this.nearestRestaurant,
    required this.width,
  });

  final double height;
  final List<CanadianMealModel> canadianMeal;
  final List<int> canadianMealPrice;
  final List<Map<String, dynamic>> nearestRestaurant;
  final double width;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
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
          itemCount: canadianMeal.length,
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
                      itemImage: canadianMeal[index].strMealThumb ?? "",
                      itemname: canadianMeal[index].strMeal ?? "",
                      itemPrice: canadianMealPrice[index].toDouble(),
                      itemId: canadianMeal[index].idMeal,
                      restroName: nearestRestaurant[index]['name'],
                      restroImg: nearestRestaurant[index]['image'],
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
                                    canadianMeal[index].strMealThumb!,
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
                                    height: height / 16,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: AutoSizeText(
                                          "\$ ${canadianMealPrice[index]}",
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
                                  right: -5,
                                  top: -23,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          value.toggleFavoriteStatus(
                                            canadianMeal[index].idMeal!,
                                            canadianMealPrice[index].toString(),
                                            nearestRestaurant[index]['name'],
                                            nearestRestaurant[index]['image'],
                                          );
                                          debugPrint("${canadianMeal.length}");
                                        },
                                        child: SizedBox(
                                          height: height / 15,
                                          child: Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.solidHeart,
                                              color:
                                                  canadianMeal[index].isFavorite
                                                      ? Colors.red
                                                      : const Color.fromARGB(
                                                          255, 255, 204, 204),
                                              size: 21,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: height / 60),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: width / 2,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      canadianMeal[index].strMeal!,
                                      textAlign: TextAlign.start,
                                      minFontSize: 16,
                                      maxFontSize: 16,
                                      style: GoogleFonts.poppins(
                                          color: AppColors.blackColor,
                                          fontSize: width / 30,
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
