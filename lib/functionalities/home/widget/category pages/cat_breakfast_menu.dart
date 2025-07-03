// // ignore_for_file: use_build_context_synchronously

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/constant/app_colors.dart';
// import 'package:food_app/constant/app_gredient_text.dart';
// import 'package:food_app/functionalities/cart/screens/cart_screen.dart';
// import 'package:food_app/functionalities/home/helper/list_data.dart';
// import 'package:food_app/functionalities/home/provider/home_provider.dart';
// import 'package:food_app/functionalities/home/screen/item_details.dart';
// import 'package:food_app/functionalities/home/widget/drag_note.dart';
// import 'package:food_app/functionalities/home/widget/dropped_cart_button.dart';
// import 'package:food_app/utils/utils.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:toastification/toastification.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class CatBreakFastMeal extends StatefulWidget {
//   const CatBreakFastMeal({super.key});

//   @override
//   State<CatBreakFastMeal> createState() => _CatBreakFastMealState();
// }

// class _CatBreakFastMealState extends State<CatBreakFastMeal> {
//   bool _isDropped = false;
//   Map<String, dynamic>? _droppedItem;

//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       Provider.of<HomeProvider>(context, listen: false).loadBreakFastData();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             alignment: Alignment.topCenter,
//             colorFilter: ColorFilter.mode(
//                 // ignore: deprecated_member_use
//                 Colors.white.withOpacity(0.2),
//                 BlendMode.dstATop),
//             image: const AssetImage(
//               "assets/images/Pattern.png",
//             ),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child:

//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.extraLightGreen,
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             color: AppColors.lightGreen,
//                             width: 0.5,
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: const Icon(
//                             Icons.arrow_back_ios_new,
//                             color: AppColors.darkGreen,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: width / 30,
//                     ),
//                     Flexible(
//                       child: GradientText(
//                         // 'Dinner Menu',
//                         AppLocalizations.of(context)!.breakfast,
//                         style: GoogleFonts.poppins(
//                             fontSize: 30, fontWeight: FontWeight.bold),
//                         gradient: const LinearGradient(
//                           colors: [
//                             AppColors.lightGreen,
//                             AppColors.darkGreen,
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: height / 100),
//                 DragNote(width: width),
//                 Expanded(
//                   child: Consumer<HomeProvider>(
//                     builder: (context, value, child) {
//                       return LayoutBuilder(
//                         builder:
//                             (BuildContext context, BoxConstraints constraints) {
//                           double screenWidth = constraints.maxWidth;
//                           int crossAxisCount = 2;
//                           double childAspectRatio = 0.8;

//                           if (screenWidth > 1300) {
//                             // Desktop view
//                             crossAxisCount = 6;
//                             childAspectRatio = 0.9;
//                           } else if (screenWidth > 1200 && screenWidth < 1300) {
//                             // Desktop view
//                             crossAxisCount = 6;
//                             childAspectRatio = 0.8;
//                           } else if (screenWidth > 1000 && screenWidth < 1200) {
//                             // Tablet view
//                             crossAxisCount = 5;
//                             childAspectRatio = 0.75;
//                           } else if (screenWidth > 800 && screenWidth < 1000) {
//                             crossAxisCount = 4;
//                             childAspectRatio = 0.7;
//                           } else if (screenWidth > 600) {
//                             crossAxisCount = 3;
//                             childAspectRatio = 0.85;
//                           } else if (screenWidth > 500) {
//                             crossAxisCount = 2;
//                             childAspectRatio = 0.65;
//                           } else if (screenWidth > 350) {
//                             crossAxisCount = 2;
//                             childAspectRatio = 0.75;
//                           }
//                           return GridView.builder(
//                             padding: const EdgeInsets.all(8.0),
//                             itemCount: value.breakfastMenu.length,
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               mainAxisSpacing: 8,
//                               crossAxisSpacing: 8,
//                               crossAxisCount: crossAxisCount,
//                               childAspectRatio: childAspectRatio,
//                             ),
//                             itemBuilder: (context, index) {
//                               debugPrint(
//                                   "this is the pizza index : ${value.breakfastMenu.length}");
//                               final pizza = value.breakfastMenu[index];

//                               return LongPressDraggable<Map<String, dynamic>>(
//                                 data: {
//                                   "itemName": pizza.name,
//                                   "itemPrice": coffeePriceList[index]["price"]
//                                       .toString(),
//                                   "itemImage": pizza.image,
//                                   "itemId": pizza.id,
//                                   "itemDiscription": pizza.cuisine,
//                                   "itemRestro":
//                                       hotCoffeeNearestRestaurant[index],
//                                 },
//                                 feedback: Material(
//                                   color: Colors.transparent,
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color:
//                                           AppColors.whiteColor.withOpacity(0.8),
//                                       borderRadius: BorderRadius.circular(15),
//                                       image: DecorationImage(
//                                         alignment: Alignment.topCenter,
//                                         colorFilter: ColorFilter.mode(
//                                             Colors.white.withOpacity(0.4),
//                                             BlendMode.dstATop),
//                                         image: const AssetImage(
//                                           "assets/images/Pattern.png",
//                                         ),
//                                       ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.shade200,
//                                           blurRadius: 15,
//                                           offset: const Offset(5, 10),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Stack(
//                                             children: [
//                                               ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 child: CachedNetworkImage(
//                                                   imageUrl: value
//                                                       .breakfastMenu[index]
//                                                       .image,
//                                                   height: 150,
//                                                   width: 150,
//                                                   fit: BoxFit.cover,
//                                                   placeholder: (context, url) =>
//                                                       Container(
//                                                     height: 150,
//                                                     width: 150,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.grey[300],
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15),
//                                                     ),
//                                                   ),
//                                                   errorWidget:
//                                                       (context, url, error) =>
//                                                           Icon(Icons.error),
//                                                 ),

