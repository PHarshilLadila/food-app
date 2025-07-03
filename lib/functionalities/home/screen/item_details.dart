// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:food_app/constant/app_button.dart';
// import 'package:food_app/constant/app_colors.dart';
// import 'package:food_app/constant/app_gredient_text.dart';
// import 'package:food_app/functionalities/home/provider/home_provider.dart';
// import 'package:food_app/functionalities/home/widget/review/review_form.dart';
// import 'package:food_app/utils/utils.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:toastification/toastification.dart';

// class ItemDetails extends StatefulWidget {
//   final String? itemId;
//   final String? itemname;
//   final String? itemImage;
//   final String? itemDescription;
//   final double? itemPrice;
//   final String? restroName;
//   final String? restroImg;
//   final String? foodCategory;

//   const ItemDetails({
//     super.key,
//     this.itemname,
//     this.itemImage,
//     this.itemDescription,
//     this.itemPrice,
//     this.itemId,
//     this.restroName,
//     this.restroImg,
//     this.foodCategory,
//   });

//   @override
//   State<ItemDetails> createState() => _ItemDetailsState();
// }

// class _ItemDetailsState extends State<ItemDetails>
//     with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     double width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       extendBodyBehindAppBar: true,
//       resizeToAvoidBottomInset:
//           true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         leading: GestureDetector(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 12),
//             child: Container(
//               margin: EdgeInsets.all(2),
//               decoration: BoxDecoration(
//                 color: AppColors.extraLightGreen,
//                 borderRadius: BorderRadius.circular(15),
//                 border: Border.all(
//                   color: AppColors.lightGreen,
//                   width: 0.5,
//                 ),
//               ),
//               child: const Icon(
//                 Icons.arrow_back_ios_new,
//                 color: AppColors.darkGreen,
//               ),
//             ),
//           ),
//         ),
//         title: GradientText(
//           widget.itemname ?? "",
//           style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
//           gradient: const LinearGradient(
//             colors: [
//               AppColors.lightGreen,
//               AppColors.darkGreen,
//             ],
//           ),
//         ),
//         flexibleSpace: Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: Colors.transparent,
//             image: DecorationImage(
//               colorFilter: ColorFilter.mode(
//                   Colors.white.withOpacity(0.4), BlendMode.dstATop),
//               image: AssetImage("assets/images/Pattern.png"),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//           scrollDirection: Axis.vertical,
//           physics: const BouncingScrollPhysics(),
//           child: LayoutBuilder(
//             builder: (BuildContext context, BoxConstraints constraints) {
//               double screenWidth = constraints.maxWidth;
//               double imgHeight = height / 3;
//               double imgWidth = width / 2;

//               if (screenWidth > 1300) {
//                 imgHeight = height / 2;
//                 imgWidth = width / 5.5;
//               } else if (screenWidth > 1200 && screenWidth < 1300) {
//                 imgHeight = height / 2;
//                 imgWidth = width / 4;
//               } else if (screenWidth > 1000 && screenWidth < 1200) {
//                 imgHeight = height / 2.5;
//                 imgWidth = width / 3.5;
//               } else if (screenWidth > 800 && screenWidth < 1000) {
//                 imgHeight = height / 3;
//                 imgWidth = width / 3;
//               } else if (screenWidth > 600) {
//                 imgHeight = height / 3.5;
//                 imgWidth = width / 2.5;
//               } else if (screenWidth > 500) {
//                 imgHeight = height / 3.5;
//                 imgWidth = width / 2;
//               } else if (screenWidth > 350) {
//                 imgHeight = height / 4;
//                 imgWidth = width / 2;
//               }

