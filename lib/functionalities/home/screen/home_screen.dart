// // ignore_for_file: use_build_context_synchronously, deprecated_member_use

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/constant/app_colors.dart';
// import 'package:food_app/constant/app_gredient_text.dart';
// import 'package:food_app/constant/app_textform_field.dart';
// import 'package:food_app/functionalities/home/helper/list_data.dart';
// import 'package:food_app/functionalities/home/provider/home_provider.dart';
// import 'package:food_app/functionalities/home/screen/item_details.dart';
// import 'package:food_app/functionalities/home/widget/cards/card1.dart';
// import 'package:food_app/functionalities/home/widget/cards/card2.dart';
// import 'package:food_app/functionalities/home/widget/cards/card3.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_canadian_meal.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_dessert_meal.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_hot_coffee.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_main_meal.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_pasta.dart';
// import 'package:food_app/functionalities/home/widget/grid%20and%20lists/meals_categories.dart';
// import 'package:food_app/utils/utils.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<HomeProvider>(context, listen: false).getAllCategories();
//       Provider.of<HomeProvider>(context, listen: false).getMeals();
//       Provider.of<HomeProvider>(context, listen: false).getCanadianMeal();
//       Provider.of<HomeProvider>(context, listen: false).getDessertMeal();
//       Provider.of<HomeProvider>(context, listen: false).fetchHotCoffeeData();
//       Provider.of<HomeProvider>(context, listen: false).fetchIcedCoffeeData();
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _searchController.dispose();
//   }

//   void _goToPage(int number) {
//     Widget page;

//     switch (number) {
//       case 0:
//         page = CatPasta();
//         break;
//       case 1:
//         page = CatHotCoffee();
//       case 2:
//         page = CatHotCoffee();
//       case 3:
//         page = CatDessertMeal();
//       case 4:
//         page = CatCanadianMeal();
//       case 5:
//         page = CatMainMeal();
//         break;
//       default:
//         page = CatPasta(); // default item when no matching category found
//     }

