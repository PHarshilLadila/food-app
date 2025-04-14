import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/cart/screens/cart_screen.dart';
import 'package:food_app/functionalities/home/helper/list_data.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/screen/item_details.dart';
import 'package:food_app/functionalities/home/widget/drag_note.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class CatPasta extends StatefulWidget {
  const CatPasta({super.key});

  @override
  State<CatPasta> createState() => _CatPastaState();
}

class _CatPastaState extends State<CatPasta> {
  bool _isDropped = false;
  Map<String, dynamic>? _droppedItem;

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
                Colors.white.withOpacity(0.4),
                BlendMode.dstATop),
            image: const AssetImage(
              "assets/images/Pattern.png",
            ),
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
                        'Pasta',
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
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double screenWidth = constraints.maxWidth;
                      int crossAxisCount = 2;
                      double childAspectRatio = 0.7;
                      double widthSize = width / 3;

                      if (screenWidth > 1300) {
                        debugPrint("screenWidth > 1300");

                        // Desktop view
                        crossAxisCount = 6;
                        childAspectRatio = 0.7;
                        widthSize = width / 8;
                      } else if (screenWidth > 1200 && screenWidth < 1300) {
                        debugPrint("screenWidth > 1200 && screenWidth < 1300");

                        // Desktop view
                        crossAxisCount = 6;
                        childAspectRatio = 0.5;
                        widthSize = width / 8;
                      } else if (screenWidth > 1000 && screenWidth < 1200) {
                        debugPrint("screenWidth > 1000 && screenWidth < 1200");
                        // Tablet view
                        crossAxisCount = 5;
                        childAspectRatio = 0.6;
                        widthSize = width / 5;
                      } else if (screenWidth > 800 && screenWidth < 1000) {
                        debugPrint("screenWidth > 800 && screenWidth < 1000");

                        crossAxisCount = 4;
                        childAspectRatio = 0.6;
                        widthSize = width / 4;
                      } else if (screenWidth > 600) {
                        debugPrint("screenWidth > 600 ");

                        crossAxisCount = 3;
                        childAspectRatio = 0.6;
                        widthSize = width / 3.5;
                      } else if (screenWidth > 500) {
                        debugPrint("screenWidth > 500");

                        crossAxisCount = 2;
                        childAspectRatio = 0.65;
                        widthSize = width / 3;
                      } else if (screenWidth > 350) {
                        debugPrint("screenWidth > 350");

                        crossAxisCount = 2;
                        childAspectRatio = 0.6;
                        widthSize = width / 3;
                      }

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(8.0),
                        itemCount: pastaMenu.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,
                          childAspectRatio: childAspectRatio,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, index) {
                          return LongPressDraggable<Map<String, dynamic>>(
                            data: {
                              "itemName": pastaMenu[index]['name'],
                              "itemPrice": pastaMenu[index]['price'],
                              "itemImage": pastaMenu[index]['imageUrl'],
                              "itemId": pastaMenu[index]['id'].toString(),
                              "itemDiscription": pastaMenu[index]
                                  ['description'],
                              "itemRestro": pastaMenu[index]
                                  ['nearestRestaurant'],
                              "itemRestroImg": pastaMenu[index]
                                  ['restaurantImageUrl'],
                            },
                            feedback: Material(
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor.withOpacity(0.8),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                              pastaMenu[index]['imageUrl'],
                                              width: widthSize,
                                              height: height / 6,
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
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: AutoSizeText(
                                                    "\$ ${pastaMenu[index]['price']}",
                                                    minFontSize: 16,
                                                    maxFontSize: 18,
                                                    style: GoogleFonts.poppins(
                                                        color:
                                                            AppColors.darkGreen,
                                                        fontSize: width / 19,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                pastaMenu[index]['name'],
                                                textAlign: TextAlign.start,
                                                minFontSize: 16,
                                                maxFontSize: 16,
                                                style: GoogleFonts.poppins(
                                                    color: AppColors.blackColor,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            pastaMenu[index]['imageUrl'],
                                            fit: BoxFit.cover,
                                            width: widthSize,
                                            height: height / 6,
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
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: AutoSizeText(
                                                  "\$ ${pastaMenu[index]['price']}",
                                                  minFontSize: 16,
                                                  maxFontSize: 18,
                                                  style: GoogleFonts.poppins(
                                                      color:
                                                          AppColors.darkGreen,
                                                      fontSize: width / 19,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              pastaMenu[index]['name'],
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
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ItemDetails(
                                      itemDescription: pastaMenu[index]
                                          ['description'],
                                      itemImage:
                                          pastaMenu[index]['imageUrl'] ?? "",
                                      itemname: pastaMenu[index]['name'] ?? "",
                                      itemPrice:
                                          pastaMenu[index]['price'].toDouble(),
                                      itemId: pastaMenu[index]['id'].toString(),
                                      restroName: pastaMenu[index]
                                          ['nearestRestaurant'],
                                      restroImg: pastaMenu[index]
                                          ['restaurantImageUrl'],
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.asset(
                                              pastaMenu[index]['imageUrl'],
                                              width: widthSize,
                                              height: height / 6,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Positioned(
                                            bottom: -10,
                                            left: -18,
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
                                              height: height / 14,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: AutoSizeText(
                                                    "\$ ${pastaMenu[index]['price'].toString()}",
                                                    minFontSize: 15,
                                                    maxFontSize: 15,
                                                    style: GoogleFonts.poppins(
                                                        color:
                                                            AppColors.darkGreen,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              AutoSizeText(
                                                pastaMenu[index]['name'],
                                                textAlign: TextAlign.start,
                                                minFontSize: 16,
                                                maxFontSize: 16,
                                                style: GoogleFonts.poppins(
                                                    color: AppColors.blackColor,
                                                    fontSize: width / 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipOval(
                                                    child: Image.asset(
                                                      pastaMenu[index][
                                                          'restaurantImageUrl'],
                                                      height: height / 22,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  SizedBox(width: width / 60),
                                                  Flexible(
                                                    child: AutoSizeText(
                                                      pastaMenu[index]
                                                          ['nearestRestaurant'],
                                                      textAlign:
                                                          TextAlign.start,
                                                      minFontSize: 14,
                                                      maxFontSize: 14,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: AppColors
                                                                  .blackColor,
                                                              fontSize:
                                                                  width / 30,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ),
                                                ],
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
                    //     content:
                    //         Text('${data["itemName"]} added to cart Button!'),
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                            _droppedItem?["itemPrice"].toDouble(),
                            _droppedItem?["itemRestro"],
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ),
                          );
                        },
                        // child: DroppedCartButton(
                        //   height: height,
                        //   width: width,
                        //   droppedItem: _droppedItem,
                        //   isDropped: _isDropped,
                        // ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                              colorFilter: ColorFilter.mode(
                                  Colors.white.withOpacity(0.5),
                                  BlendMode.dstATop),
                              image: const AssetImage(
                                "assets/images/Pattern.png",
                              ),
                            ),
                          ),
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: Radius.circular(15),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: height / 100, horizontal: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Add to Cart (drag & drop)",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.infoCircle,
                                        size: 14,
                                        color: Colors.black,
                                      ),
                                      SizedBox(
                                        width: width / 60,
                                      ),
                                      AutoSizeText(
                                        "Note ",
                                        minFontSize: 16,
                                        maxFontSize: 16,
                                        style: GoogleFonts.poppins(
                                            color: AppColors.blackColor,
                                            fontSize: width / 25,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Flexible(
                                        child: AutoSizeText(
                                          " : Tap Here for Add This Item in to Cart.",
                                          minFontSize: 14,
                                          maxFontSize: 14,
                                          style: GoogleFonts.poppins(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height / 100,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.asset(
                                            _droppedItem?["itemImage"] ??
                                                "assets/images/draggs.png",
                                            height: height / 14,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width / 50,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: width / 2,
                                            child: Text(
                                              _isDropped
                                                  ? '${_droppedItem?["itemName"] ?? ""}'
                                                  : 'Drag and Drop Here',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.black87,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2.0),
                                            child: Text(
                                              _isDropped
                                                  ? '\$ ${_droppedItem?["itemPrice"] ?? ""}'
                                                  : ' ',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.green),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          SizedBox(
                                            width: width / 2,
                                            child: Text(
                                              _isDropped
                                                  ? '${_droppedItem?["itemDiscription"] ?? ""}'
                                                  : ' ',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16,
                                                  color: Colors.black38),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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
        ),
      ),
    );
  }
}
