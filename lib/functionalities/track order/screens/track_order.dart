// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/functionalities/file%20operation/order_provider.dart';
import 'package:food_app/functionalities/file%20operation/oreder_screen.dart';
import 'package:food_app/functionalities/profile/provider/profile_provider.dart';
import 'package:food_app/functionalities/track%20order/widget/order_user_details.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  // final double? totalofIndexItems;
  // final double? itemdiscount;
  // final double? finalTotal;
  // final double? itemList;
  // final List<Map<String, dynamic>>? orderDetails;
  const TrackOrder({
    super.key,
    // this.orderDetails,
    // this.totalofIndexItems,
    // this.itemdiscount,
    // this.finalTotal,
    // this.itemList,
  });

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  int activeStep = 0;
  List<Map<String, dynamic>>? orederDetails;
  String? userUid = "";

  void getUserId() async {
    final databaseBox = Hive.box('userProfile');
    var id = await databaseBox.get("userid");
    debugPrint("Hive user id : $id");

    if (id != null) {
      setState(() {
        userUid = id;
      });
    } else {
      debugPrint("Error: User ID not found in Hive.");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserId();

    Future.microtask(() {
      Provider.of<ProfileProvider>(context, listen: false).profile;
      Provider.of<ProfileProvider>(context, listen: false).getUserData();
      // widget.orderDetails!;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2), BlendMode.dstATop),
            image: const AssetImage(
              "assets/images/Pattern.png",
            ),
            fit: kIsWeb ? BoxFit.cover : BoxFit.none,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
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
                          'Track Your Order Here',
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
                        onTap: () {},
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
                    height: height / 40,
                  ),
                  GradientText(
                    'Track Order',
                    style: GoogleFonts.poppins(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.blackColor,
                        AppColors.blackColor,
                      ],
                    ),
                  ),
                  EasyStepper(
                    activeStep: activeStep,
                    stepShape: StepShape.rRectangle,
                    stepBorderRadius: 15,
                    borderThickness: 2,
                    stepRadius: 28,
                    finishedStepBorderColor:
                        const Color.fromARGB(255, 236, 245, 234),
                    finishedStepTextColor:
                        const Color.fromARGB(255, 236, 245, 234),
                    finishedStepBackgroundColor:
                        const Color.fromARGB(255, 236, 245, 234),
                    activeStepIconColor:
                        const Color.fromARGB(255, 236, 245, 234),
                    showLoadingAnimation: false,
                    steps: [
                      EasyStep(
                        customStep: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Opacity(
                            opacity: activeStep >= 0 ? 1 : 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Image.asset('assets/images/payment/Buy.png'),
                            ),
                          ),
                        ),
                        customTitle: const Text(
                          'Analyzed Cart',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        customStep: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Opacity(
                            opacity: activeStep >= 1 ? 1 : 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Image.asset('assets/images/payment/pack.png'),
                            ),
                          ),
                        ),
                        customTitle: const Text(
                          'Packaging Order',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        customStep: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Opacity(
                            opacity: activeStep >= 2 ? 1 : 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  'assets/images/payment/truck.png'),
                            ),
                          ),
                        ),
                        customTitle: const Text(
                          'Shipping',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      EasyStep(
                        customStep: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Opacity(
                            opacity: activeStep >= 3 ? 1 : 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                  'assets/images/payment/circlelocation.png'),
                            ),
                          ),
                        ),
                        customTitle: const Text(
                          'Deliverd',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    onStepReached: (index) =>
                        setState(() => activeStep = index),
                  ),
                  UserDetails(width: width, height: height),
                  SizedBox(
                    height: height / 60,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(color: Colors.black, width: 0.5),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 15),
                      child: Column(
                        children: [
                          StreamBuilder<QuerySnapshot>(
                            stream: userUid != null && userUid!.isNotEmpty
                                ? FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userUid)
                                    .collection('ordersDetails')
                                    .orderBy('timestamp', descending: true)
                                    .limit(1)
                                    .snapshots()
                                : const Stream
                                    .empty(), // Prevents Firestore assertion error
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot.hasError) {
                                return Center(
                                    child: Text("Error: ${snapshot.error}"));
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Center(
                                    child: Text("No orders found."));
                              }

                              // Extract the latest order document
                              final orderData = snapshot.data!.docs.first.data()
                                  as Map<String, dynamic>;

                              return Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Order: 20250310e2',
                                        style: GoogleFonts.poppins(
                                            color: AppColors.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        '(${orderData['itemList'] ?? 'N/A'} Items)',
                                        style: GoogleFonts.poppins(
                                            color: AppColors.darkGreen,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        width: width / 100,
                                      ),
                                      Text(
                                        '\$${orderData['finalTotal'] ?? 'N/A'}',
                                        style: GoogleFonts.poppins(
                                            color: AppColors.blackColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height / 80,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        (orderData['orderDetails'] as List)
                                            .length,
                                    itemBuilder: (context, index) {
                                      final item = orderData['orderDetails']
                                          [index] as Map<String, dynamic>;

                                      orederDetails =
                                          item as List<Map<String, dynamic>>?;
                                      return ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Image.network(
                                            item['itemImage'] ?? "",
                                            width: 60,
                                            height: 60,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                        title: Text(
                                            item['itemName'] ?? "Unknown Item"),
                                        subtitle: Text(
                                            "Price: \$${item['itemPrice'] ?? 0} x ${item['quantity'] ?? 1}"),
                                        trailing: Text(
                                          "Total: \$${(item['itemPrice'] ?? 0) * (item['quantity'] ?? 1)}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      );
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 18.0, horizontal: 12),
                                    child: CustomeButton(
                                      heights: 50,
                                      widths: double.infinity,
                                      name: "Order Complate",
                                      ontap: () {
                                        Provider.of<OrderProvider>(context,
                                                listen: false)
                                            .addOrder(orederDetails ?? []);

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                OrederScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
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
      ),
    );
  }
}
