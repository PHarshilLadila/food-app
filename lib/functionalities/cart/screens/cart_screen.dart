// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
import 'package:food_app/functionalities/cart/widget/oreder_row.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/track%20order/screens/track_order.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double? totalofIndexItems = 0;
  double? itemdiscount = 0;
  double? finalTotal = 0;
  double? itemList = 0;

  Future<List<Map<String, dynamic>>> _fetchCartItems() async {
    final databaseBox = await Provider.of<HomeProvider>(context, listen: false)
        .firestore
        .collection("users")
        .doc(await Hive.box('userProfile').get('userid'))
        .collection("cart")
        .get();

    return databaseBox.docs.map((doc) {
      var data = doc.data();
      data["docId"] = doc.id;
      return data;
    }).toList();
  }

  Future<void> _updateQuantity(String docId, int newQuantity) async {
    final cartRef = Provider.of<HomeProvider>(context, listen: false)
        .firestore
        .collection("users")
        .doc(await Hive.box('userProfile').get('userid'))
        .collection("cart");

    if (newQuantity <= 0) {
      await cartRef.doc(docId).delete();
    } else {
      await cartRef.doc(docId).update(
        {
          "quantity": newQuantity,
        },
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPaymentData();
    totalofIndexItems;
  }

  Future<void> getPaymentData() async {
    var cartItems = await _fetchCartItems();

    setState(() {
      totalofIndexItems = 0;
      itemdiscount = 0;
      finalTotal = 0;
      itemList = 0;

      for (var item in cartItems) {
        var itemPrice = item["itemPrice"] * item["quantity"];
        totalofIndexItems = totalofIndexItems! + itemPrice;
        itemList = item.length.toDouble();
      }

      itemdiscount = (totalofIndexItems! * 5.0) / 100;
      finalTotal = ((totalofIndexItems! + 6.0) - itemdiscount!);
    });
  }

  List<Map<String, dynamic>>? allCartData = [];
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
                  Colors.white.withOpacity(0.1), BlendMode.dstATop),
              image: const AssetImage(
                "assets/images/Pattern.png",
              ),
              fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: GradientText(
                          // "Manage Your Cart Here",
                          AppLocalizations.of(context)!.cartTitle,
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
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => OrederScreen(),
                          //     ));
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
                              width: width / 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height / 40,
                  ),
                  Text(
                    // "Cart Items",
                    AppLocalizations.of(context)!.cartItem,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: height / 100,
                  ),
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      double screenWidth = constraints.maxWidth;
                      double imageHeight = height / 5;
                      double imagewidth = width / 5;
                      double paddingWidth = width / 40;
                      double sizedBoxWidth = width / 2.5;

                      if (screenWidth > 1300) {
                        debugPrint("screenWidth > 1300");
                        imagewidth = width / 11;
                        imageHeight = height / 7;

                        sizedBoxWidth = width / 2.5;
                        paddingWidth = width / 60;
                      } else if (screenWidth > 1200 && screenWidth < 1300) {
                        imagewidth = width / 10;
                        imageHeight = height / 8;

                        sizedBoxWidth = width / 2.5;
                        paddingWidth = width / 60;

                        debugPrint("screenWidth > 1200 && screenWidth < 1300");
                      } else if (screenWidth > 1000 && screenWidth < 1200) {
                        imagewidth = width / 9;
                        imageHeight = height / 8;

                        sizedBoxWidth = width / 3;
                        paddingWidth = width / 40;

                        debugPrint("screenWidth > 1000 && screenWidth < 1200");
                        // Tablet view
                      } else if (screenWidth > 800 && screenWidth < 1000) {
                        imagewidth = width / 8;
                        imageHeight = height / 8;

                        sizedBoxWidth = width / 3.5;
                        paddingWidth = width / 40;

                        debugPrint("screenWidth > 800 && screenWidth < 1000");
                      } else if (screenWidth > 600) {
                        imagewidth = width / 7;
                        imageHeight = height / 8;

                        sizedBoxWidth = width / 4;
                        paddingWidth = width / 40;

                        debugPrint("screenWidth > 600 ");
                      } else if (screenWidth > 500) {
                        imagewidth = width / 5;
                        imageHeight = height / 8;

                        sizedBoxWidth = width / 6.5;
                        paddingWidth = width / 40;

                        debugPrint("screenWidth > 500");
                      } else if (screenWidth > 350) {
                        imagewidth = width / 5;
                        imageHeight = height / 8;

                        sizedBoxWidth = width / 8.5;
                        paddingWidth = width / 40;

                        debugPrint("screenWidth > 350");
                      }

                      return FutureBuilder(
                        future: _fetchCartItems(),
                        builder: (context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: Center(child: myProccesser()));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: height / 4),
                                child: Column(
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.cartEmpty,

                                      // "Your cart is empty!",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height / 60,
                                    ),
                                    CustomeButton(
                                      heights: height / 20,
                                      widths: width / 3,
                                      name:
                                          //  "Explore Foods",
                                          AppLocalizations.of(context)!
                                              .exploreFood,
                                      ontap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          List<Map<String, dynamic>> cartItems = snapshot.data!;
                          allCartData = cartItems;

                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  var item = cartItems[index];
                                  var itemPrice =
                                      item["itemPrice"] * item["quantity"];

                                  return Padding(
                                    padding:
                                        EdgeInsets.only(bottom: height / 80),
                                    child: Dismissible(
                                      key: Key(item["docId"]),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              20, 143, 143, 143),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width / 40,
                                            vertical: height / 60,
                                          ),
                                          child: Row(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: item["itemImage"]
                                                        .startsWith("http")
                                                    ? Image.network(
                                                        item["itemImage"],
                                                        height: imageHeight,
                                                        width: imagewidth,
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        item["itemImage"],
                                                        height: imageHeight,
                                                        width: imagewidth,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                              SizedBox(
                                                width: width / 50,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width: width / 3,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          item["itemName"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          maxLines: 1,
                                                          softWrap: false,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Text(
                                                          item["restroName"] ??
                                                              "No Name",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 14,
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        Text(
                                                          "\$ ${item["itemPrice"] ?? "N/A"}",
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 16,
                                                            color: Colors
                                                                .lightGreen,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                        SizedBox(
                                                          height: height / 60,
                                                        ),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              overlayColor:
                                                                  const WidgetStatePropertyAll(
                                                                      Colors
                                                                          .transparent),
                                                              onTap: () {
                                                                getPaymentData();
                                                                _updateQuantity(
                                                                    item[
                                                                        "docId"],
                                                                    item["quantity"] -
                                                                        1);
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      239,
                                                                      239),
                                                                ),
                                                                child:
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10.0),
                                                                  child: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .minus,
                                                                    size: 16,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          paddingWidth),
                                                              child:
                                                                  AutoSizeText(
                                                                "${item["quantity"]}",
                                                                minFontSize: 16,
                                                                maxFontSize: 18,
                                                                style: GoogleFonts.poppins(
                                                                    color: AppColors
                                                                        .blackColor,
                                                                    fontSize:
                                                                        width /
                                                                            18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              overlayColor:
                                                                  const WidgetStatePropertyAll(
                                                                      Colors
                                                                          .transparent),
                                                              onTap: () {
                                                                getPaymentData();
                                                                _updateQuantity(
                                                                    item[
                                                                        "docId"],
                                                                    item["quantity"] +
                                                                        1);
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      239,
                                                                      255,
                                                                      240),
                                                                ),
                                                                child:
                                                                    const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              10.0),
                                                                  child: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .plus,
                                                                    size: 16,
                                                                    color: AppColors
                                                                        .darkGreen,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: sizedBoxWidth,
                                                  ),
                                                  AutoSizeText(
                                                    "\$${itemPrice.toStringAsFixed(2)}",
                                                    minFontSize: 14,
                                                    maxFontSize: 20,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: width / 25,
                                                      color:
                                                          AppColors.darkGreen,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: height / 3.5,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FutureBuilder(
        future: _fetchCartItems(),
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: myProccesser());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SizedBox.shrink();
          }

          List<Map<String, dynamic>> cartItems = snapshot.data!;
          allCartData = cartItems;

          return cartItems.isEmpty
              ? SizedBox()
              : MyFloatingActionButton(
                  height: height,
                  width: width,
                  totalofIndexItems: totalofIndexItems,
                  itemdiscount: itemdiscount,
                  finalTotal: finalTotal,
                  cartData: allCartData,
                  itemList: itemList,
                );
        },
      ),
    );
  }
}

