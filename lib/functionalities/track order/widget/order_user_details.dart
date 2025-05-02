// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/profile/provider/profile_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.profile == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        String firstName = "${value.profile!.fname}";
        String lastName = "${value.profile!.lname}";

        return Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 255, 255),
            border: Border.all(color: Colors.black, width: 0.5),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 241, 255, 243),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8),
                        child: Row(
                          children: [
                            const FaIcon(
                              FontAwesomeIcons.truckFast,
                              size: 14,
                              color: AppColors.darkGreen,
                            ),
                            SizedBox(
                              width: width / 60,
                            ),
                            Text(
                              'Shipping',
                              style: GoogleFonts.poppins(
                                  color: AppColors.darkGreen,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 100,
                ),
                Row(
                  children: [
                    Text(
                      'Delivery Estimate',
                      style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      'May 18, 2025',
                      style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  "$firstName $lastName",
                  style: GoogleFonts.poppins(
                      color: AppColors.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: height / 200,
                ),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.home,
                      size: 16,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      width: width / 60,
                    ),
                    Flexible(
                      child: Text(
                        "${value.profile!.location}",
                        style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 150,
                ),
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.phone,
                      size: 16,
                      color: Colors.blueGrey,
                    ),
                    SizedBox(
                      width: width / 60,
                    ),
                    Flexible(
                      child: Text(
                        "${value.profile!.mobile}",
                        style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: height / 100,
                ),
                Row(
                  children: [
                    Text(
                      'Payment method',
                      style: GoogleFonts.poppins(
                          color: AppColors.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    Text(
                      "Google Pay UPI",
                      style: GoogleFonts.poppins(
                        color: AppColors.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