//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   SizedBox(height: 15),
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: widget.itemImage!.startsWith("http")
//                         ? Image.network(
//                             widget.itemImage ?? "",
//                             height: imgHeight,
//                             width: imgWidth,
//                             fit: BoxFit.cover,
//                           )
//                         : Image.asset(
//                             widget.itemImage ?? "",
//                             height: imgHeight,
//                             width: imgWidth,
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                   SizedBox(height: 15),
//                   BottomSheet(
//                     elevation: 15,
//                     showDragHandle: true,
//                     enableDrag: false,
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     onClosing: () {},
//                     builder: (BuildContext context) {
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 14),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   decoration: BoxDecoration(
//                                       shape: BoxShape.rectangle,
//                                       borderRadius: BorderRadius.circular(15),
//                                       color: const Color.fromARGB(
//                                           255, 243, 255, 239)),
//                                   child: Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: width / 25,
//                                         vertical: height / 60),
//                                     child: const Text("Popular"),
//                                   ),
//                                 ),
//                                 const Spacer(),
//                                 SizedBox(
//                                   width: width / 50,
//                                 ),
//                                 Column(
//                                   children: [
//                                     Container(
//                                       decoration: const BoxDecoration(
//                                           shape: BoxShape.circle,
//                                           color: Color.fromARGB(
//                                               255, 243, 255, 239)),
//                                       child: const Padding(
//                                         padding: EdgeInsets.all(15.0),
//                                         child: FaIcon(
//                                           FontAwesomeIcons.locationDot,
//                                           color: AppColors.darkGreen,
//                                         ),
//                                       ),
//                                     ),
//                                     Text(
//                                       widget.restroName ?? "",
//                                       style: GoogleFonts.poppins(
//                                           color: AppColors.blackColor,
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: height / 40,
//                             ),
//                             Text(
//                               widget.itemname ?? "",
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.blackColor,
//                                   fontSize: 35,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Text(
//                               "\$ ${widget.itemPrice.toString()}",
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.darkGreen,
//                                   fontSize: 35,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(
//                               height: height / 80,
//                             ),
//                             Text(
//                               widget.itemDescription ?? "",
//                               style: GoogleFonts.poppins(
//                                   color: AppColors.blackColor,
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w500),
//                               textAlign: TextAlign.start,
//                             ),
//                             SizedBox(
//                               height: height / 80,
//                             ),
//                             ReviewForm(
//                               itemId: "${widget.itemId}",
//                               foodName: "${widget.itemname}",
//                               foodCategory:
//                                   widget.foodCategory ?? "category not found",
//                             ),
//                             SizedBox(
//                               height: height / 20,
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   SizedBox(
//                     height: height / 15,
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0),
//         child: CustomeButton(
//           name: "Add To Cart",
//           heights: height / 18,
//           widths: double.infinity,
//           ontap: () {
//             Provider.of<HomeProvider>(context, listen: false).addToCart(
//               widget.itemId!,
//               widget.itemname!,
//               widget.itemImage!,
//               widget.itemDescription!,
//               widget.itemPrice!.toDouble(),
//               widget.restroName!,
//             );

//             appTostMessage(
//               context,
//               ToastificationType.success,
//               "Yup..! ${widget.itemname!} added to cart Successfully.",
//               "assets/images/done.png",
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/widget/review/review_form.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:food_app/utils/theme/provider/app_theme_provider.dart';

class ItemDetails extends StatefulWidget {
  final String? itemId;
  final String? itemname;
  final String? itemImage;
  final String? itemDescription;
  final double? itemPrice;
  final String? restroName;
  final String? restroImg;
  final String? foodCategory;

