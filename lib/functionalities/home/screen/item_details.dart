import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ItemDetails extends StatefulWidget {
  final String? itemId;
  final String? itemname;
  final String? itemImage;
  final String? itemDescription;
  final double? itemPrice;
  final String? restroName;
  final String? restroImg;

  const ItemDetails({
    super.key,
    this.itemname,
    this.itemImage,
    this.itemDescription,
    this.itemPrice,
    this.itemId,
    this.restroName,
    this.restroImg,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 12),
            child: Container(
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: AppColors.extraLightGreen,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.lightGreen,
                  width: 0.5,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.darkGreen,
              ),
            ),
          ),
        ),
        title: GradientText(
          // AppLocalizations.of(context)!.homeTitle,
          widget.itemname ?? "",
          style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
          gradient: const LinearGradient(
            colors: [
              AppColors.lightGreen,
              AppColors.darkGreen,
            ],
          ),
        ),
        flexibleSpace: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(0.4), BlendMode.dstATop),
                image: AssetImage("assets/images/Pattern.png"),
                fit: BoxFit.cover),
          ),
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double screenWidth = constraints.maxWidth;
                  double imgHeight = height / 3;
                  double imgWidth = width / 2;

                  if (screenWidth > 1300) {
                    imgHeight = height / 2;
                    imgWidth = width / 5.5;
                    debugPrint("screenWidth > 1300");
                  } else if (screenWidth > 1200 && screenWidth < 1300) {
                    imgHeight = height / 2;
                    imgWidth = width / 4;
                    debugPrint("screenWidth > 1200 && screenWidth < 1300");
                  } else if (screenWidth > 1000 && screenWidth < 1200) {
                    imgHeight = height / 2.5;
                    imgWidth = width / 3.5;
                    debugPrint("screenWidth > 1000 && screenWidth < 1200");
                  } else if (screenWidth > 800 && screenWidth < 1000) {
                    imgHeight = height / 3;
                    imgWidth = width / 3;
                    debugPrint("screenWidth > 800 && screenWidth < 1000");
                  } else if (screenWidth > 600) {
                    imgHeight = height / 3.5;
                    imgWidth = width / 2.5;
                    debugPrint("screenWidth > 600 ");
                  } else if (screenWidth > 500) {
                    imgHeight = height / 3.5;
                    imgWidth = width / 2;
                    debugPrint("screenWidth > 500");
                  } else if (screenWidth > 350) {
                    imgHeight = height / 4;
                    imgWidth = width / 2;
                    debugPrint("screenWidth > 350");
                  }

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: widget.itemImage!.startsWith("http")
                            ? Image.network(
                                widget.itemImage ?? "",
                                height: imgHeight,
                                width: imgWidth,
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                widget.itemImage ?? "",
                                height: imgHeight,
                                width: imgWidth,
                                fit: BoxFit.cover,
                              ),
                      ),
                      SizedBox(height: 15),
                      BottomSheet(
                        elevation: 15,
                        showDragHandle: true,
                        enableDrag: false,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onClosing: () {},
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: const Color.fromARGB(
                                              255, 243, 255, 239)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width / 25,
                                            vertical: height / 60),
                                        child: const Text("Popular"),
                                      ),
                                    ),
                                    const Spacer(),
                                    SizedBox(
                                      width: width / 50,
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color.fromARGB(
                                                  255, 243, 255, 239)),
                                          child: const Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.locationDot,
                                              color: AppColors.darkGreen,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          widget.restroName ?? "",
                                          style: GoogleFonts.poppins(
                                              color: AppColors.blackColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: height / 40,
                                ),
                                Text(
                                  widget.itemname ?? "",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.blackColor,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "\$ ${widget.itemPrice.toString()}",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.darkGreen,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: height / 80,
                                ),
                                RatingBars(
                                  itemid: widget.itemId,
                                ),
                                SizedBox(
                                  height: height / 80,
                                ),
                                Text(
                                  widget.itemDescription ?? "",
                                  style: GoogleFonts.poppins(
                                      color: AppColors.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: height / 20,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: height / 15,
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: CustomeButton(
          name: "Add To Cart",
          heights: height / 18,
          widths: double.infinity,
          ontap: () {
            Provider.of<HomeProvider>(context, listen: false).addToCart(
              widget.itemId!,
              widget.itemname!,
              widget.itemImage!,
              widget.itemDescription!,
              widget.itemPrice!.toDouble(),
              widget.restroName!,
            );
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     padding: const EdgeInsets.all(15),
            //     shape: BeveledRectangleBorder(
            //         borderRadius: BorderRadius.circular(5)),
            //     backgroundColor: AppColors.darkGreen,
            //     dismissDirection: DismissDirection.endToStart,
            //     behavior: SnackBarBehavior.floating,
            //     content: Text(
            //       "Yup..! ${widget.itemname!} added to cart Successfully.",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // );
            appTostMessage(
              context,
              ToastificationType.success,
              "Yup..! ${widget.itemname!} added to cart Successfully.",
              "assets/images/done.png",
            );
          },
        ),
      ),
    );
  }
}

class RatingBars extends StatelessWidget {
  final String? itemid;
  const RatingBars({
    super.key,
    this.itemid,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      glowColor: const Color.fromARGB(255, 191, 183, 108),
      updateOnDrag: true,
      itemCount: 5,
      itemSize: 30.0,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) async {
        final ratingBox = await Hive.openBox("ratingData");

        await ratingBox.put("ratingData", rating);
        debugPrint("rating data ==> $rating");

        await ratingBox.putAll(
          {
            "itemId": itemid,
            "ratingData": rating,
          },
        );

        double getRating = await ratingBox.get("ratingData");

        var getAllRating = ratingBox.toMap();

        debugPrint(getAllRating.toString());

        debugPrint("==> ${getRating.toString()}");
      },
    );
  }
}
