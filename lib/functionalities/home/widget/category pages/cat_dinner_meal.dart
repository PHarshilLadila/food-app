// ignore_for_file: use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/cart/screens/cart_screen.dart';
import 'package:food_app/functionalities/home/helper/list_data.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/screen/item_details.dart';
import 'package:food_app/functionalities/home/widget/drag_note.dart';
import 'package:food_app/functionalities/home/widget/dropped_cart_button.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CatDinnerMeal extends StatefulWidget {
  const CatDinnerMeal({super.key});

  @override
  State<CatDinnerMeal> createState() => _CatDinnerMealState();
}

class _CatDinnerMealState extends State<CatDinnerMeal> {
  bool _isDropped = false;
  Map<String, dynamic>? _droppedItem;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).loadDinnerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            colorFilter: ColorFilter.mode(
                // ignore: deprecated_member_use
                Colors.white.withOpacity(0.2),
                BlendMode.dstATop),
            image: const AssetImage(
              "assets/images/Pattern.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
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
                        // 'Dinner Menu',
                        AppLocalizations.of(context)!.dinnerMenu,
                        style: GoogleFonts.poppins(
                            fontSize: 30, fontWeight: FontWeight.bold),
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
                SizedBox(height: height / 100),
                DragNote(width: width),
                Expanded(
                  child: Consumer<HomeProvider>(
                    builder: (context, value, child) {
                      return LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
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
                            childAspectRatio = 0.75;
                          }
                          if (value.isLoading) {
                            return Center(child: myProccesser());
                          }
                          return GridView.builder(
                            padding: const EdgeInsets.all(8.0),
                            itemCount: value.dinnerMenu.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              crossAxisCount: crossAxisCount,
                              childAspectRatio: childAspectRatio,
                            ),
                            itemBuilder: (context, index) {
                              debugPrint(
                                  "this is the pizza index : ${value.dinnerMenu.length}");
                              final pizza = value.dinnerMenu[index];

                              return LongPressDraggable<Map<String, dynamic>>(
                                data: {
                                  "itemName": pizza.name,
                                  "itemPrice": pizza.rating,
                                  "itemImage": pizza.image,
                                  "itemId": pizza.id,
                                  "itemDiscription": pizza.cuisine,
                                  "itemRestro":
                                      hotCoffeeNearestRestaurant[index],
                                },
                                feedback: Material(
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.whiteColor.withOpacity(0.8),
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        alignment: Alignment.topCenter,
                                        colorFilter: ColorFilter.mode(
                                            Colors.white.withOpacity(0.4),
                                            BlendMode.dstATop),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl: value
                                                      .dinnerMenu[index].image,
                                                  height: 150,
                                                  width: 150,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    height: 150,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),

                                                //  Image.network(
                                                //   value.coffees[index].image!,
                                                //   height: 150,
                                                //   width: 150,
                                                //   fit: BoxFit.cover,
                                                // ),
                                              ),
                                              Positioned(
                                                bottom: -10,
                                                left: -6,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      image: AssetImage(
                                                        "assets/images/Pattern.png",
                                                      ),
                                                    ),
                                                  ),
                                                  height: height / 16,
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: AutoSizeText(
                                                        "\$ ${coffeePriceList[index]["price"].toString()}",
                                                        minFontSize: 16,
                                                        maxFontSize: 18,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: AppColors
                                                                    .darkGreen,
                                                                fontSize:
                                                                    width / 19,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Positioned(
                                              //   right: -5,
                                              //   top: -23,
                                              //   child: Container(
                                              //     decoration:
                                              //         const BoxDecoration(
                                              //       shape: BoxShape.circle,
                                              //       color: Colors.white,
                                              //     ),
                                              //     child: Padding(
                                              //       padding:
                                              //           const EdgeInsets.all(
                                              //               12.0),
                                              //       child: GestureDetector(
                                              //         onTap: () {
                                              //           value
                                              //               .toggleFavoriteStatus(
                                              //             value.recipes[index]
                                              //                 .id
                                              //                 .toString(),
                                              //             coffeePriceList[index]
                                              //                     ["price"]
                                              //                 .toString(),

                                              //             // value.coffees[index]
                                              //             //     .price
                                              //             //     .toString(),
                                              //             hotCoffeeNearestRestaurant[
                                              //                 index]['name'],
                                              //             hotCoffeeNearestRestaurant[
                                              //                 index]['image'],
                                              //           );
                                              //         },
                                              //         child: SizedBox(
                                              //           height: height / 15,
                                              //           child: Center(
                                              //             child: FaIcon(
                                              //               FontAwesomeIcons
                                              //                   .solidHeart,
                                              //               color: value
                                              //                       .recipes[
                                              //                           index]
                                              //                       .isFavorite
                                              //                   ? Colors.red
                                              //                   : const Color
                                              //                       .fromARGB(
                                              //                       255,
                                              //                       255,
                                              //                       204,
                                              //                       204),
                                              //               size: 21,
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(height: height / 60),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: width / 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    value
                                                        .dinnerMenu[index].name,
                                                    textAlign: TextAlign.start,
                                                    minFontSize: 16,
                                                    maxFontSize: 16,
                                                    style: GoogleFonts.poppins(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontSize: width / 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                childWhenDragging: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                      alignment: Alignment.topCenter,
                                      colorFilter: ColorFilter.mode(
                                          Colors.white.withOpacity(0.4),
                                          BlendMode.dstATop),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: CachedNetworkImage(
                                                imageUrl: value
                                                    .dinnerMenu[index].image,
                                                height: 150,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    Container(
                                                  height: 150,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),

                                              // Image.network(
                                              //   value.coffees[index].image!,
                                              //   height: 150,

                                              //   fit: BoxFit.cover,
                                              // ),
                                            ),
                                            Positioned(
                                              bottom: -10,
                                              left: -6,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  image: DecorationImage(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    image: AssetImage(
                                                      "assets/images/Pattern.png",
                                                    ),
                                                  ),
                                                ),
                                                height: height / 16,
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: AutoSizeText(
                                                      // "\$ ${coffeePriceList[index]["price"].toString()}",
                                                      "\$ ${value.dinnerMenu[index].cookTimeMinutes}",
                                                      minFontSize: 16,
                                                      maxFontSize: 18,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .darkGreen,
                                                              fontSize:
                                                                  width / 19,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Positioned(
                                            //   right: -5,
                                            //   top: -23,
                                            //   child: Container(
                                            //     decoration: const BoxDecoration(
                                            //       shape: BoxShape.circle,
                                            //       color: Colors.white,
                                            //     ),
                                            //     child: Padding(
                                            //       padding: const EdgeInsets.all(
                                            //           12.0),
                                            //       child: GestureDetector(
                                            //         onTap: () {
                                            //           value
                                            //               .toggleFavoriteStatus(
                                            //             value.coffees[index].id!
                                            //                 .toString(),
                                            //             coffeePriceList[index]
                                            //                     ["price"]
                                            //                 .toString(),
                                            //             // value.coffees[index]
                                            //             //     .price
                                            //             //     .toString(),
                                            //             hotCoffeeNearestRestaurant[
                                            //                 index]['name'],
                                            //             hotCoffeeNearestRestaurant[
                                            //                 index]['image'],
                                            //           );
                                            //           debugPrint(
                                            //               "${value.coffees.length}");
                                            //         },
                                            //         child: SizedBox(
                                            //           height: height / 15,
                                            //           child: Center(
                                            //             child: FaIcon(
                                            //               FontAwesomeIcons
                                            //                   .solidHeart,
                                            //               color: value
                                            //                       .coffees[
                                            //                           index]
                                            //                       .isFavorite
                                            //                   ? Colors.red
                                            //                   : const Color
                                            //                       .fromARGB(
                                            //                       255,
                                            //                       255,
                                            //                       204,
                                            //                       204),
                                            //               size: 21,
                                            //             ),
                                            //           ),
                                            //         ),
                                            //       ),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                        SizedBox(height: height / 60),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                            width: width / 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                AutoSizeText(
                                                  value.dinnerMenu[index].name,
                                                  textAlign: TextAlign.start,
                                                  minFontSize: 16,
                                                  maxFontSize: 16,
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                          AppColors.blackColor,
                                                      fontSize: width / 30,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ItemDetails(
                                            itemDescription:
                                                value.dinnerMenu[index].cuisine,
                                            itemImage:
                                                value.dinnerMenu[index].image,
                                            itemname:
                                                value.dinnerMenu[index].name,
                                            itemPrice:
                                                value.dinnerMenu[index].rating,

                                            // value.coffees[index].price
                                            //     ?.toDouble(),
                                            itemId: value.dinnerMenu[index].id
                                                .toString(),
                                            restroName:
                                                hotCoffeeNearestRestaurant[
                                                    index]['name'],
                                            restroImg:
                                                hotCoffeeNearestRestaurant[
                                                    index]['image'],
                                            foodCategory: "dinner"
                                            // AppLocalizations.of(context)!
                                            //     .hotCofffee,
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        alignment: Alignment.topCenter,
                                        colorFilter: ColorFilter.mode(
                                            Colors.white.withOpacity(0.4),
                                            BlendMode.dstATop),
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl: value
                                                      .dinnerMenu[index].image,
                                                  height: 150,
                                                  width: 150,
                                                  useOldImageOnUrlChange: true,
                                                  fadeInDuration: Duration.zero,
                                                  fadeOutDuration:
                                                      Duration.zero,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    height: 150,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey[300],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(
                                                    Icons.broken_image,
                                                    size: 30,
                                                  ),
                                                ),
                                                //  Image.network(
                                                //   value.coffees[index].image!,
                                                //   height: 150,
                                                //   width: 150,
                                                //   fit: BoxFit.cover,
                                                // ),
                                              ),
                                              Positioned(
                                                bottom: -10,
                                                left: -6,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      image: AssetImage(
                                                        "assets/images/Pattern.png",
                                                      ),
                                                    ),
                                                  ),
                                                  height: height / 16,
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: AutoSizeText(
                                                        "\$ ${coffeePriceList[index]["price"].toString()}",
                                                        minFontSize: 16,
                                                        maxFontSize: 18,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: AppColors
                                                                    .darkGreen,
                                                                fontSize:
                                                                    width / 19,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Positioned(
                                              //   right: -5,
                                              //   top: -23,
                                              //   child: Container(
                                              //     decoration:
                                              //         const BoxDecoration(
                                              //       shape: BoxShape.circle,
                                              //       color: Colors.white,
                                              //     ),
                                              //     child: Padding(
                                              //       padding:
                                              //           const EdgeInsets.all(
                                              //               12.0),
                                              //       child: GestureDetector(
                                              //         onTap: () {
                                              //           value
                                              //               .toggleFavoriteStatus(
                                              //             value.coffees[index]
                                              //                 .id!
                                              //                 .toString(),
                                              //             coffeePriceList[index]
                                              //                     ["price"]
                                              //                 .toString(),

                                              //             // value.coffees[index]
                                              //             //     .price
                                              //             //     .toString(),
                                              //             hotCoffeeNearestRestaurant[
                                              //                 index]['name'],
                                              //             hotCoffeeNearestRestaurant[
                                              //                 index]['image'],
                                              //           );
                                              //           debugPrint(
                                              //               "${value.coffees.length}");
                                              //         },
                                              //         child: SizedBox(
                                              //           height: height / 15,
                                              //           child: Center(
                                              //             child: FaIcon(
                                              //               FontAwesomeIcons
                                              //                   .solidHeart,
                                              //               color: value
                                              //                       .coffees[
                                              //                           index]
                                              //                       .isFavorite
                                              //                   ? Colors.red
                                              //                   : const Color
                                              //                       .fromARGB(
                                              //                       255,
                                              //                       255,
                                              //                       204,
                                              //                       204),
                                              //               size: 21,
                                              //             ),
                                              //           ),
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          SizedBox(height: height / 60),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                              width: width / 2,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  AutoSizeText(
                                                    value
                                                        .dinnerMenu[index].name,
                                                    textAlign: TextAlign.start,
                                                    minFontSize: 16,
                                                    maxFontSize: 16,
                                                    style: GoogleFonts.poppins(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontSize: width / 30,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                DragTarget<Map<String, dynamic>>(
                  onWillAccept: (data) {
                    return data != null;
                  },
                  onAccept: (data) {
                    setState(() {
                      _isDropped = true;
                      _droppedItem = data;
                    });
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     backgroundColor: AppColors.darkGreen,
                    //     content: Text('${data["itemName"]} added to cart!'),
                    //   ),
                    // );
                    appTostMessage(
                      context,
                      ToastificationType.success,
                      "${data["itemName"]} added to cart!",
                      "assets/images/done.png",
                    );
                  },
                  builder: (context, accepted, rejected) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (_droppedItem == null) {
                            appTostMessage(
                              context,
                              ToastificationType.error,
                              "Please drag and drop an item first.",
                              "assets/images/wronge.png",
                            );
                            return;
                          }
                          Provider.of<HomeProvider>(context, listen: false)
                              .addToCart(
                            _droppedItem!["itemId"].toString(),
                            _droppedItem?["itemName"],
                            _droppedItem?["itemImage"],
                            _droppedItem?["itemDiscription"],
                            (_droppedItem?["itemPrice"] is num)
                                ? (_droppedItem?["itemPrice"] as num).toDouble()
                                : double.tryParse(_droppedItem?["itemPrice"]
                                            ?.toString() ??
                                        '') ??
                                    0.0,
                            _droppedItem?["itemRestro"]["name"],
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ),
                          );
                        },
                        child: DroppedCartButton(
                          isLightTheme: true,
                          height: height,
                          width: width,
                          droppedItem: _droppedItem,
                          isDropped: _isDropped,
                        ),
                        // child: Container(
                        //   width: double.infinity,
                        //   decoration: BoxDecoration(
                        //     color: const Color.fromARGB(169, 201, 240, 201),
                        //   ),
                        //   child: DottedBorder(
                        //     borderType: BorderType.RRect,
                        //     child: Padding(
                        //       padding: EdgeInsets.symmetric(
                        //           vertical: height / 100, horizontal: 8),
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.start,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             "Add to Cart (drag & drop)",
                        //             style: GoogleFonts.poppins(
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 20,
                        //                 color: Colors.black),
                        //           ),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               AutoSizeText(
                        //                 _isDropped ? "Note " : "",
                        //                 minFontSize: 16,
                        //                 maxFontSize: 16,
                        //                 style: GoogleFonts.poppins(
                        //                     color: AppColors.blackColor,
                        //                     fontSize: width / 25,
                        //                     fontWeight: FontWeight.bold),
                        //               ),
                        //               FaIcon(
                        //                 FontAwesomeIcons.infoCircle,
                        //                 size: 14,
                        //                 color: _isDropped
                        //                     ? Colors.black
                        //                     : Color.fromARGB(255, 209, 236, 209),
                        //               ),
                        //               Flexible(
                        //                 child: AutoSizeText(
                        //                   _isDropped
                        //                       ? " : Tap Here for Add This Item in to Cart."
                        //                       : "",
                        //                   minFontSize: 14,
                        //                   maxFontSize: 14,
                        //                   style: GoogleFonts.poppins(
                        //                       color: AppColors.blackColor,
                        //                       fontWeight: FontWeight.w500),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //           SizedBox(
                        //             height: height / 100,
                        //           ),
                        //           Row(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //               Padding(
                        //                 padding: const EdgeInsets.all(8.0),
                        //                 child: ClipRRect(
                        //                   borderRadius: BorderRadius.circular(15),
                        //                   child: Image.network(
                        //                     _droppedItem?["itemImage"] ??
                        //                         "https://cdn-icons-png.flaticon.com/512/624/624826.png",
                        //                     height: height / 14,
                        //                     fit: BoxFit.cover,
                        //                   ),
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 width: width / 50,
                        //               ),
                        //               Column(
                        //                 mainAxisAlignment: MainAxisAlignment.start,
                        //                 crossAxisAlignment: CrossAxisAlignment.start,
                        //                 children: [
                        //                   Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.start,
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       Text(
                        //                         _isDropped
                        //                             ? '${_droppedItem?["itemName"] ?? ""}'
                        //                             : 'Drag and Drop Here',
                        //                         style: const TextStyle(
                        //                             fontWeight: FontWeight.bold,
                        //                             fontSize: 18,
                        //                             color: Colors.black),
                        //                       ),
                        //                       Text(
                        //                         _isDropped
                        //                             ? ' (\$ ${_droppedItem?["itemPrice"] ?? ""})'
                        //                             : '',
                        //                         style: const TextStyle(
                        //                             fontWeight: FontWeight.bold,
                        //                             fontSize: 18,
                        //                             color: Colors.green),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   SizedBox(
                        //                     height: height / 210,
                        //                   ),
                        //                   SizedBox(
                        //                     width: width / 1.5,
                        //                     child: Text(
                        //                       _isDropped
                        //                           ? '${_droppedItem?["itemDiscription"] ?? ""}'
                        //                           : ' ',
                        //                       style: const TextStyle(
                        //                           fontWeight: FontWeight.w500,
                        //                           fontSize: 16,
                        //                           color: Colors.black45),
                        //                       maxLines: 2,
                        //                       overflow: TextOverflow.ellipsis,
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