class MyFloatingActionButton extends StatefulWidget {
  const MyFloatingActionButton({
    super.key,
    required this.height,
    required this.width,
    this.totalofIndexItems,
    this.itemdiscount,
    this.finalTotal,
    this.cartData,
    this.itemList,
  });

  final double height;
  final double width;
  final double? totalofIndexItems;
  final double? itemdiscount;
  final double? finalTotal;
  final double? itemList;
  final List<Map<String, dynamic>>? cartData;

  @override
  State<MyFloatingActionButton> createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;

      // Create a new document reference
      DocumentReference orderRef = FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection('ordersDetails')
          .doc();

      // Transform cart data into the required format
      List<Map<String, dynamic>> orderDetails = widget.cartData!
          .map((item) => {
                "itemId": item['itemId'] ?? "N/A",
                "itemName": item['itemName'] ?? "Unknown Item",
                "itemPrice": item['itemPrice'] ?? 0,
                "quantity": item['quantity'] ?? 1,
                "restroName": item['restroName'] ?? "Unknown Restaurant",
                "timestamp": item['timestamp'] ?? FieldValue.serverTimestamp(),
                "itemImage": item['itemImage'] ?? "",
                "itemDescription": item['itemDescription'] ?? "No Description",
              })
          .toList();

      // Log the transformed data for debugging
      debugPrint("Order Details: $orderDetails");
      debugPrint("----******--------********-----* : ${response.paymentId}");
      debugPrint("----******--------********-----* : ${response.data}");
      debugPrint("----******--------********-----* : ${response.orderId}");
      debugPrint("----******--------********-----* : ${response.signature}");

