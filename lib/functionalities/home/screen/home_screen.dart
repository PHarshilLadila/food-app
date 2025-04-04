// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_textform_field.dart';
import 'package:food_app/functionalities/home/helper/list_data.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/widget/cards/card1.dart';
import 'package:food_app/functionalities/home/widget/cards/card2.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_canadian_meal.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_dessert_meal.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_hot_coffee.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_main_meal.dart';
import 'package:food_app/functionalities/home/widget/category%20pages/cat_pasta.dart';
import 'package:food_app/functionalities/home/widget/grid%20and%20lists/meals_categories.dart';
import 'package:food_app/functionalities/home/widget/populer_menu.dart';
import 'package:food_app/functionalities/rest%20api%20with%20dio/get_data.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<HomeProvider>(context, listen: false).getAllCategories();
      Provider.of<HomeProvider>(context, listen: false).getMeals();
      Provider.of<HomeProvider>(context, listen: false).getCanadianMeal();
      Provider.of<HomeProvider>(context, listen: false).getDessertMeal();
      Provider.of<HomeProvider>(context, listen: false).fetchHotCoffeeData();
      Provider.of<HomeProvider>(context, listen: false).fetchIcedCoffeeData();
    });
  }

  void _goToPage(int number) {
    Widget page;

    switch (number) {
      case 0:
        page = CatPasta();
        break;
      case 1:
        page = CatHotCoffee();
      case 2:
        page = CatHotCoffee();
      case 3:
        page = CatDessertMeal();
      case 4:
        page = CatCanadianMeal();
      case 5:
        page = CatMainMeal();
        break;
      default:
        page = CatPasta(); // default item when no matching category found
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Consumer<HomeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.isLoading) {
            return Center(
              child: Center(child: myProccesser()),
            );
          }
          // final meals = value.mealsModel;
          final categories = value.foodCategoriesModel;
          // final canadianMeal = value.canadianMealModel;
          // final dessertMeals = value.dessertModel;
          // final coffee = value.coffees;
          // final icedCoffee = value.icedCoffee;
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.4), BlendMode.dstATop),
                image: const AssetImage(
                  "assets/images/Pattern.png",
                ),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: GradientText(
                              // AppLocalizations.of(context)!.homeTitle,
                              'Find Your Favorite Food',
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
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // builder: (context) => const MyRiveAnimation(),
                                  builder: (context) => const Getdata(),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade100,
                                      offset: const Offset(5, 25),
                                      blurRadius: 15),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/images/home/notification.png",
                                  height: height / 30,
                                  width: width / 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomeTextFormField(
                              obscureText: false,
                              borderColor:
                                  const Color.fromARGB(255, 252, 255, 252),
                              disabledColor:
                                  const Color.fromARGB(255, 252, 255, 252),
                              enabledColor:
                                  const Color.fromARGB(255, 252, 255, 252),
                              focusedColor:
                                  AppColors.darkOrange.withOpacity(1.0),
                              hintText: "What Do You Want To Order?",
                              //  AppLocalizations.of(context)!.search,
                              fillColor: AppColors.lightOrange,
                              hintcolors: AppColors.darkOrange.withOpacity(1.0),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset(
                                  "assets/images/home/search.png",
                                  height: height / 100,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width / 30,
                          ),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: AppColors.lightOrange,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade100,
                                    offset: const Offset(5, 25),
                                    blurRadius: 15),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/home/Filter.png",
                                height: height / 35,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 40,
                      ),

                      LayoutBuilder(
                        builder:
                            (BuildContext context, BoxConstraints constraints) {
                          double screenWidth = constraints.maxWidth;
                          int crossAxisCount = 4;
                          double childAspectRatio = 0.8;
                          double cardHeight = height / 4.5;

                          if (screenWidth > 1300) {
                            // Desktop view
                            crossAxisCount = 6;
                            childAspectRatio = 2;
                            cardHeight = height / 3;
                          } else if (screenWidth > 1200 && screenWidth < 1300) {
                            // Desktop view
                            crossAxisCount = 5;
                            childAspectRatio = 2;
                            cardHeight = height / 3.5;
                          } else if (screenWidth > 1000 && screenWidth < 1200) {
                            // Tablet view
                            crossAxisCount = 5;
                            childAspectRatio = 2;
                            cardHeight = height / 3.5;
                          } else if (screenWidth > 800 && screenWidth < 1000) {
                            crossAxisCount = 4;
                            childAspectRatio = 2;
                            cardHeight = height / 4.5;
                          } else if (screenWidth > 600) {
                            crossAxisCount = 3;
                            childAspectRatio = 1.5;
                            cardHeight = height / 4.5;
                          } else if (screenWidth > 500) {
                            crossAxisCount = 3;
                            childAspectRatio = 1;
                            cardHeight = height / 4.5;
                          } else if (screenWidth > 350) {
                            crossAxisCount = 3;
                            childAspectRatio = 1;
                            cardHeight = height / 4.5;
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CarouselSlider(
                                options: CarouselOptions(
                                  animateToClosest: true,
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  pageSnapping: true,
                                  autoPlay: true,
                                  aspectRatio: 1,
                                  height: cardHeight,
                                  enlargeCenterPage: true,
                                  autoPlayCurve: Curves.easeInOutCubic,
                                ),
                                disableGesture: false,
                                items: const [
                                  Card1(),
                                  Card2(),
                                  Card1(),
                                ],
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              SizedBox(
                                height: height / 40,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 15),
                                child: Text(
                                  "Categories",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: foodCategoriesList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: childAspectRatio,
                                  crossAxisCount: crossAxisCount,
                                ),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      _goToPage(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 238, 255, 234),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color.fromARGB(
                                                  17, 0, 0, 0),
                                              blurRadius: 1,
                                              spreadRadius: 3,
                                              offset: Offset(2, 2),
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            foodCategoriesList[index]["image"],
                                            height: 50,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8.0),
                                            child: Text(
                                              foodCategoriesList[index]["name"],
                                              style: GoogleFonts.poppins(),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(
                        height: height / 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MealsCategories(
                                height: height,
                                categories: categories,
                                width: width,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: height / 15,
                          margin: EdgeInsets.all(2),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(17, 0, 0, 0),
                                blurRadius: 1,
                                spreadRadius: 2,
                                offset: Offset(0, 0),
                              ),
                            ],
                            color: const Color.fromARGB(255, 238, 255, 234),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.category_rounded),
                              SizedBox(width: width / 40),
                              Text(
                                "Other Categories",
                                style: GoogleFonts.poppins(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: height / 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Menu",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              // AppLocalizations.of(context)!.viewMore,
                              'View More',
                              style: GoogleFonts.poppins(
                                  color: AppColors.darkOrange,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      PopulerMenu(height: height, width: width),
                      SizedBox(
                        height: height / 80,
                      ),
                      PopulerMenu(height: height, width: width),
                      // DefaultTabController(
                      //   length: 7,
                      //   child: Column(
                      //     children: <Widget>[
                      //       ButtonsTabBar(
                      //         height: height / 18,
                      //         duration: 800,
                      //         contentPadding:
                      //             const EdgeInsets.symmetric(horizontal: 20),
                      //         backgroundColor: AppColors.darkGreen,
                      //         unselectedBackgroundColor:
                      //             const Color.fromARGB(207, 220, 243, 217),
                      //         unselectedLabelStyle:
                      //             const TextStyle(color: Colors.black),
                      //         labelStyle: const TextStyle(
                      //             color: Colors.white,
                      //             fontWeight: FontWeight.bold),
                      //         tabs: const [
                      //           Tab(text: "Chicken Meals"),
                      //           Tab(text: "Canadian Meals"),
                      //           Tab(text: "Hot Coffees"),
                      //           Tab(text: "Iced Coffees"),
                      //           Tab(text: "Dessert Meals"),
                      //           Tab(text: "Meal's Categories"),
                      //           Tab(text: "Nearest Restrorent"),
                      //         ],
                      //       ),
                      //       SizedBox(
                      //         height: height / 0.40,
                      //         child: TabBarView(
                      //           physics: const NeverScrollableScrollPhysics(),
                      //           children: <Widget>[
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 14.0),
                      //               child: MainMeals(
                      //                 height: height,
                      //                 meals: meals,
                      //                 mealPrice: mealPrice,
                      //                 nearestRestaurant: nearestRestaurant,
                      //                 width: width,
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 14.0),
                      //               child: CanadianMeals(
                      //                 height: height,
                      //                 canadianMeal: canadianMeal,
                      //                 canadianMealPrice: canadianMealPrice,
                      //                 nearestRestaurant:
                      //                     canadianMealNearestRestaurant,
                      //                 width: width,
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 14.0),
                      //               child: HotCoffeesData(
                      //                 height: height,
                      //                 hotCoffee: coffee,
                      //                 width: width,
                      //                 nearestRestaurant:
                      //                     hotCoffeeNearestRestaurant,
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 14.0),
                      //               child: IcedCoffeesData(
                      //                 height: height,
                      //                 icedCoffee: icedCoffee,
                      //                 width: width,
                      //                 nearestRestaurant:
                      //                     icedCoffeeNearestRestaurant,
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 14.0),
                      //               child: DessertMeals(
                      //                 height: height,
                      //                 dessertMeals: dessertMeals,
                      //                 dessertMealPrice: dessertPrice,
                      //                 nearestRestaurant:
                      //                     dessertNearestRestaurant,
                      //                 width: width,
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 14.0),
                      //               child: MealsCategories(
                      //                 height: height,
                      //                 categories: categories,
                      //                 width: width,
                      //               ),
                      //             ),
                      //             Padding(
                      //               padding: const EdgeInsets.only(top: 14.0),
                      //               child: NearestRestauranst(
                      //                 height: height,
                      //                 nearestRestaurant: nearestRestaurant,
                      //                 width: width,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
