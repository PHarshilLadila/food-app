import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/track%20order/provider/track_order_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => OrderHistoryState();
}

class OrderHistoryState extends State<OrderHistory> {
  @override
  void initState() {
    super.initState();

    Provider.of<TrackOrderProvider>(context, listen: false)
        .loadOrders(); // Load orders when the widget is initialized
  }

  List<Map<String, dynamic>>? orederDetails;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    return Consumer<TrackOrderProvider>(
      builder: (BuildContext context, value, Widget? child) {
        var orders = value.oreders;
        debugPrint("Orders : $orders");
        return Scaffold(
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5, left: 10, right: 12),
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppColors.darkGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: GradientText(
                              'Check Order History',
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
                      SizedBox(
                        height: height / 40,
                      ),
                      GradientText(
                        'Order History',
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.blackColor,
                            AppColors.blackColor,
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: orders.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final item = orders[index]['orderDetails'][index]
                              as Map<String, dynamic>;
                          orederDetails = List<Map<String, dynamic>>.from(
                              orders[index]['orderDetails']);

                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.extraLightGreen,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: AppColors.lightGreen,
                                width: 0.5,
                              ),
                            ),
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Pending",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red),
                                        ),
                                        Text(
                                          "Order ID : ${item["orderId"] ?? "2203562F1g4"}",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${item["itemName"] ?? "Unknown Item"}",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              "(\$${item["itemPrice"] ?? 0})",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.green),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          "Price: \$${item['itemPrice'] ?? 0} x ${item['quantity'] ?? 1}",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                        Text(
                                          "Total \$${(item['itemPrice'] ?? 0) * (item['quantity'] ?? 1)}",
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        "${item['itemImage'] ?? ""}",
                                        height: 70,
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