//                                                 //  Image.network(
//                                                 //   value.coffees[index].image!,
//                                                 //   height: 150,
//                                                 //   width: 150,
//                                                 //   fit: BoxFit.cover,
//                                                 // ),
//                                               ),
//                                               Positioned(
//                                                 bottom: -10,
//                                                 left: -6,
//                                                 child: Container(
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color: Colors.white,
//                                                     image: DecorationImage(
//                                                       alignment:
//                                                           Alignment.topCenter,
//                                                       image: AssetImage(
//                                                         "assets/images/Pattern.png",
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   height: height / 16,
//                                                   child: Center(
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               10.0),
//                                                       child: AutoSizeText(
//                                                         "\$ ${coffeePriceList[index]["price"].toString()}",
//                                                         minFontSize: 16,
//                                                         maxFontSize: 18,
//                                                         style:
//                                                             GoogleFonts.poppins(
//                                                                 color: AppColors
//                                                                     .darkGreen,
//                                                                 fontSize:
//                                                                     width / 19,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               // Positioned(
//                                               //   right: -5,
//                                               //   top: -23,
//                                               //   child: Container(
//                                               //     decoration:
//                                               //         const BoxDecoration(
//                                               //       shape: BoxShape.circle,
//                                               //       color: Colors.white,
//                                               //     ),
//                                               //     child: Padding(
//                                               //       padding:
//                                               //           const EdgeInsets.all(
//                                               //               12.0),
//                                               //       child: GestureDetector(
//                                               //         onTap: () {
//                                               //           value
//                                               //               .toggleFavoriteStatus(
//                                               //             value.recipes[index]
//                                               //                 .id
//                                               //                 .toString(),
//                                               //             coffeePriceList[index]
//                                               //                     ["price"]
//                                               //                 .toString(),

//                                               //             // value.coffees[index]
//                                               //             //     .price
//                                               //             //     .toString(),
//                                               //             hotCoffeeNearestRestaurant[
//                                               //                 index]['name'],
//                                               //             hotCoffeeNearestRestaurant[
//                                               //                 index]['image'],
//                                               //           );
//                                               //         },
//                                               //         child: SizedBox(
//                                               //           height: height / 15,
//                                               //           child: Center(
//                                               //             child: FaIcon(
//                                               //               FontAwesomeIcons
//                                               //                   .solidHeart,
//                                               //               color: value
//                                               //                       .recipes[
//                                               //                           index]
//                                               //                       .isFavorite
//                                               //                   ? Colors.red
//                                               //                   : const Color
//                                               //                       .fromARGB(
//                                               //                       255,
//                                               //                       255,
//                                               //                       204,
//                                               //                       204),
//                                               //               size: 21,
//                                               //             ),
//                                               //           ),
//                                               //         ),
//                                               //       ),
//                                               //     ),
//                                               //   ),
//                                               // ),
//                                             ],
//                                           ),
//                                           SizedBox(height: height / 60),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: SizedBox(
//                                               width: width / 2,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   AutoSizeText(
//                                                     value.breakfastMenu[index]
//                                                         .name,
//                                                     textAlign: TextAlign.start,
//                                                     minFontSize: 16,
//                                                     maxFontSize: 16,
//                                                     style: GoogleFonts.poppins(
//                                                         color: AppColors
//                                                             .blackColor,
//                                                         fontSize: width / 30,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 childWhenDragging: Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColors.whiteColor,
//                                     borderRadius: BorderRadius.circular(15),
//                                     image: DecorationImage(
//                                       alignment: Alignment.topCenter,
//                                       colorFilter: ColorFilter.mode(
//                                           Colors.white.withOpacity(0.4),
//                                           BlendMode.dstATop),
//                                       image: const AssetImage(
//                                         "assets/images/Pattern.png",
//                                       ),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.shade200,
//                                         blurRadius: 15,
//                                         offset: const Offset(5, 10),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Stack(
//                                           children: [
//                                             ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(15),
//                                               child: CachedNetworkImage(
//                                                 imageUrl: value
//                                                     .breakfastMenu[index].image,
//                                                 height: 150,
//                                                 fit: BoxFit.cover,
//                                                 placeholder: (context, url) =>
//                                                     Container(
//                                                   height: 150,
//                                                   width: 150,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.grey[300],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             15),
//                                                   ),
//                                                 ),
//                                                 errorWidget:
//                                                     (context, url, error) =>
//                                                         Icon(Icons.error),
//                                               ),

//                                               // Image.network(
//                                               //   value.coffees[index].image!,
//                                               //   height: 150,

