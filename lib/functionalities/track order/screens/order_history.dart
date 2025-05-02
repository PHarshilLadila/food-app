import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
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
    Provider.of<TrackOrderProvider>(context, listen: false).loadOrders();
  }

  Future<void> _refreshOrders() async {
    debugPrint("Refreshing orders...");
    await Provider.of<TrackOrderProvider>(context, listen: false).loadOrders();
    debugPrint("Refreshing done");
  }

  String _formatTimestamp(dynamic timestamp) {
    try {
      if (timestamp is Timestamp) {
        final dateTime = timestamp.toDate();
        return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
      } else if (timestamp is DateTime) {
        return "${timestamp.day}/${timestamp.month}/${timestamp.year} ${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}";
      } else if (timestamp is String) {
        final dateTime = DateTime.tryParse(timestamp);
        if (dateTime != null) {
          return "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
        }
      }
    } catch (e) {
      debugPrint("Error formatting timestamp: $e");
    }
    return "N/A";
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackOrderProvider>(
      builder: (context, value, child) {
        final orders = value.oreders;
        // final lastOrder = orders.isNotEmpty ? orders.last : null;

        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.2),
                  BlendMode.dstATop,
                ),
                image: const AssetImage("assets/images/Pattern.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: RefreshIndicator(
                color: AppColors.darkGreen,
                onRefresh: _refreshOrders,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomScreen(),
                                ),
                                (route) => false,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.extraLightGreen,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: AppColors.lightGreen,
                                    width: 0.5,
                                  ),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: AppColors.darkGreen,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: GradientText(
                                'Order History',
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
                        const SizedBox(height: 20),
                        orders.isEmpty
                            ? Center(
                                child: Text(
                                  "No orders found.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Column(
                                children: List.generate(
                                  orders.length,
                                  (index) {
                                    final order =
                                        orders[orders.length - 1 - index];
                                    final isLastOrder = index == 0;
                                    final discount =
                                        (order['itemdiscount'] ?? 0.0)
                                            .toStringAsFixed(2);
                                    final finalTotal =
                                        (order['finalTotal'] ?? 0.0)
                                            .toStringAsFixed(2);

                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.05),
                                            blurRadius: 8,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Order ID : ${order['orderid'] ?? 'N/A'}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.darkGreen,
                                                ),
                                              ),
                                              Text(
                                                _formatTimestamp(
                                                    order['timestamp']),
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.darkGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          SizedBox(
                                            height: 120,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0.0),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              0.7,
                                                      child: Stack(
                                                        children: List.generate(
                                                          (order['orderDetails']
                                                                      as List? ??
                                                                  [])
                                                              .length,
                                                          (imageIndex) {
                                                            final item = (order[
                                                                        'orderDetails']
                                                                    as List? ??
                                                                [])[imageIndex];
                                                            return Positioned(
                                                              left: imageIndex *
                                                                  50.0,
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(3),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      243,
                                                                      255,
                                                                      230),
                                                                ),
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12),
                                                                  child:
                                                                      ColorFiltered(
                                                                    colorFilter: isLastOrder
                                                                        ? const ColorFilter
                                                                            .mode(
                                                                            Colors
                                                                                .transparent,
                                                                            BlendMode
                                                                                .multiply)
                                                                        : const ColorFilter
                                                                            .mode(
                                                                            Colors.grey,
                                                                            BlendMode.saturation),
                                                                    child: Image
                                                                        .network(
                                                                      item['itemImage'] ??
                                                                          "",
                                                                      height:
                                                                          100,
                                                                      width:
                                                                          100,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          const Icon(
                                                                              Icons.broken_image),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: List.generate(
                                              (order['orderDetails'] as List? ??
                                                      [])
                                                  .length,
                                              (imageIndex) {
                                                final item =
                                                    (order['orderDetails']
                                                            as List? ??
                                                        [])[imageIndex];

                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        item['itemName'] ??
                                                            "Unknown Item",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors
                                                              .grey.shade700,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "x${item['quantity'] ?? 1}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                          Text(
                                                            " (\$${item['itemPrice'] ?? 1})",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: Colors
                                                                        .black),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Delivery Charges",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              Text(
                                                "\$6",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Discount (5%)",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              Text(
                                                "\$${(discount ?? "0.0")}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.blackColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${(order['orderDetails'] as List? ?? []).length} Items",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              Text(
                                                "\$${finalTotal ?? '0.00'}",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.darkGreen,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
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