      // Store the order details in Firestore
      await orderRef.set({
        "paymentid": response.paymentId,
        "orderid": orderRef.id,
        "orderDetails": orderDetails,
        "finalTotal": widget.finalTotal ?? "0.0",
        "itemdiscount": widget.itemdiscount ?? "0.0",
        "totalofIndexItems": widget.totalofIndexItems ?? "0.0",
        "itemList": widget.itemList ?? "0.0",
        "timestamp": FieldValue.serverTimestamp(),
      });

      // Navigate to the TrackOrder screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackOrder(
              // orderDetails: widget.cartData,
              // finalTotal: widget.finalTotal,
              // itemdiscount: widget.itemdiscount,
              // totalofIndexItems: widget.totalofIndexItems,
              // itemList: widget.itemList,
              ),
        ),
      );
    } catch (e) {
      debugPrint('Error uploading order details: $e');
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(
      context,
      "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}",
      "Continue",
      actions: [
        TextButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColors.darkGreen,
            ),
          ),
          child: const Text(
            'Ok',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
      context,
      "External Wallet Selected",
      "${response.walletName}",
      "Continue",
      actions: <Widget>[
        TextButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(
              AppColors.darkGreen,
            ),
          ),
          child: const Text(
            'Continue',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomScreen(),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double screenWidth = constraints.maxWidth;

        double sizedBoxHeight = widget.height / 4.2;
        double sizedBoxWidth = widget.width / 1.5;
        double horizontalPadding = widget.width / 60;
        double verticalPadding = widget.height / 60;

        if (screenWidth > 1300) {
          debugPrint("screenWidth > 1300");
          sizedBoxHeight = widget.height / 4.2;
          sizedBoxWidth = widget.width / 3;
          horizontalPadding = widget.width / 60;
          verticalPadding = widget.height / 60;
        } else if (screenWidth > 1200 && screenWidth < 1300) {
          sizedBoxHeight = widget.height / 4.2;
          sizedBoxWidth = widget.width / 2.5;
          horizontalPadding = widget.width / 60;
          verticalPadding = widget.height / 60;
          debugPrint("screenWidth > 1200 && screenWidth < 1300");
        } else if (screenWidth > 1000 && screenWidth < 1200) {
          sizedBoxHeight = widget.height / 4.2;
          sizedBoxWidth = widget.width / 2;
          horizontalPadding = widget.width / 60;
          verticalPadding = widget.height / 60;
          debugPrint("screenWidth > 1000 && screenWidth < 1200");
          // Tablet view
        } else if (screenWidth > 800 && screenWidth < 1000) {
          sizedBoxHeight = widget.height / 5;
          sizedBoxWidth = widget.width / 2;
          horizontalPadding = widget.width / 60;
          verticalPadding = widget.height / 60;
          debugPrint("screenWidth > 800 && screenWidth < 1000");
        } else if (screenWidth > 600) {
          sizedBoxHeight = widget.height / 4.2;
          sizedBoxWidth = widget.width / 1.5;
          horizontalPadding = widget.width / 30;
          verticalPadding = widget.height / 40;
          debugPrint("screenWidth > 600 ");
        } else if (screenWidth > 500) {
          sizedBoxHeight = widget.height / 3.9;
          sizedBoxWidth = widget.width / 1.5;
          horizontalPadding = widget.width / 30;
          verticalPadding = widget.height / 40;
          debugPrint("screenWidth > 500");
        } else if (screenWidth > 375 || screenWidth < 500) {
          sizedBoxHeight = widget.height / 3.9;
          sizedBoxWidth = widget.width / 1.2;
          horizontalPadding = widget.width / 30;
          verticalPadding = widget.height / 40;
          debugPrint("screenWidth > 375");
        } else if (screenWidth < 375) {
          sizedBoxHeight = widget.height / 3.5;
          sizedBoxWidth = widget.width / 1.2;
          horizontalPadding = widget.width / 30;
          verticalPadding = widget.height / 40;
          debugPrint("screenWidth > 350");
        }
        return Container(
          height: sizedBoxHeight,
          width: sizedBoxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
                colors: [AppColors.lightGreen, AppColors.darkGreen],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
            image: DecorationImage(
              scale: 2,
              alignment: Alignment.topCenter,
              fit: BoxFit.cover,
              image: AssetImage(
                "assets/images/home/opacities.png",
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OrderRow(
                  keys:
                      // "Sub Total",
                      AppLocalizations.of(context)!.subTotal,
                  amount: "${widget.totalofIndexItems!.toStringAsFixed(2)} \$",
                  fontSizes: 16,
                ),
                OrderRow(
                  keys:
                      // "Delivery Charge",
                      AppLocalizations.of(context)!.deliveryCharge,
                  amount: "6 \$",
                  fontSizes: 16,
                ),
                OrderRow(
                  keys:
                      //  "Discount (5%)",
                      AppLocalizations.of(context)!.discount,
                  amount: "${widget.itemdiscount?.toStringAsFixed(2)}\$",
                  fontSizes: 16,
                ),
                SizedBox(
                  height: widget.height / 100,
                ),
                OrderRow(
                  keys:
                      // "Total Amount",
                      AppLocalizations.of(context)!.total,
                  amount: "${widget.finalTotal!.toStringAsFixed(2)}\$",
                  fontSizes: 18,
                ),
                SizedBox(
                  height: widget.height / 50,
                ),
                Flexible(
                  child: Semantics(
                    button: true,
                    label: "Place Order Button",
                    onTapHint: "Make Your Payment & Plcae yor order.",
                    child: GestureDetector(
                      onTap: () {
                        if (kIsWeb == false) {
                          int totalAmountPaisa =
                              (widget.finalTotal! * 87.33).toInt();

                          debugPrint("$totalAmountPaisa");

                          Razorpay razorpay = Razorpay();

                          var options = {
                            'key': 'rzp_test_cYIYutCiDu13Ut',
                            "currency": "INR",
                            "amount": totalAmountPaisa * 100,
                            'name': 'Swift Bite',
                            'description': 'Pay your food bills',
                            "theme.color": "#abffb0",
                            'retry': {'enabled': true, 'max_count': 1},
                            'send_sms_hash': true,
                            'prefill': {
                              'contact': '9613811624',
                              'email': 'harshilgajipara006@gmail.com'
                            },
                            'external': {
                              'wallets': ['paytm'],
                            },
                          };

                          razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                              handlePaymentErrorResponse);
                          razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                              handlePaymentSuccessResponse);
                          razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                              handleExternalWalletSelected);
                          razorpay.open(options);
                        } else if (kIsWeb == true) {
                          showAlertDialog(
                            context,
                            "Payment",
                            "This is a demo version. Payment is not available in the web version.",
                            "Ok",
                            actions: [],
                          );
                        } else {
                          showAlertDialog(
                            context,
                            "Payment",
                            "This is a demo version. Payment is not available in the web version.",
                            "Ok",
                            actions: [],
                          );
                        }
                      },
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          gradient: const LinearGradient(
                            begin: Alignment(-0.95, 0.0),
                            end: Alignment(1.0, 0.0),
                            colors: [
                              Color.fromARGB(255, 255, 255, 255),
                              Color.fromARGB(255, 255, 255, 255),
                            ],
                            stops: [0.0, 1.0],
                          ),
                        ),
                        child: Center(
                          child: GradientText(
                            // "Place Your Order",
                            AppLocalizations.of(context)!.placeOrder,
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(140, 83, 232, 140),
                                Color.fromARGB(152, 21, 190, 120),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
