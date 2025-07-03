import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/home/helper/list_data.dart';
import 'package:food_app/functionalities/home/screen/item_details.dart';
import 'package:google_fonts/google_fonts.dart';

class PopularMenuList extends StatelessWidget {
  final bool isLightTheme;

  const PopularMenuList({super.key, required this.isLightTheme});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Popular Menu",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isLightTheme ? Colors.black : Colors.white,
                ),
              ),
              Text(
                "View More",
                style: GoogleFonts.poppins(
                  color: AppColors.darkOrange,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          itemCount: popularItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ItemDetails(
                        itemId: popularItems[index]["id"],
                        itemImage: popularItems[index]["image"],
                        itemPrice: popularItems[index]["price"],
                        itemname: popularItems[index]["name"],
                        restroImg:
                            "assets/images/home/nearRestaurant/near3.png",
                        restroName: "The Chinese Bar",
                        itemDescription: popularItems[index]["description"],
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: isLightTheme
                        ? const Color.fromARGB(255, 238, 255, 234)
                        : const Color(0xFF333739),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadiusDirectional.circular(15),
                        child: Image.asset(
                          popularItems[index]["image"],
                          fit: BoxFit.cover,
                          height: 80,
                          width: 80,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            popularItems[index]["name"],
                            style: GoogleFonts.poppins(
                              color: isLightTheme ? Colors.black : Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            popularItems[index]["description"],
                            style: GoogleFonts.poppins(
                              color:
                                  isLightTheme ? Colors.black : Colors.white70,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        "\$${popularItems[index]["price"]}",
                        style: GoogleFonts.poppins(
                          color: AppColors.darkOrange,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