  const ItemDetails({
    super.key,
    this.itemname,
    this.itemImage,
    this.itemDescription,
    this.itemPrice,
    this.itemId,
    this.restroName,
    this.restroImg,
    this.foodCategory,
  });

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isLightTheme = themeProvider.themeData.brightness == Brightness.light;
    final backgroundColor =
        isLightTheme ? AppColors.whiteColor : const Color(0xFF232323);
    final textColor = isLightTheme ? AppColors.blackColor : Colors.white;
    final secondaryTextColor = isLightTheme ? Colors.black54 : Colors.white70;
    final cardColor = isLightTheme ? Colors.white : const Color(0xFF333739);
    final lightGreenBg = isLightTheme
        ? const Color.fromARGB(255, 243, 255, 239)
        : const Color(0xFF1E3A1E);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 12),
            child: Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isLightTheme
                    ? AppColors.extraLightGreen
                    : const Color(0xFF1E3A1E),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.lightGreen,
                  width: 0.5,
                ),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: isLightTheme ? AppColors.darkGreen : Colors.white,
              ),
            ),
          ),
        ),
        title: GradientText(
          widget.itemname ?? "",
          style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.bold),
          gradient: const LinearGradient(
            colors: [AppColors.lightGreen, AppColors.darkGreen],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  isLightTheme
                      ? Colors.white.withOpacity(0.4)
                      : Colors.black.withOpacity(0.3),
                  BlendMode.dstATop),
              image: const AssetImage("assets/images/Pattern.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          physics: const BouncingScrollPhysics(),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              double imgHeight =
                  _calculateImageHeight(constraints.maxWidth, height);
              double imgWidth =
                  _calculateImageWidth(constraints.maxWidth, width);

              return Column(
                children: [
                  const SizedBox(height: 15),
                  _buildItemImage(imgHeight, imgWidth),
                  const SizedBox(height: 15),
                  _buildItemDetails(
                    context,
                    height,
                    width,
                    cardColor,
                    lightGreenBg,
                    textColor,
                    secondaryTextColor,
                  ),
                  SizedBox(height: height / 15),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: CustomeButton(
          name: "Add To Cart",
          heights: height / 18,
          widths: double.infinity,
          ontap: _addToCart,
        ),
      ),
    );
  }

  double _calculateImageHeight(double screenWidth, double height) {
    if (screenWidth > 1300) return height / 2;
    if (screenWidth > 1200) return height / 2;
    if (screenWidth > 1000) return height / 2.5;
    if (screenWidth > 800) return height / 3;
    if (screenWidth > 600) return height / 3.5;
    if (screenWidth > 500) return height / 3.5;
    return height / 4;
  }

  double _calculateImageWidth(double screenWidth, double width) {
    if (screenWidth > 1300) return width / 5.5;
    if (screenWidth > 1200) return width / 4;
    if (screenWidth > 1000) return width / 3.5;
    if (screenWidth > 800) return width / 3;
    if (screenWidth > 600) return width / 2.5;
    if (screenWidth > 500) return width / 2;
    return width / 2;
  }

  Widget _buildItemImage(double height, double width) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: widget.itemImage!.startsWith("http")
          ? CachedNetworkImage(
              height: height,
              width: width,
              imageUrl: widget.itemImage ?? "",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              placeholder: (context, url) => Center(
                child: myProccesser(),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )

          //  Image.network(
          //     widget.itemImage ?? "",
          //     height: height,
          //     width: width,
          //     fit: BoxFit.cover,
          //   )
          : Image.asset(
              widget.itemImage ?? "",
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget _buildItemDetails(
    BuildContext context,
    double height,
    double width,
    Color cardColor,
    Color lightGreenBg,
    Color textColor,
    Color secondaryTextColor,
  ) {
    return BottomSheet(
      elevation: 15,
      showDragHandle: true,
      enableDrag: false,
      backgroundColor: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      onClosing: () {},
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildItemHeader(height, width, lightGreenBg, textColor),
              SizedBox(height: height / 40),
              Text(
                widget.itemname ?? "",
                style: GoogleFonts.poppins(
                  color: textColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "\$ ${widget.itemPrice.toString()}",
                style: GoogleFonts.poppins(
                  color: AppColors.darkGreen,
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: height / 80),
              Text(
                widget.itemDescription ?? "",
                style: GoogleFonts.poppins(
                  color: secondaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: height / 80),
              ReviewForm(
                itemId: "${widget.itemId}",
                foodName: "${widget.itemname}",
                foodCategory: widget.foodCategory ?? "category not found",
              ),
              SizedBox(height: height / 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItemHeader(
    double height,
    double width,
    Color lightGreenBg,
    Color textColor,
  ) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: lightGreenBg,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width / 25,
              vertical: height / 60,
            ),
            child: Text(
              "Popular",
              style: TextStyle(color: textColor),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(width: width / 50),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: lightGreenBg,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: FaIcon(
                  FontAwesomeIcons.locationDot,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
            Text(
              widget.restroName ?? "",
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _addToCart() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    homeProvider.addToCart(
      widget.itemId!,
      widget.itemname!,
      widget.itemImage!,
      widget.itemDescription!,
      widget.itemPrice!.toDouble(),
      widget.restroName!,
    );

    appTostMessage(
      context,
      ToastificationType.success,
      "Yup..! ${widget.itemname!} added to cart Successfully.",
      "assets/images/done.png",
    );
  }
}