//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return page;
//     }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final homeProvider = Provider.of<HomeProvider>(context, listen: false);
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: Consumer<HomeProvider>(
//         builder: (BuildContext context, value, Widget? child) {
//           if (value.isLoading) {
//             return Center(
//               child: Center(
//                 child: myProccesser(),
//               ),
//             );
//           }
//           // final meals = value.mealsModel;
//           final categories = value.foodCategoriesModel;
//           // final canadianMeal = value.canadianMealModel;
//           // final dessertMeals = value.dessertModel;
//           // final coffee = value.coffees;
//           // final icedCoffee = value.icedCoffee;
//           return Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                   alignment: Alignment.topCenter,
//                   colorFilter: ColorFilter.mode(
//                       Colors.white.withOpacity(0.4), BlendMode.dstATop),
//                   image: const AssetImage(
//                     "assets/images/Pattern.png",
//                   ),
//                   fit: kIsWeb ? BoxFit.cover : BoxFit.none),
//             ),
//             child: SafeArea(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: GradientText(
//                               AppLocalizations.of(context)!.homeTitle,
//                               // 'Find Your Favorite Food',
//                               style: GoogleFonts.poppins(
//                                   fontSize: 30, fontWeight: FontWeight.bold),
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   AppColors.lightGreen,
//                                   AppColors.darkGreen,
//                                 ],
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               // checkSSl("https://api.sampleapis.com/coffee/hot");
//                               // Navigator.push(
//                               //     context,
//                               //     MaterialPageRoute(
//                               //       builder: (context) => MyApp(),
//                               //     ));
//                               // appTostMessage(
//                               //     context,
//                               //     ToastificationType.success,
//                               //     "Hello there!, How are you??",
//                               //     "assets/images/done.png");
//                               // Navigator.push(
//                               //   context,
//                               //   MaterialPageRoute(
//                               //     // builder: (context) => const MyRiveAnimation(),
//                               //     builder: (context) => const Getdata(),
//                               //   ),
//                               // );
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: AppColors.whiteColor,
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.shade100,
//                                       offset: const Offset(5, 25),
//                                       blurRadius: 15),
//                                 ],
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset(
//                                   "assets/images/home/notification.png",
//                                   height: height / 30,
//                                   width: width / 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 30,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomeTextFormField(
//                               textEditingController: _searchController,
//                               onChanged: (value) {
//                                 homeProvider.
//
// (value);
//                               },
//                               obscureText: false,
//                               borderColor:
//                                   const Color.fromARGB(255, 252, 255, 252),
//                               disabledColor:
//                                   const Color.fromARGB(255, 252, 255, 252),
//                               enabledColor:
//                                   const Color.fromARGB(255, 252, 255, 252),
//                               focusedColor:
//                                   AppColors.darkOrange.withOpacity(1.0),
//                               hintText:
//                                   //  "What Do You Want To Order?",
//                                   AppLocalizations.of(context)!.search,
//                               fillColor: AppColors.lightOrange,
//                               hintcolors: AppColors.darkOrange.withOpacity(1.0),
//                               prefixIcon: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset(
//                                   "assets/images/home/search.png",
//                                   height: height / 100,
//                                 ),
//                               ),
//                               sufixIcon: IconButton(
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   homeProvider.clearSearch();
//                                 },
//                                 icon: const Icon(Icons.clear),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: width / 30,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: AppColors.lightOrange,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                     color: Colors.grey.shade100,
//                                     offset: const Offset(5, 25),
//                                     blurRadius: 15),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.asset(
//                                 "assets/images/home/Filter.png",
//                                 height: height / 35,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 100,
//                       ),
//                       homeProvider.isLoading
//                           ? Center(
//                               child: myProccesser(),
//                             )
//                           : homeProvider.searchResults.isEmpty
//                               ? homeProvider.searchQuery.isEmpty
//                                   ? Center(
//                                       child: null,
//                                     )
//                                   : Container(
//                                       padding: EdgeInsets.all(20),
//                                       decoration: BoxDecoration(
//                                         color: Color(0xc3eaffdd),
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                       child: Center(
//                                         child: Text("Item Not Found"),
//                                       ),
//                                     )
//                               : Container(
//                                   decoration: BoxDecoration(
//                                     color: Color(0xc3eaffdd),
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: ListView.builder(
//                                     itemCount:
//                                         homeProvider.searchResults.length,
//                                     shrinkWrap: true,
//                                     itemBuilder: (context, index) {
//                                       final dessert =
//                                           homeProvider.searchResults[index];
//                                       // final coffee = homeProvider.searchCoffeeResults[index];
//                                       // final canadian = homeProvider.searchCanadianResults[index];
//                                       return Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 horizontal: 4.0),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white60,
//                                                 border: Border.all(
//                                                   color: Colors.black26,
//                                                   width: 0.5,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: ListTile(
//                                                 leading: dessert.image != null
//                                                     ? ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         child: Image.network(
//                                                             dessert.image!),
//                                                       )
//                                                     : null,
//                                                 title: Text(dessert.name ?? ''),
//                                                 subtitle:
//                                                     Text(dessert.cuisine ?? ""),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 6,
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 ),
//                       SizedBox(
//                         height: height / 40,
//                       ),
//                       LayoutBuilder(
//                         builder:
//                             (BuildContext context, BoxConstraints constraints) {
//                           double screenWidth = constraints.maxWidth;
//                           int crossAxisCount = 4;
//                           double childAspectRatio = 0.8;
//                           double cardHeight = height / 4.5;

//                           if (screenWidth > 1300) {
//                             // Desktop view
//                             crossAxisCount = 6;
//                             childAspectRatio = 2;
//                             cardHeight = height / 3;
//                           } else if (screenWidth > 1200 && screenWidth < 1300) {
//                             // Desktop view
//                             crossAxisCount = 5;
//                             childAspectRatio = 2;
//                             cardHeight = height / 3.5;
//                           } else if (screenWidth > 1000 && screenWidth < 1200) {
//                             // Tablet view
//                             crossAxisCount = 5;
//                             childAspectRatio = 2;
//                             cardHeight = height / 3.5;
//                           } else if (screenWidth > 800 && screenWidth < 1000) {
//                             crossAxisCount = 4;
//                             childAspectRatio = 2;
//                             cardHeight = height / 4.5;
//                           } else if (screenWidth > 600) {
//                             crossAxisCount = 3;
//                             childAspectRatio = 1.5;
//                             cardHeight = height / 4.5;
//                           } else if (screenWidth > 500) {
//                             crossAxisCount = 3;
//                             childAspectRatio = 1;
//                             cardHeight = height / 4.5;
//                           } else if (screenWidth > 350) {
//                             crossAxisCount = 3;
//                             childAspectRatio = 1;
//                             cardHeight = height / 4.5;
//                           }

//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               CarouselSlider(
//                                 options: CarouselOptions(
//                                   animateToClosest: true,
//                                   scrollPhysics: const BouncingScrollPhysics(),
//                                   pageSnapping: true,
//                                   autoPlay: true,
//                                   aspectRatio: 1,
//                                   height: cardHeight,
//                                   enlargeCenterPage: true,
//                                   autoPlayCurve: Curves.easeInOutCubic,
//                                 ),
//                                 disableGesture: false,
//                                 items: const [
//                                   Card1(),
//                                   Card2(),
//                                   Card3(),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: height / 40,
//                               ),
//                               SizedBox(
//                                 height: height / 40,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10, bottom: 15),
//                                 child: Text(
//                                   AppLocalizations.of(context)!.categories,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: foodCategoriesList(context).length,
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisSpacing: 15,
//                                   mainAxisSpacing: 15,
//                                   childAspectRatio: childAspectRatio,
//                                   crossAxisCount: crossAxisCount,
//                                 ),
//                                 itemBuilder: (context, index) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       _goToPage(index);
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: const Color.fromARGB(
//                                               255, 238, 255, 234),
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: const Color.fromARGB(
//                                                   17, 0, 0, 0),
//                                               blurRadius: 1,
//                                               spreadRadius: 3,
//                                               offset: Offset(2, 2),
//                                             ),
//                                           ],
//                                           borderRadius:
//                                               BorderRadius.circular(12)),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Image.asset(
//                                             key: Key("foodCategoryList"),
//                                             foodCategoriesList(context)[index]
//                                                 ["image"],
//                                             height: 50,
//                                           ),
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 8.0),
//                                             child: Text(
//                                               foodCategoriesList(context)[index]
//                                                   ["name"],
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 14),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                       SizedBox(
//                         height: height / 40,
//                       ),
//                       GestureDetector(
//                         key: Key("otherCategories"),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MealsCategories(
//                                 height: height,
//                                 categories: categories,
//                                 width: width,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           height: height / 15,
//                           margin: EdgeInsets.all(2),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: const Color.fromARGB(17, 0, 0, 0),
//                                 blurRadius: 1,
//                                 spreadRadius: 2,
//                                 offset: Offset(0, 0),
//                               ),
//                             ],
//                             color: const Color.fromARGB(255, 238, 255, 234),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Icon(Icons.category_rounded),
//                               SizedBox(width: width / 40),
//                               Text(
//                                 AppLocalizations.of(context)!.otherCategories,
//                                 style: GoogleFonts.poppins(),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: height / 50),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               AppLocalizations.of(context)!.populerMenu,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               AppLocalizations.of(context)!.viewMore,
//                               // 'View More',
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.darkOrange,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//                       ListView.builder(
//                         itemCount: popularItems.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         scrollDirection: Axis.vertical,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 8.0),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ItemDetails(
//                                       itemId: popularItems[index]["id"],
//                                       itemImage: popularItems[index]["image"],
//                                       itemPrice: popularItems[index]["price"],
//                                       itemname: popularItems[index]["name"],
//                                       restroImg:
//                                           "assets/images/home/nearRestaurant/near3.png",
//                                       restroName: "The Chinese Bar",
//                                       itemDescription: popularItems[index]
//                                           ["description"],
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius:
//                                           BorderRadiusDirectional.circular(15),
//                                       child: Image.asset(
//                                         popularItems[index]["image"],
//                                         fit: BoxFit.cover,
//                                         height: 80,
//                                         width: 80,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           popularItems[index]["name"],
//                                           style: GoogleFonts.poppins(
//                                               color: AppColors.blackColor,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                         Text(
//                                           popularItems[index]["description"],
//                                           style: GoogleFonts.poppins(
//                                               color: AppColors.blackColor,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "\$${popularItems[index]["price"]}",
//                                       style: GoogleFonts.poppins(
//                                           color: AppColors.darkOrange,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

//-------------------------------------------
// ignore_for_file: use_build_context_synchronously, deprecated_member_use

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/constant/app_colors.dart';
// import 'package:food_app/constant/app_gredient_text.dart';
// import 'package:food_app/constant/app_textform_field.dart';
// import 'package:food_app/functionalities/home/helper/list_data.dart';
// import 'package:food_app/functionalities/home/provider/home_provider.dart';
// import 'package:food_app/functionalities/home/screen/item_details.dart';
// import 'package:food_app/functionalities/home/widget/cards/card1.dart';
// import 'package:food_app/functionalities/home/widget/cards/card2.dart';
// import 'package:food_app/functionalities/home/widget/cards/card3.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_breakfast_menu.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_canadian_meal.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_dessert_meal.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_hot_coffee.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_launch_meal.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_main_meal.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_pasta.dart';
// import 'package:food_app/functionalities/home/widget/category%20pages/cat_dinner_meal.dart';
// import 'package:food_app/functionalities/home/widget/grid%20and%20lists/meals_categories.dart';
// import 'package:food_app/utils/utils.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:food_app/utils/theme/provider/app_theme_provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       Provider.of<HomeProvider>(context, listen: false).getAllCategories();
//       Provider.of<HomeProvider>(context, listen: false).getMeals();
//       Provider.of<HomeProvider>(context, listen: false).getCanadianMeal();
//       Provider.of<HomeProvider>(context, listen: false).getDessertMeal();
//       Provider.of<HomeProvider>(context, listen: false).fetchHotCoffeeData();
//       Provider.of<HomeProvider>(context, listen: false).fetchIcedCoffeeData();
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _searchController.dispose();
//   }

//   void _goToPage(int number) {
//     Widget page;

//     switch (number) {
//       case 0:
//         page = CatPasta();
//         break;
//       case 1:
//         page = CatHotCoffee();
//       case 2:
//         page = CatHotCoffee();
//       case 3:
//         page = CatDessertMeal();
//       case 4:
//         page = CatCanadianMeal();
//       case 5:
//         page = CatMainMeal();
//       case 6:
//         page = CatDinnerMeal();
//       case 7:
//         page = CatLunchMeal();
//       case 8:
//         page = CatBreakFastMeal();
//         break;
//       default:
//         page = CatPasta();
//     }

//     Navigator.push(context, MaterialPageRoute(builder: (context) {
//       return page;
//     }));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final homeProvider = Provider.of<HomeProvider>(context, listen: false);
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final isLightTheme = themeProvider.themeData.brightness == Brightness.light;

//     // Theme-based colors
//     final backgroundColor =
//         isLightTheme ? AppColors.whiteColor : const Color(0xFF232323);
//     final cardColor = isLightTheme
//         ? const Color.fromARGB(255, 238, 255, 234)
//         : const Color(0xFF333739);
//     final searchFieldColor =
//         isLightTheme ? AppColors.lightOrange : const Color(0xFF333739);
//     final searchHintColor =
//         isLightTheme ? AppColors.darkOrange.withOpacity(1.0) : Colors.white70;
//     final textColor = isLightTheme ? AppColors.blackColor : Colors.white;
//     final subTextColor = isLightTheme ? AppColors.blackColor : Colors.white70;
//     final borderColor = isLightTheme
//         ? const Color.fromARGB(255, 252, 255, 252)
//         : const Color(0xFF232323);

//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Consumer<HomeProvider>(
//         builder: (BuildContext context, value, Widget? child) {
//           if (value.isLoading) {
//             return Center(
//               child: Center(
//                 child: myProccesser(),
//               ),
//             );
//           }
//           final categories = value.foodCategoriesModel;
//           return Container(
//             height: double.infinity,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: backgroundColor,
//               image: DecorationImage(
//                   alignment: Alignment.topCenter,
//                   colorFilter: ColorFilter.mode(
//                       isLightTheme
//                           ? Colors.white.withOpacity(0.2)
//                           : Colors.black.withOpacity(0.3),
//                       BlendMode.dstATop),
//                   image: const AssetImage(
//                     "assets/images/Pattern.png",
//                   ),
//                   fit: kIsWeb ? BoxFit.cover : BoxFit.none),
//             ),
//             child: SafeArea(
//               child: Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.vertical,
//                   physics: const BouncingScrollPhysics(),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Flexible(
//                             child: GradientText(
//                               AppLocalizations.of(context)!.homeTitle,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 30, fontWeight: FontWeight.bold),
//                               gradient: const LinearGradient(
//                                 colors: [
//                                   AppColors.lightGreen,
//                                   AppColors.darkGreen,
//                                 ],
//                               ),
//                             ),
//                           ),
//                           GestureDetector(
//                             onTap: () {},
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: backgroundColor,
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: isLightTheme
//                                         ? Colors.grey.shade100
//                                         : Colors.black12,
//                                   ),
//                                 ],
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset(
//                                   "assets/images/home/notification.png",
//                                   height: height / 30,
//                                   width: width / 14,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 30,
//                       ),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: CustomeTextFormField(
//                               textEditingController: _searchController,
//                               onChanged: (value) {
//                                 homeProvider.setSearchQuery(value);
//                               },
//                               obscureText: false,
//                               borderColor: borderColor,
//                               disabledColor: borderColor,
//                               enabledColor: borderColor,
//                               focusedColor: searchHintColor,
//                               hintText: AppLocalizations.of(context)!.search,
//                               fillColor: searchFieldColor,
//                               hintcolors: searchHintColor,
//                               prefixIcon: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset(
//                                   "assets/images/home/search.png",
//                                   height: height / 100,
//                                 ),
//                               ),
//                               sufixIcon: IconButton(
//                                 onPressed: () {
//                                   _searchController.clear();
//                                   homeProvider.clearSearch();
//                                 },
//                                 icon: const Icon(Icons.clear),
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: width / 30,
//                           ),
//                           Container(
//                             padding: const EdgeInsets.all(5),
//                             decoration: BoxDecoration(
//                               color: searchFieldColor,
//                               borderRadius: BorderRadius.circular(15),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: isLightTheme
//                                       ? Colors.grey.shade100
//                                       : Colors.black12,
//                                 ),
//                               ],
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Image.asset(
//                                 "assets/images/home/Filter.png",
//                                 height: height / 35,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: height / 100,
//                       ),
//                       homeProvider.isLoading
//                           ? Center(
//                               child: myProccesser(),
//                             )
//                           : homeProvider.searchResults.isEmpty
//                               ? homeProvider.searchQuery.isEmpty
//                                   ? Center(
//                                       child: null,
//                                     )
//                                   : Container(
//                                       padding: EdgeInsets.all(20),
//                                       decoration: BoxDecoration(
//                                         color: cardColor,
//                                         borderRadius: BorderRadius.circular(15),
//                                       ),
//                                       child: Center(
//                                         child: Text(
//                                           "Item Not Found",
//                                           style: TextStyle(
//                                             color: textColor,
//                                             fontSize: 16,
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                               : Container(
//                                   padding: EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: cardColor,
//                                     borderRadius: BorderRadius.circular(15),
//                                   ),
//                                   child: ListView.builder(
//                                     itemCount:
//                                         homeProvider.searchResults.length,
//                                     shrinkWrap: true,
//                                     itemBuilder: (context, index) {
//                                       final dessert =
//                                           homeProvider.searchResults[index];
//                                       return Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                               vertical: 4.0,
//                                             ),
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                 color: isLightTheme
//                                                     ? Colors.white60
//                                                     : const Color.fromARGB(
//                                                         255, 48, 48, 48),
//                                                 border: Border.all(
//                                                   color: isLightTheme
//                                                       ? Colors.black26
//                                                       : Colors.white24,
//                                                   width: 0.5,
//                                                 ),
//                                                 borderRadius:
//                                                     BorderRadius.circular(10),
//                                               ),
//                                               child: ListTile(
//                                                 leading: dessert.image != null
//                                                     ? ClipRRect(
//                                                         borderRadius:
//                                                             BorderRadius
//                                                                 .circular(10),
//                                                         child: Image.network(
//                                                             dessert.image!),
//                                                       )
//                                                     : null,
//                                                 title: Text(
//                                                   dessert.name ?? '',
//                                                   style: TextStyle(
//                                                     color: textColor,
//                                                   ),
//                                                 ),
//                                                 subtitle: Text(
//                                                   dessert.cuisine ?? "",
//                                                   style: TextStyle(
//                                                     color: subTextColor,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 6,
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   ),
//                                 ),
//                       SizedBox(
//                         height: height / 40,
//                       ),
//                       LayoutBuilder(
//                         builder:
//                             (BuildContext context, BoxConstraints constraints) {
//                           double screenWidth = constraints.maxWidth;
//                           int crossAxisCount = 4;
//                           double childAspectRatio = 0.8;
//                           double cardHeight = height / 4.5;

//                           if (screenWidth > 1300) {
//                             crossAxisCount = 6;
//                             childAspectRatio = 2;
//                             cardHeight = height / 3;
//                           } else if (screenWidth > 1200 && screenWidth < 1300) {
//                             crossAxisCount = 5;
//                             childAspectRatio = 2;
//                             cardHeight = height / 3.5;
//                           } else if (screenWidth > 1000 && screenWidth < 1200) {
//                             crossAxisCount = 5;
//                             childAspectRatio = 2;
//                             cardHeight = height / 3.5;
//                           } else if (screenWidth > 800 && screenWidth < 1000) {
//                             crossAxisCount = 4;
//                             childAspectRatio = 2;
//                             cardHeight = height / 4.5;
//                           } else if (screenWidth > 600) {
//                             crossAxisCount = 3;
//                             childAspectRatio = 1.5;
//                             cardHeight = height / 4.5;
//                           } else if (screenWidth > 500) {
//                             crossAxisCount = 3;
//                             childAspectRatio = 1;
//                             cardHeight = height / 4.5;
//                           } else if (screenWidth > 350) {
//                             crossAxisCount = 3;
//                             childAspectRatio = 1;
//                             cardHeight = height / 4.5;
//                           }

//                           return Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               CarouselSlider(
//                                 options: CarouselOptions(
//                                   animateToClosest: true,
//                                   scrollPhysics: const BouncingScrollPhysics(),
//                                   pageSnapping: true,
//                                   autoPlay: true,
//                                   aspectRatio: 1,
//                                   height: cardHeight,
//                                   enlargeCenterPage: true,
//                                   autoPlayCurve: Curves.easeInOutCubic,
//                                 ),
//                                 disableGesture: false,
//                                 items: const [
//                                   Card1(),
//                                   Card2(),
//                                   Card3(),
//                                 ],
//                               ),
//                               // SizedBox(
//                               //   height: height / 40,
//                               // ),
//                               SizedBox(
//                                 height: height / 40,
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(top: 10, bottom: 15),
//                                 child: Text(
//                                   AppLocalizations.of(context)!.categories,
//                                   style: GoogleFonts.poppins(
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold,
//                                       color: textColor),
//                                 ),
//                               ),
//                               GridView.builder(
//                                 shrinkWrap: true,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: foodCategoriesList(context).length,
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisSpacing: 15,
//                                   mainAxisSpacing: 15,
//                                   childAspectRatio: childAspectRatio,
//                                   crossAxisCount: crossAxisCount,
//                                 ),
//                                 itemBuilder: (context, index) {
//                                   return GestureDetector(
//                                     onTap: () {
//                                       _goToPage(index);
//                                     },
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                           color: cardColor,
//                                           boxShadow: [
//                                             BoxShadow(
//                                               color: const Color.fromARGB(
//                                                   17, 0, 0, 0),
//                                               blurRadius: 1,
//                                               spreadRadius: 3,
//                                               offset: Offset(2, 2),
//                                             ),
//                                           ],
//                                           borderRadius:
//                                               BorderRadius.circular(12)),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Image.asset(
//                                             key: Key("foodCategoryList"),
//                                             foodCategoriesList(context)[index]
//                                                 ["image"],
//                                             height: 50,
//                                           ),
//                                           Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 8.0),
//                                             child: Text(
//                                               foodCategoriesList(context)[index]
//                                                   ["name"],
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 14,
//                                                   color: textColor),
//                                               textAlign: TextAlign.center,
//                                             ),
//                                           )
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                       SizedBox(
//                         height: height / 40,
//                       ),
//                       GestureDetector(
//                         key: Key("otherCategories"),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => MealsCategories(
//                                 height: height,
//                                 categories: categories,
//                                 width: width,
//                               ),
//                             ),
//                           );
//                         },
//                         child: Container(
//                           height: height / 15,
//                           margin: EdgeInsets.all(2),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             boxShadow: [
//                               BoxShadow(
//                                 color: const Color.fromARGB(17, 0, 0, 0),
//                                 blurRadius: 1,
//                                 spreadRadius: 2,
//                                 offset: Offset(0, 0),
//                               ),
//                             ],
//                             color: cardColor,
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Icon(Icons.category_rounded, color: textColor),
//                               SizedBox(width: width / 40),
//                               Text(
//                                 AppLocalizations.of(context)!.otherCategories,
//                                 style: GoogleFonts.poppins(color: textColor),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(vertical: height / 50),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               AppLocalizations.of(context)!.populerMenu,
//                               style: GoogleFonts.poppins(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: textColor),
//                             ),
//                             Text(
//                               AppLocalizations.of(context)!.viewMore,
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.darkOrange,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                             ),
//                           ],
//                         ),
//                       ),
//                       ListView.builder(
//                         itemCount: popularItems.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         scrollDirection: Axis.vertical,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 8.0),
//                             child: GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => ItemDetails(
//                                       itemId: popularItems[index]["id"],
//                                       itemImage: popularItems[index]["image"],
//                                       itemPrice: popularItems[index]["price"],
//                                       itemname: popularItems[index]["name"],
//                                       restroImg:
//                                           "assets/images/home/nearRestaurant/near3.png",
//                                       restroName: "The Chinese Bar",
//                                       itemDescription: popularItems[index]
//                                           ["description"],
//                                     ),
//                                   ),
//                                 );
//                               },
//                               child: Container(
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(15),
//                                   color: cardColor,
//                                 ),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius:
//                                           BorderRadiusDirectional.circular(15),
//                                       child: Image.asset(
//                                         popularItems[index]["image"],
//                                         fit: BoxFit.cover,
//                                         height: 80,
//                                         width: 80,
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 15,
//                                     ),
//                                     Column(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           popularItems[index]["name"],
//                                           style: GoogleFonts.poppins(
//                                               color: textColor,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                         Text(
//                                           popularItems[index]["description"],
//                                           style: GoogleFonts.poppins(
//                                               color: subTextColor,
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w400),
//                                         ),
//                                       ],
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "\$${popularItems[index]["price"]}",
//                                       style: GoogleFonts.poppins(
//                                           color: AppColors.darkOrange,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.w700),
//                                     ),
//                                     SizedBox(
//                                       width: 12,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';

import 'package:food_app/functionalities/home/widget/category%20pages/cat_breakfast_menu.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_canadian_meal.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_dessert_meal.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_dinner_meal.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_hot_coffee.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_launch_meal.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_main_meal.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_pasta.dart';
import 'package:food_app/functionalities/home/widget/home%20sections/build_other_categories_card.dart';
import 'package:food_app/functionalities/home/widget/home%20sections/carousel_cards.dart';
import 'package:food_app/functionalities/home/widget/home%20sections/categories_grid.dart';
import 'package:food_app/functionalities/home/widget/home%20sections/home_header.dart';
import 'package:food_app/functionalities/home/widget/home%20sections/popular_menu_list.dart';
import 'package:food_app/functionalities/home/widget/home%20sections/search_bar.dart';
import 'package:food_app/functionalities/home/widget/home%20sections/search_results_list.dart';

import 'package:food_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:food_app/utils/theme/provider/app_theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.getAllCategories();
      homeProvider.getMeals();
      homeProvider.getCanadianMeal();
      homeProvider.getDessertMeal();
      homeProvider.fetchHotCoffeeData();
      homeProvider.fetchIcedCoffeeData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLightTheme = themeProvider.themeData.brightness == Brightness.light;
    final backgroundColor =
        isLightTheme ? AppColors.whiteColor : const Color(0xFF232323);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
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
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeader(),
                  const SizedBox(height: 20),
                  Consumer<HomeProvider>(builder: (BuildContext context,
                      HomeProvider homeProvider, Widget? child) {
                    if (homeProvider.isLoading) {
                      return Center(
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height / 1.5,
                              child: myProccesser()));
                    }
                    return Column(
                      children: [
                        AppSearchBar(
                          controller: _searchController,
                          onChanged: (value) {
                            homeProvider.setSearchQuery(value);
                          },
                          onClear: () {
                            _searchController.clear();
                            homeProvider.clearSearch();
                          },
                        ),
                        const SizedBox(height: 10),
                        if (homeProvider.searchQuery.isNotEmpty)
                          SearchResultsList(
                            searchResults: homeProvider.searchResults,
                            isLightTheme: isLightTheme,
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CarouselCards(),
                              const SizedBox(height: 20),
                              CategoriesGrid(
                                onCategoryTap: _goToPage,
                                isLightTheme: isLightTheme,
                              ),
                              const SizedBox(height: 20),
                              buildOtherCategoriesCard(
                                  context, isLightTheme, homeProvider),
                              const SizedBox(height: 20),
                              PopularMenuList(isLightTheme: isLightTheme),
                            ],
                          ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goToPage(int number) {
    Widget page;

    switch (number) {
      case 0:
        page = CatPasta();
        break;
      case 1:
        page = CatHotCoffee();
        break;
      case 2:
        page = CatHotCoffee();
        break;
      case 3:
        page = CatDessertMeal();
        break;
      case 4:
        page = CatCanadianMeal();
        break;
      case 5:
        page = CatMainMeal();
        break;
      case 6:
        page = CatDinnerMeal();
        break;
      case 7:
        page = CatLunchMeal();
        break;
      case 8:
        page = CatBreakFastMeal();
        break;
      default:
        page = CatPasta();
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}
