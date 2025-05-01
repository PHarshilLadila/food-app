// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:food_app/constant/app_sctring.dart';
import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
import 'package:food_app/functionalities/home/provider/home_provider.dart';
import 'package:food_app/functionalities/home/screen/item_details.dart';
import 'package:food_app/functionalities/profile/provider/profile_provider.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteItems extends StatefulWidget {
  final String? itemDescription;
  final String? itemId;
  final String? itemImage;
  final int? itemPrice;
  final String? itemName;
  final bool? isFavorites;

  const FavoriteItems({
    super.key,
    this.itemDescription,
    this.itemId,
    this.itemImage,
    this.itemPrice,
    this.itemName,
    this.isFavorites,
  });

  @override
  State<FavoriteItems> createState() => _FavoriteItemsState();
}

class _FavoriteItemsState extends State<FavoriteItems> {
  Future<List<Map<String, dynamic>>> fetchFavItems() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final userId = await Hive.box('userProfile').get('userid');

    final favItemsSnapshot = await homeProvider.firestore
        .collection("users")
        .doc(userId)
        .collection("favoriteItems")
        .get();

    return favItemsSnapshot.docs.map((doc) {
      var data = doc.data();
      data["docId"] = doc.id;
      return data;
    }).toList();
  }

  Future<void> toggleFavorite(
    String docId,
  ) async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    final userId = await Hive.box('userProfile').get('userid');

    // await homeProvider.firestore
    //     .collection("users")
    //     .doc(userId)
    //     .collection("favoriteItems")
    //     .doc(docId)
    //     .update({"isFavorite": isFavorite});

    await homeProvider.firestore
        .collection("users")
        .doc(userId)
        .collection("favoriteItems")
        .doc(docId)
        .delete();

    setState(() {});
    appTostMessage(
      context,
      ToastificationType.success,
      "Item Removed Successfully from Favorite List",
      "assets/images/done.png",
    );
    const Duration(milliseconds: 600);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  alignment: Alignment.topCenter,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.2), BlendMode.dstATop),
                  image: const AssetImage("assets/images/Pattern.png"),
                  fit: kIsWeb ? BoxFit.cover : BoxFit.none),
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                child: Column(
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
                            padding: const EdgeInsets.only(right: 12),
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
                            // AppLocalizations.of(context)!.favTitle,
                            'Find Your Favorite Food',
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
                    Text(
                      "Favorite Items",
                      // AppLocalizations.of(context)!.favoriteItems,
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: FutureBuilder<List<Map<String, dynamic>>>(
                        future: fetchFavItems(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: myProccesser());
                          }

                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Your Favorite List is Empty",
                                    // AppLocalizations.of(context)!.emptyFav,
                                    style: GoogleFonts.poppins(fontSize: 18),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomeButton(
                                    heights: height / 20,
                                    widths: width / 2.5,
                                    name: "Explore Foods",
                                    // AppLocalizations.of(context)!
                                    // .exploreFood,
                                    ontap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BottomScreen()),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          }

                          var favItems = snapshot.data!;
                          return ListView.builder(
                            itemCount: favItems.length,
                            itemBuilder: (context, index) {
                              var item = favItems[index];

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ItemDetails(
                                          itemId: item["mealId"],
                                          itemname: item["mealname"],
                                          itemImage: item["mealImage"],
                                          itemPrice: double.tryParse(
                                                  item["mealPrice"]
                                                      .toString()) ??
                                              0.0,
                                          itemDescription:
                                              widget.itemDescription ??
                                                  AppString.mealsDescription(
                                                      context),
                                          restroImg:
                                              item["restroImg"].toString(),
                                          restroName: item["restroName"],
                                        ),
                                      ),
                                    );
                                    debugPrint(
                                      "${item["mealId"]}, ${item["mealname"]}, ${item["mealImage"]}, ${item["mealPrice"]}, ${item["restroName"]}, ${item["restroImg"]}, ${item["docId"]}",
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          20, 143, 143, 143),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image.network(
                                              item["mealImage"] ??
                                                  "https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg",
                                              height: 65,
                                              width: 65,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.network(
                                                  "https://png.pngtree.com/png-vector/20190820/ourmid/pngtree-no-image-vector-illustration-isolated-png-image_1694547.jpg",
                                                  height: 50,
                                                  width: 50,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item["mealname"] ?? "No Name",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  item["restroName"] ??
                                                      "No Name",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  "\$${item["mealPrice"] ?? 0}",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    color: AppColors.darkGreen,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              toggleFavorite(item["docId"]);
                                            },
                                            icon: const FaIcon(
                                                FontAwesomeIcons.solidTrashCan,
                                                color: Colors.red),
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
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