//                                               //   fit: BoxFit.cover,
//                                               // ),
//                                             ),
//                                             Positioned(
//                                               bottom: -10,
//                                               left: -6,
//                                               child: Container(
//                                                 decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: Colors.white,
//                                                   image: DecorationImage(
//                                                     alignment:
//                                                         Alignment.topCenter,
//                                                     image: AssetImage(
//                                                       "assets/images/Pattern.png",
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 height: height / 16,
//                                                 child: Center(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             10.0),
//                                                     child: AutoSizeText(
//                                                       // "\$ ${coffeePriceList[index]["price"].toString()}",
//                                                       "\$ ${value.breakfastMenu[index].cookTimeMinutes}",
//                                                       minFontSize: 16,
//                                                       maxFontSize: 18,
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                               color: AppColors
//                                                                   .darkGreen,
//                                                               fontSize:
//                                                                   width / 19,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             // Positioned(
//                                             //   right: -5,
//                                             //   top: -23,
//                                             //   child: Container(
//                                             //     decoration: const BoxDecoration(
//                                             //       shape: BoxShape.circle,
//                                             //       color: Colors.white,
//                                             //     ),
//                                             //     child: Padding(
//                                             //       padding: const EdgeInsets.all(
//                                             //           12.0),
//                                             //       child: GestureDetector(
//                                             //         onTap: () {
//                                             //           value
//                                             //               .toggleFavoriteStatus(
//                                             //             value.coffees[index].id!
//                                             //                 .toString(),
//                                             //             coffeePriceList[index]
//                                             //                     ["price"]
//                                             //                 .toString(),
//                                             //             // value.coffees[index]
//                                             //             //     .price
//                                             //             //     .toString(),
//                                             //             hotCoffeeNearestRestaurant[
//                                             //                 index]['name'],
//                                             //             hotCoffeeNearestRestaurant[
//                                             //                 index]['image'],
//                                             //           );
//                                             //           debugPrint(
//                                             //               "${value.coffees.length}");
//                                             //         },
//                                             //         child: SizedBox(
//                                             //           height: height / 15,
//                                             //           child: Center(
//                                             //             child: FaIcon(
//                                             //               FontAwesomeIcons
//                                             //                   .solidHeart,
//                                             //               color: value
//                                             //                       .coffees[
//                                             //                           index]
//                                             //                       .isFavorite
//                                             //                   ? Colors.red
//                                             //                   : const Color
//                                             //                       .fromARGB(
//                                             //                       255,
//                                             //                       255,
//                                             //                       204,
//                                             //                       204),
//                                             //               size: 21,
//                                             //             ),
//                                             //           ),
//                                             //         ),
//                                             //       ),
//                                             //     ),
//                                             //   ),
//                                             // ),
//                                           ],
//                                         ),
//                                         SizedBox(height: height / 60),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: SizedBox(
//                                             width: width / 2,
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 AutoSizeText(
//                                                   value.breakfastMenu[index]
//                                                       .name,
//                                                   textAlign: TextAlign.start,
//                                                   minFontSize: 16,
//                                                   maxFontSize: 16,
//                                                   style: GoogleFonts.poppins(
//                                                       color:
//                                                           AppColors.blackColor,
//                                                       fontSize: width / 30,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 child: GestureDetector(
//                                   onTap: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => ItemDetails(
//                                             itemDescription: value
//                                                 .breakfastMenu[index].cuisine,
//                                             itemImage: value
//                                                 .breakfastMenu[index].image,
//                                             itemname:
//                                                 value.breakfastMenu[index].name,
//                                             itemPrice: value
//                                                 .breakfastMenu[index].rating,

//                                             // value.coffees[index].price
//                                             //     ?.toDouble(),
//                                             itemId: value
//                                                 .breakfastMenu[index].id
//                                                 .toString(),
//                                             restroName:
//                                                 hotCoffeeNearestRestaurant[
//                                                     index]['name'],
//                                             restroImg:
//                                                 hotCoffeeNearestRestaurant[
//                                                     index]['image'],
//                                             foodCategory: "breakfast"
//                                             // AppLocalizations.of(context)!
//                                             //     .hotCofffee,
//                                             ),
//                                       ),
//                                     );
//                                   },
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: AppColors.whiteColor,
//                                       borderRadius: BorderRadius.circular(15),
//                                       image: DecorationImage(
//                                         alignment: Alignment.topCenter,
//                                         colorFilter: ColorFilter.mode(
//                                             Colors.white.withOpacity(0.4),
//                                             BlendMode.dstATop),
//                                         image: const AssetImage(
//                                           "assets/images/Pattern.png",
//                                         ),
//                                       ),
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.shade200,
//                                           blurRadius: 15,
//                                           offset: const Offset(5, 10),
//                                         ),
//                                       ],
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Stack(
//                                             children: [
//                                               ClipRRect(
//                                                 borderRadius:
//                                                     BorderRadius.circular(15),
//                                                 child: CachedNetworkImage(
//                                                   imageUrl: value
//                                                       .breakfastMenu[index]
//                                                       .image,
//                                                   height: 150,
//                                                   width: 150,
//                                                   useOldImageOnUrlChange: true,
//                                                   fadeInDuration: Duration.zero,
//                                                   fadeOutDuration:
//                                                       Duration.zero,
//                                                   fit: BoxFit.cover,
//                                                   placeholder: (context, url) =>
//                                                       Container(
//                                                     height: 150,
//                                                     width: 150,
//                                                     decoration: BoxDecoration(
//                                                       color: Colors.grey[300],
//                                                       borderRadius:
//                                                           BorderRadius.circular(
//                                                               15),
//                                                     ),
//                                                   ),
//                                                   errorWidget:
//                                                       (context, url, error) =>
//                                                           Icon(
//                                                     Icons.broken_image,
//                                                     size: 30,
//                                                   ),
//                                                 ),
//                                                 //  Image.network(
//                                                 //   value.coffees[index].image!,
//                                                 //   height: 150,
//                                                 //   width: 150,
//                                                 //   fit: BoxFit.cover,
//                                                 // ),
//                                               ),
//                                               Positioned(
//                                                 bottom: -10,
//                                                 left: -6,
//                                                 child: Container(
//                                                   decoration:
//                                                       const BoxDecoration(
//                                                     shape: BoxShape.circle,
//                                                     color: Colors.white,
//                                                     image: DecorationImage(
//                                                       alignment:
//                                                           Alignment.topCenter,
//                                                       image: AssetImage(
//                                                         "assets/images/Pattern.png",
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   height: height / 16,
//                                                   child: Center(
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               10.0),
//                                                       child: AutoSizeText(
//                                                         "\$ ${coffeePriceList[index]["price"].toString()}",
//                                                         minFontSize: 16,
//                                                         maxFontSize: 18,
//                                                         style:
//                                                             GoogleFonts.poppins(
//                                                                 color: AppColors
//                                                                     .darkGreen,
//                                                                 fontSize:
//                                                                     width / 19,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               // Positioned(
//                                               //   right: -5,
//                                               //   top: -23,
//                                               //   child: Container(
//                                               //     decoration:
//                                               //         const BoxDecoration(
//                                               //       shape: BoxShape.circle,
//                                               //       color: Colors.white,
//                                               //     ),
//                                               //     child: Padding(
//                                               //       padding:
//                                               //           const EdgeInsets.all(
//                                               //               12.0),
//                                               //       child: GestureDetector(
//                                               //         onTap: () {
//                                               //           value
//                                               //               .toggleFavoriteStatus(
//                                               //             value.coffees[index]
//                                               //                 .id!
//                                               //                 .toString(),
//                                               //             coffeePriceList[index]
//                                               //                     ["price"]
//                                               //                 .toString(),

//                                               //             // value.coffees[index]
//                                               //             //     .price
//                                               //             //     .toString(),
//                                               //             hotCoffeeNearestRestaurant[
//                                               //                 index]['name'],
//                                               //             hotCoffeeNearestRestaurant[
//                                               //                 index]['image'],
//                                               //           );
//                                               //           debugPrint(
//                                               //               "${value.coffees.length}");
//                                               //         },
//                                               //         child: SizedBox(
//                                               //           height: height / 15,
//                                               //           child: Center(
//                                               //             child: FaIcon(
//                                               //               FontAwesomeIcons
//                                               //                   .solidHeart,
//                                               //               color: value
//                                               //                       .coffees[
//                                               //                           index]
//                                               //                       .isFavorite
//                                               //                   ? Colors.red
//                                               //                   : const Color
//                                               //                       .fromARGB(
//                                               //                       255,
//                                               //                       255,
//                                               //                       204,
//                                               //                       204),
//                                               //               size: 21,
//                                               //             ),
//                                               //           ),
//                                               //         ),
//                                               //       ),
//                                               //     ),
//                                               //   ),
//                                               // ),
//                                             ],
//                                           ),
//                                           SizedBox(height: height / 60),
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: SizedBox(
//                                               width: width / 2,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   AutoSizeText(
//                                                     value.breakfastMenu[index]
//                                                         .name,
//                                                     textAlign: TextAlign.start,
//                                                     minFontSize: 16,
//                                                     maxFontSize: 16,
//                                                     style: GoogleFonts.poppins(
//                                                         color: AppColors
//                                                             .blackColor,
//                                                         fontSize: width / 30,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 DragTarget<Map<String, dynamic>>(
//                   onWillAccept: (data) {
//                     return data != null;
//                   },
//                   onAccept: (data) {
//                     setState(() {
//                       _isDropped = true;
//                       _droppedItem = data;
//                     });
//                     // ScaffoldMessenger.of(context).showSnackBar(
//                     //   SnackBar(
//                     //     backgroundColor: AppColors.darkGreen,
//                     //     content: Text('${data["itemName"]} added to cart!'),
//                     //   ),
//                     // );
//                     appTostMessage(
//                       context,
//                       ToastificationType.success,
//                       "${data["itemName"]} added to cart!",
//                       "assets/images/done.png",
//                     );
//                   },
//                   builder: (context, accepted, rejected) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           if (_droppedItem == null) {
//                             appTostMessage(
//                               context,
//                               ToastificationType.error,
//                               "Please drag and drop an item first.",
//                               "assets/images/wronge.png",
//                             );
//                             return;
//                           }
//                           Provider.of<HomeProvider>(context, listen: false)
//                               .addToCart(
//                             _droppedItem!["itemId"].toString(),
//                             _droppedItem?["itemName"],
//                             _droppedItem?["itemImage"],
//                             _droppedItem?["itemDiscription"],
//                             (_droppedItem?["itemPrice"] is num)
//                                 ? (_droppedItem?["itemPrice"] as num).toDouble()
//                                 : double.tryParse(_droppedItem?["itemPrice"]
//                                             ?.toString() ??
//                                         '') ??
//                                     0.0,
//                             _droppedItem?["itemRestro"]["name"],
//                           );

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => CartScreen(),
//                             ),
//                           );
//                         },
//                         child: DroppedCartButton(
//                           height: height,
//                           width: width,
//                           droppedItem: _droppedItem,
//                           isDropped: _isDropped,
//                         ),
//                         // child: Container(
//                         //   width: double.infinity,
//                         //   decoration: BoxDecoration(
//                         //     color: const Color.fromARGB(169, 201, 240, 201),
//                         //   ),
//                         //   child: DottedBorder(
//                         //     borderType: BorderType.RRect,
//                         //     child: Padding(
//                         //       padding: EdgeInsets.symmetric(
//                         //           vertical: height / 100, horizontal: 8),
//                         //       child: Column(
//                         //         mainAxisAlignment: MainAxisAlignment.start,
//                         //         crossAxisAlignment: CrossAxisAlignment.start,
//                         //         children: [
//                         //           Text(
//                         //             "Add to Cart (drag & drop)",
//                         //             style: GoogleFonts.poppins(
//                         //                 fontWeight: FontWeight.bold,
//                         //                 fontSize: 20,
//                         //                 color: Colors.black),
//                         //           ),
//                         //           Row(
//                         //             mainAxisAlignment: MainAxisAlignment.start,
//                         //             crossAxisAlignment: CrossAxisAlignment.center,
//                         //             children: [
//                         //               AutoSizeText(
//                         //                 _isDropped ? "Note " : "",
//                         //                 minFontSize: 16,
//                         //                 maxFontSize: 16,
//                         //                 style: GoogleFonts.poppins(
//                         //                     color: AppColors.blackColor,
//                         //                     fontSize: width / 25,
//                         //                     fontWeight: FontWeight.bold),
//                         //               ),
//                         //               FaIcon(
//                         //                 FontAwesomeIcons.infoCircle,
//                         //                 size: 14,
//                         //                 color: _isDropped
//                         //                     ? Colors.black
//                         //                     : Color.fromARGB(255, 209, 236, 209),
//                         //               ),
//                         //               Flexible(
//                         //                 child: AutoSizeText(
//                         //                   _isDropped
//                         //                       ? " : Tap Here for Add This Item in to Cart."
//                         //                       : "",
//                         //                   minFontSize: 14,
//                         //                   maxFontSize: 14,
//                         //                   style: GoogleFonts.poppins(
//                         //                       color: AppColors.blackColor,
//                         //                       fontWeight: FontWeight.w500),
//                         //                 ),
//                         //               ),
//                         //             ],
//                         //           ),
//                         //           SizedBox(
//                         //             height: height / 100,
//                         //           ),
//                         //           Row(
//                         //             mainAxisAlignment: MainAxisAlignment.start,
//                         //             crossAxisAlignment: CrossAxisAlignment.center,
//                         //             children: [
//                         //               Padding(
//                         //                 padding: const EdgeInsets.all(8.0),
//                         //                 child: ClipRRect(
//                         //                   borderRadius: BorderRadius.circular(15),
//                         //                   child: Image.network(
//                         //                     _droppedItem?["itemImage"] ??
//                         //                         "https://cdn-icons-png.flaticon.com/512/624/624826.png",
//                         //                     height: height / 14,
//                         //                     fit: BoxFit.cover,
//                         //                   ),
//                         //                 ),
//                         //               ),
//                         //               SizedBox(
//                         //                 width: width / 50,
//                         //               ),
//                         //               Column(
//                         //                 mainAxisAlignment: MainAxisAlignment.start,
//                         //                 crossAxisAlignment: CrossAxisAlignment.start,
//                         //                 children: [
//                         //                   Row(
//                         //                     mainAxisAlignment:
//                         //                         MainAxisAlignment.start,
//                         //                     crossAxisAlignment:
//                         //                         CrossAxisAlignment.start,
//                         //                     children: [
//                         //                       Text(
//                         //                         _isDropped
//                         //                             ? '${_droppedItem?["itemName"] ?? ""}'
//                         //                             : 'Drag and Drop Here',
//                         //                         style: const TextStyle(
//                         //                             fontWeight: FontWeight.bold,
//                         //                             fontSize: 18,
//                         //                             color: Colors.black),
//                         //                       ),
//                         //                       Text(
//                         //                         _isDropped
//                         //                             ? ' (\$ ${_droppedItem?["itemPrice"] ?? ""})'
//                         //                             : '',
//                         //                         style: const TextStyle(
//                         //                             fontWeight: FontWeight.bold,
//                         //                             fontSize: 18,
//                         //                             color: Colors.green),
//                         //                       ),
//                         //                     ],
//                         //                   ),
//                         //                   SizedBox(
//                         //                     height: height / 210,
//                         //                   ),
//                         //                   SizedBox(
//                         //                     width: width / 1.5,
//                         //                     child: Text(
//                         //                       _isDropped
//                         //                           ? '${_droppedItem?["itemDiscription"] ?? ""}'
//                         //                           : ' ',
//                         //                       style: const TextStyle(
//                         //                           fontWeight: FontWeight.w500,
//                         //                           fontSize: 16,
//                         //                           color: Colors.black45),
//                         //                       maxLines: 2,
//                         //                       overflow: TextOverflow.ellipsis,
//                         //                     ),
//                         //                   ),
//                         //                 ],
//                         //               ),
//                         //             ],
//                         //           ),
//                         //         ],
//                         //       ),
//                         //     ),
//                         //   ),
//                         // ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
// ignore_for_file: use_build_context_synchronously

// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/constant/app_colors.dart';
// import 'package:food_app/constant/app_gredient_text.dart';
// import 'package:food_app/functionalities/cart/screens/cart_screen.dart';
// import 'package:food_app/functionalities/home/helper/list_data.dart';
// import 'package:food_app/functionalities/home/provider/home_provider.dart';
// import 'package:food_app/functionalities/home/screen/item_details.dart';
// import 'package:food_app/functionalities/home/widget/drag_note.dart';
// import 'package:food_app/functionalities/home/widget/dropped_cart_button.dart';
// import 'package:food_app/utils/utils.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:toastification/toastification.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class CatBreakFastMeal extends StatefulWidget {
//   const CatBreakFastMeal({super.key});

//   @override
//   State<CatBreakFastMeal> createState() => _CatBreakFastMealState();
// }

// class _CatBreakFastMealState extends State<CatBreakFastMeal> {
//   bool _isDropped = false;
//   Map<String, dynamic>? _droppedItem;

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() async {
//       final homeProvider = Provider.of<HomeProvider>(context, listen: false);
//       homeProvider.isLoading = true;
//       await homeProvider.loadBreakFastData();
//       homeProvider.isLoading = false;
//       homeProvider.notifyListeners();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             alignment: Alignment.topCenter,
//             colorFilter: ColorFilter.mode(
//                 // ignore: deprecated_member_use
//                 Colors.white.withOpacity(0.2),
//                 BlendMode.dstATop),
//             image: const AssetImage(
//               "assets/images/Pattern.png",
//             ),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: AppColors.extraLightGreen,
//                           borderRadius: BorderRadius.circular(15),
//                           border: Border.all(
//                             color: AppColors.lightGreen,
//                             width: 0.5,
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: const Icon(
//                             Icons.arrow_back_ios_new,
//                             color: AppColors.darkGreen,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: width / 30,
//                     ),
//                     Flexible(
//                       child: GradientText(
//                         // 'Dinner Menu',
//                         AppLocalizations.of(context)!.breakfast,
//                         style: GoogleFonts.poppins(
//                             fontSize: 30, fontWeight: FontWeight.bold),
//                         gradient: const LinearGradient(
//                           colors: [
//                             AppColors.lightGreen,
//                             AppColors.darkGreen,
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: height / 100),
//                 DragNote(width: width),
//                 Expanded(
//                   child:
//                       Consumer<HomeProvider>(builder: (context, value, child) {
//                     if (value.isLoading) {
//                       return Center(child: myProccesser());
//                     }
//                     return LayoutBuilder(
//                       builder:
//                           (BuildContext context, BoxConstraints constraints) {
//                         double screenWidth = constraints.maxWidth;
//                         int crossAxisCount = 2;
//                         double childAspectRatio = 0.8;

//                         if (screenWidth > 1300) {
//                           // Desktop view
//                           crossAxisCount = 6;
//                           childAspectRatio = 0.9;
//                         } else if (screenWidth > 1200 && screenWidth < 1300) {
//                           // Desktop view
//                           crossAxisCount = 6;
//                           childAspectRatio = 0.8;
//                         } else if (screenWidth > 1000 && screenWidth < 1200) {
//                           // Tablet view
//                           crossAxisCount = 5;
//                           childAspectRatio = 0.75;
//                         } else if (screenWidth > 800 && screenWidth < 1000) {
//                           crossAxisCount = 4;
//                           childAspectRatio = 0.7;
//                         } else if (screenWidth > 600) {
//                           crossAxisCount = 3;
//                           childAspectRatio = 0.85;
//                         } else if (screenWidth > 500) {
//                           crossAxisCount = 2;
//                           childAspectRatio = 0.65;
//                         } else if (screenWidth > 350) {
//                           crossAxisCount = 2;
//                           childAspectRatio = 0.75;
//                         }
//                         return GridView.builder(
//                           padding: const EdgeInsets.all(8.0),
//                           itemCount: value.breakfastMenu.length,
//                           gridDelegate:
//                               SliverGridDelegateWithFixedCrossAxisCount(
//                             mainAxisSpacing: 8,
//                             crossAxisSpacing: 8,
//                             crossAxisCount: crossAxisCount,
//                             childAspectRatio: childAspectRatio,
//                           ),
//                           itemBuilder: (context, index) {
//                             debugPrint(
//                                 "this is the pizza index : ${value.breakfastMenu.length}");
//                             final pizza = value.breakfastMenu[index];

//                             return LongPressDraggable<Map<String, dynamic>>(
//                               data: {
//                                 "itemName": pizza.name,
//                                 "itemPrice":
//                                     coffeePriceList[index]["price"].toString(),
//                                 "itemImage": pizza.image,
//                                 "itemId": pizza.id,
//                                 "itemDiscription": pizza.cuisine,
//                                 "itemRestro": hotCoffeeNearestRestaurant[index],
//                               },
//                               feedback: Material(
//                                 color: Colors.transparent,
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color:
//                                         AppColors.whiteColor.withOpacity(0.8),
//                                     borderRadius: BorderRadius.circular(15),
//                                     image: DecorationImage(
//                                       alignment: Alignment.topCenter,
//                                       colorFilter: ColorFilter.mode(
//                                           Colors.white.withOpacity(0.4),
//                                           BlendMode.dstATop),
//                                       image: const AssetImage(
//                                         "assets/images/Pattern.png",
//                                       ),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.shade200,
//                                         blurRadius: 15,
//                                         offset: const Offset(5, 10),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Stack(
//                                           children: [
//                                             ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(15),
//                                               child: CachedNetworkImage(
//                                                 imageUrl: value
//                                                     .breakfastMenu[index].image,
//                                                 height: 150,
//                                                 width: 150,
//                                                 fit: BoxFit.cover,
//                                                 placeholder: (context, url) =>
//                                                     Container(
//                                                   height: 150,
//                                                   width: 150,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.grey[300],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             15),
//                                                   ),
//                                                 ),
//                                                 errorWidget:
//                                                     (context, url, error) =>
//                                                         Icon(Icons.error),
//                                               ),
//                                             ),
//                                             Positioned(
//                                               bottom: -10,
//                                               left: -6,
//                                               child: Container(
//                                                 decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: Colors.white,
//                                                   image: DecorationImage(
//                                                     alignment:
//                                                         Alignment.topCenter,
//                                                     image: AssetImage(
//                                                       "assets/images/Pattern.png",
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 height: height / 16,
//                                                 child: Center(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             10.0),
//                                                     child: AutoSizeText(
//                                                       "\$ ${coffeePriceList[index]["price"].toString()}",
//                                                       minFontSize: 16,
//                                                       maxFontSize: 18,
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                               color: AppColors
//                                                                   .darkGreen,
//                                                               fontSize:
//                                                                   width / 19,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: height / 60),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: SizedBox(
//                                             width: width / 2,
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 AutoSizeText(
//                                                   value.breakfastMenu[index]
//                                                       .name,
//                                                   textAlign: TextAlign.start,
//                                                   minFontSize: 16,
//                                                   maxFontSize: 16,
//                                                   style: GoogleFonts.poppins(
//                                                       color:
//                                                           AppColors.blackColor,
//                                                       fontSize: width / 30,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               childWhenDragging: Container(
//                                 decoration: BoxDecoration(
//                                   color: AppColors.whiteColor,
//                                   borderRadius: BorderRadius.circular(15),
//                                   image: DecorationImage(
//                                     alignment: Alignment.topCenter,
//                                     colorFilter: ColorFilter.mode(
//                                         Colors.white.withOpacity(0.4),
//                                         BlendMode.dstATop),
//                                     image: const AssetImage(
//                                       "assets/images/Pattern.png",
//                                     ),
//                                   ),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.grey.shade200,
//                                       blurRadius: 15,
//                                       offset: const Offset(5, 10),
//                                     ),
//                                   ],
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Stack(
//                                         children: [
//                                           ClipRRect(
//                                             borderRadius:
//                                                 BorderRadius.circular(15),
//                                             child: CachedNetworkImage(
//                                               imageUrl: value
//                                                   .breakfastMenu[index].image,
//                                               height: 150,
//                                               fit: BoxFit.cover,
//                                               placeholder: (context, url) =>
//                                                   Container(
//                                                 height: 150,
//                                                 width: 150,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.grey[300],
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                 ),
//                                               ),
//                                               errorWidget:
//                                                   (context, url, error) =>
//                                                       Icon(Icons.error),
//                                             ),
//                                           ),
//                                           Positioned(
//                                             bottom: -10,
//                                             left: -6,
//                                             child: Container(
//                                               decoration: const BoxDecoration(
//                                                 shape: BoxShape.circle,
//                                                 color: Colors.white,
//                                                 image: DecorationImage(
//                                                   alignment:
//                                                       Alignment.topCenter,
//                                                   image: AssetImage(
//                                                     "assets/images/Pattern.png",
//                                                   ),
//                                                 ),
//                                               ),
//                                               height: height / 16,
//                                               child: Center(
//                                                 child: Padding(
//                                                   padding: const EdgeInsets.all(
//                                                       10.0),
//                                                   child: AutoSizeText(
//                                                     // "\$ ${coffeePriceList[index]["price"].toString()}",
//                                                     "\$ ${value.breakfastMenu[index].cookTimeMinutes}",
//                                                     minFontSize: 16,
//                                                     maxFontSize: 18,
//                                                     style: GoogleFonts.poppins(
//                                                         color:
//                                                             AppColors.darkGreen,
//                                                         fontSize: width / 19,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                       SizedBox(height: height / 60),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: SizedBox(
//                                           width: width / 2,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               AutoSizeText(
//                                                 value.breakfastMenu[index].name,
//                                                 textAlign: TextAlign.start,
//                                                 minFontSize: 16,
//                                                 maxFontSize: 16,
//                                                 style: GoogleFonts.poppins(
//                                                     color: AppColors.blackColor,
//                                                     fontSize: width / 30,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               child: GestureDetector(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ItemDetails(
//                                           itemDescription: value
//                                               .breakfastMenu[index].cuisine,
//                                           itemImage:
//                                               value.breakfastMenu[index].image,
//                                           itemname:
//                                               value.breakfastMenu[index].name,
//                                           itemPrice:
//                                               value.breakfastMenu[index].rating,
//                                           itemId: value.breakfastMenu[index].id
//                                               .toString(),
//                                           restroName:
//                                               hotCoffeeNearestRestaurant[index]
//                                                   ['name'],
//                                           restroImg:
//                                               hotCoffeeNearestRestaurant[index]
//                                                   ['image'],
//                                           foodCategory: "breakfast"),
//                                     ),
//                                   );
//                                 },
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColors.whiteColor,
//                                     borderRadius: BorderRadius.circular(15),
//                                     image: DecorationImage(
//                                       alignment: Alignment.topCenter,
//                                       colorFilter: ColorFilter.mode(
//                                           Colors.white.withOpacity(0.4),
//                                           BlendMode.dstATop),
//                                       image: const AssetImage(
//                                         "assets/images/Pattern.png",
//                                       ),
//                                     ),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.grey.shade200,
//                                         blurRadius: 15,
//                                         offset: const Offset(5, 10),
//                                       ),
//                                     ],
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: [
//                                         Stack(
//                                           children: [
//                                             ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(15),
//                                               child: CachedNetworkImage(
//                                                 imageUrl: value
//                                                     .breakfastMenu[index].image,
//                                                 height: 150,
//                                                 width: 150,
//                                                 useOldImageOnUrlChange: true,
//                                                 fadeInDuration: Duration.zero,
//                                                 fadeOutDuration: Duration.zero,
//                                                 fit: BoxFit.cover,
//                                                 placeholder: (context, url) =>
//                                                     Container(
//                                                   height: 150,
//                                                   width: 150,
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.grey[300],
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             15),
//                                                   ),
//                                                 ),
//                                                 errorWidget:
//                                                     (context, url, error) =>
//                                                         Icon(
//                                                   Icons.broken_image,
//                                                   size: 30,
//                                                 ),
//                                               ),
//                                             ),
//                                             Positioned(
//                                               bottom: -10,
//                                               left: -6,
//                                               child: Container(
//                                                 decoration: const BoxDecoration(
//                                                   shape: BoxShape.circle,
//                                                   color: Colors.white,
//                                                   image: DecorationImage(
//                                                     alignment:
//                                                         Alignment.topCenter,
//                                                     image: AssetImage(
//                                                       "assets/images/Pattern.png",
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 height: height / 16,
//                                                 child: Center(
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             10.0),
//                                                     child: AutoSizeText(
//                                                       "\$ ${coffeePriceList[index]["price"].toString()}",
//                                                       minFontSize: 16,
//                                                       maxFontSize: 18,
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                               color: AppColors
//                                                                   .darkGreen,
//                                                               fontSize:
//                                                                   width / 19,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .bold),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         SizedBox(height: height / 60),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: SizedBox(
//                                             width: width / 2,
//                                             child: Column(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               children: [
//                                                 AutoSizeText(
//                                                   value.breakfastMenu[index]
//                                                       .name,
//                                                   textAlign: TextAlign.start,
//                                                   minFontSize: 16,
//                                                   maxFontSize: 16,
//                                                   style: GoogleFonts.poppins(
//                                                       color:
//                                                           AppColors.blackColor,
//                                                       fontSize: width / 30,
//                                                       fontWeight:
//                                                           FontWeight.bold),
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                     );
//                   }),
//                 ),
//                 DragTarget<Map<String, dynamic>>(
//                   onWillAccept: (data) {
//                     return data != null;
//                   },
//                   onAccept: (data) {
//                     setState(() {
//                       _isDropped = true;
//                       _droppedItem = data;
//                     });
//                     appTostMessage(
//                       context,
//                       ToastificationType.success,
//                       "${data["itemName"]} added to cart!",
//                       "assets/images/done.png",
//                     );
//                   },
//                   builder: (context, accepted, rejected) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           if (_droppedItem == null) {
//                             appTostMessage(
//                               context,
//                               ToastificationType.error,
//                               "Please drag and drop an item first.",
//                               "assets/images/wronge.png",
//                             );
//                             return;
//                           }
//                           Provider.of<HomeProvider>(context, listen: false)
//                               .addToCart(
//                             _droppedItem!["itemId"].toString(),
//                             _droppedItem?["itemName"],
//                             _droppedItem?["itemImage"],
//                             _droppedItem?["itemDiscription"],
//                             (_droppedItem?["itemPrice"] is num)
//                                 ? (_droppedItem?["itemPrice"] as num).toDouble()
//                                 : double.tryParse(_droppedItem?["itemPrice"]
//                                             ?.toString() ??
//                                         '') ??
//                                     0.0,
//                             _droppedItem?["itemRestro"]["name"],
//                           );

//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => CartScreen(),
//                             ),
//                           );
//                         },
//                         child: DroppedCartButton(
//                           height: height,
//                           width: width,
//                           droppedItem: _droppedItem,
//                           isDropped: _isDropped,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
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
import 'package:food_app/utils/theme/provider/app_theme_provider.dart';

class CatBreakFastMeal extends StatefulWidget {
  const CatBreakFastMeal({super.key});

  @override
  State<CatBreakFastMeal> createState() => _CatBreakFastMealState();
}

class _CatBreakFastMealState extends State<CatBreakFastMeal> {
  bool _isDropped = false;
  Map<String, dynamic>? _droppedItem;

  @override
  void initState() {
    super.initState();
    _loadBreakfastData();
  }

  Future<void> _loadBreakfastData() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.isLoading = true;
    await homeProvider.loadBreakFastData();
    homeProvider.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLightTheme = themeProvider.themeData.brightness == Brightness.light;
    final backgroundColor =
        isLightTheme ? AppColors.whiteColor : const Color(0xFF232323);
    final cardColor =
        isLightTheme ? AppColors.whiteColor : const Color(0xFF333739);
    final textColor = isLightTheme ? AppColors.blackColor : Colors.white;
    final shadowColor =
        isLightTheme ? Colors.grey.shade200 : Colors.black.withOpacity(0.5);
    final lightGreenBg =
        isLightTheme ? AppColors.extraLightGreen : const Color(0xFF1E3A1E);

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          image: DecorationImage(
            alignment: Alignment.topCenter,
            colorFilter: ColorFilter.mode(
                isLightTheme
                    ? Colors.white.withOpacity(0.2)
                    : Colors.black.withOpacity(0.3),
                BlendMode.dstATop),
            image: const AssetImage("assets/images/Pattern.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context, width, lightGreenBg, isLightTheme),
                SizedBox(height: height / 100),
                DragNote(width: width),
                Expanded(
                  child: Consumer<HomeProvider>(
                    builder: (context, homeProvider, child) {
                      if (homeProvider.isLoading) {
                        return Center(child: myProccesser());
                      }
                      return _buildBreakfastGrid(
                        context,
                        homeProvider,
                        height,
                        width,
                        cardColor,
                        shadowColor,
                        textColor,
                        isLightTheme,
                      );
                    },
                  ),
                ),
                _buildDragTarget(context, height, width, isLightTheme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, double width, Color lightGreenBg,
      bool isLightTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: lightGreenBg,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: AppColors.lightGreen,
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: isLightTheme ? AppColors.darkGreen : Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: width / 30),
        Flexible(
          child: GradientText(
            AppLocalizations.of(context)!.breakfast,
            style:
                GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
            gradient: const LinearGradient(
              colors: [AppColors.lightGreen, AppColors.darkGreen],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBreakfastGrid(
    BuildContext context,
    HomeProvider homeProvider,
    double height,
    double width,
    Color cardColor,
    Color shadowColor,
    Color textColor,
    bool isLightTheme,
  ) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final gridConfig = _getGridConfig(constraints.maxWidth);
        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: homeProvider.breakfastMenu.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            crossAxisCount: gridConfig.crossAxisCount,
            childAspectRatio: gridConfig.childAspectRatio,
          ),
          itemBuilder: (context, index) {
            final item = homeProvider.breakfastMenu[index];
            final price = coffeePriceList[index]["price"] is num
                ? coffeePriceList[index]["price"].toString()
                : '0.0';

            return LongPressDraggable<Map<String, dynamic>>(
              data: {
                "itemName": item.name,
                "itemPrice": price,
                "itemImage": item.image,
                "itemId": item.id,
                "itemDiscription": item.cuisine,
                "itemRestro": hotCoffeeNearestRestaurant[index],
              },
              feedback: _buildDraggableFeedback(height, width, item, price,
                  cardColor, shadowColor, textColor),
              childWhenDragging: _buildGhostItem(height, width, item, price,
                  cardColor, shadowColor, textColor),
              child: GestureDetector(
                onTap: () => _navigateToItemDetails(context, item, index),
                child: _buildMenuItem(height, width, item, price, cardColor,
                    shadowColor, textColor),
              ),
            );
          },
        );
      },
    );
  }

  GridConfig _getGridConfig(double screenWidth) {
    if (screenWidth > 1300) return GridConfig(6, 0.9);
    if (screenWidth > 1200) return GridConfig(6, 0.8);
    if (screenWidth > 1000) return GridConfig(5, 0.75);
    if (screenWidth > 800) return GridConfig(4, 0.7);
    if (screenWidth > 600) return GridConfig(3, 0.85);
    if (screenWidth > 500) return GridConfig(2, 0.65);
    return GridConfig(2, 0.75);
  }

  Widget _buildMenuItem(
    double height,
    double width,
    dynamic item,
    String price,
    Color cardColor,
    Color shadowColor,
    Color textColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 15,
            offset: const Offset(5, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                _buildItemImage(item),
                _buildPriceTag(height, width, price),
              ],
            ),
            SizedBox(height: height / 60),
            _buildItemName(width, item, textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildItemImage(dynamic item) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        imageUrl: item.image,
        height: 150,
        width: 150,
        useOldImageOnUrlChange: true,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.broken_image,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildPriceTag(double height, double width, String price) {
    return Positioned(
      bottom: -10,
      left: -6,
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        height: height / 16,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: AutoSizeText(
              "\$ $price",
              minFontSize: 16,
              maxFontSize: 18,
              style: GoogleFonts.poppins(
                color: AppColors.darkGreen,
                fontSize: width / 19,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemName(double width, dynamic item, Color textColor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: width / 2,
        child: Column(
          children: [
            AutoSizeText(
              item.name,
              textAlign: TextAlign.start,
              minFontSize: 16,
              maxFontSize: 16,
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: width / 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDraggableFeedback(
    double height,
    double width,
    dynamic item,
    String price,
    Color cardColor,
    Color shadowColor,
    Color textColor,
  ) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: cardColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 15,
              offset: const Offset(5, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  _buildItemImage(item),
                  _buildPriceTag(height, width, price),
                ],
              ),
              SizedBox(height: height / 60),
              _buildItemName(width, item, textColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGhostItem(
    double height,
    double width,
    dynamic item,
    String price,
    Color cardColor,
    Color shadowColor,
    Color textColor,
  ) {
    return Opacity(
      opacity: 0.5,
      child: _buildMenuItem(
          height, width, item, price, cardColor, shadowColor, textColor),
    );
  }

  Widget _buildDragTarget(
      BuildContext context, double height, double width, bool isLightTheme) {
    return DragTarget<Map<String, dynamic>>(
      onWillAccept: (data) => data != null,
      onAccept: (data) {
        setState(() {
          _isDropped = true;
          _droppedItem = data;
        });
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
            onTap: () => _handleCartButtonTap(context),
            child: DroppedCartButton(
              height: height,
              width: width,
              droppedItem: _droppedItem,
              isDropped: _isDropped,
              isLightTheme: isLightTheme,
            ),
          ),
        );
      },
    );
  }

  void _navigateToItemDetails(BuildContext context, dynamic item, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetails(
          itemDescription: item.cuisine,
          itemImage: item.image,
          itemname: item.name,
          itemPrice: item.rating?.toDouble(),
          itemId: item.id.toString(),
          restroName: hotCoffeeNearestRestaurant[index]['name'],
          restroImg: hotCoffeeNearestRestaurant[index]['image'],
          foodCategory: "breakfast",
        ),
      ),
    );
  }

  void _handleCartButtonTap(BuildContext context) {
    if (_droppedItem == null) {
      appTostMessage(
        context,
        ToastificationType.error,
        "Please drag and drop an item first.",
        "assets/images/wronge.png",
      );
      return;
    }

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.addToCart(
      _droppedItem!["itemId"].toString(),
      _droppedItem?["itemName"],
      _droppedItem?["itemImage"],
      _droppedItem?["itemDiscription"],
      (_droppedItem?["itemPrice"] is num)
          ? (_droppedItem?["itemPrice"] as num).toDouble()
          : double.tryParse(_droppedItem?["itemPrice"]?.toString() ?? '') ??
              0.0,
      _droppedItem?["itemRestro"]["name"],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CartScreen(),
      ),
    );
  }
}

class GridConfig {
  final int crossAxisCount;
  final double childAspectRatio;

  GridConfig(this.crossAxisCount, this.childAspectRatio);
}
