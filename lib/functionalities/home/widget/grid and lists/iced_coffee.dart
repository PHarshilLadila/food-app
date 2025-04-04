import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/home/model/hot_coffee_model.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/screen/item_details.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IcedCoffeesData extends StatefulWidget {
  final double width;
  final double height;
  final List<CoffeeModel> icedCoffee;
  final List<Map<String, dynamic>> nearestRestaurant;

  const IcedCoffeesData({
    super.key,
    required this.width,
    required this.height,
    required this.icedCoffee,
    required this.nearestRestaurant,
  });

  @override
  State<IcedCoffeesData> createState() => _IcedCoffeesDataState();
}

class _IcedCoffeesDataState extends State<IcedCoffeesData> {
  @override
  void initState() {
    super.initState();
  }

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
          itemCount: widget.icedCoffee.length,
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
                      itemDescription:
                          widget.icedCoffee[index].description ?? "",
                      itemImage: widget.icedCoffee[index].image ?? "",
                      itemname: widget.icedCoffee[index].title ?? "",
                      itemPrice: widget.icedCoffee[index].price!.toDouble(),
                      itemId: widget.icedCoffee[index].id.toString(),
                      restroName: widget.nearestRestaurant[index]['name'],
                      restroImg: widget.nearestRestaurant[index]['image'],
                    ),
                  ),
                ),
                child: Consumer<HomeProvider>(
                  builder: (context, provider, child) {
                    debugPrint("${widget.icedCoffee.length}");
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
                                  provider.icedCoffee[index].image!,
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
                                  height: widget.height / 18,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: AutoSizeText(
                                        "\$ ${provider.icedCoffee[index].price.toString()}",
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
                                top: 5,
                                right: 5,
                                child: GestureDetector(
                                  onTap: () {
                                    provider.toggleFavoriteStatus(
                                      provider.icedCoffee[index].id.toString(),
                                      provider.icedCoffee[index].price
                                          .toString(),
                                      widget.nearestRestaurant[index]['name'],
                                      widget.nearestRestaurant[index]['image'],
                                    );
                                    debugPrint("${widget.icedCoffee.length}");
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: FaIcon(
                                      FontAwesomeIcons.solidHeart,
                                      color:
                                          provider.icedCoffee[index].isFavorite
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
                            height: widget.height / 100,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: widget.width / 2.8,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AutoSizeText(
                                      provider.icedCoffee[index].title!,
                                      minFontSize: 18,
                                      maxFontSize: 18,
                                      style: GoogleFonts.poppins(
                                        fontSize: widget.width / 23,
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
                                        widget.nearestRestaurant[index]
                                            ['image'],
                                        height: widget.height / 35,
                                      ),
                                      SizedBox(
                                        width: widget.width / 100,
                                      ),
                                      AutoSizeText(
                                        widget.nearestRestaurant[index]['name'],
                                        minFontSize: 14,
                                        maxFontSize: 18,
                                        style: GoogleFonts.poppins(
                                            color: AppColors.lightGreen,
                                            fontSize: widget.width / 35,
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
