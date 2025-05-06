// Same imports...

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_textform_field.dart';
import 'package:food_app/functionalities/home/provider/review_provider.dart';
import 'package:food_app/functionalities/profile/provider/profile_provider.dart';
import 'package:food_app/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';

class ReviewForm extends StatefulWidget {
  final String itemId;
  final String foodName;
  final String foodCategory;
  const ReviewForm(
      {super.key,
      required this.itemId,
      required this.foodName,
      required this.foodCategory});

  @override
  State<ReviewForm> createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  double _rating = 3;
  final TextEditingController _commentController = TextEditingController();
  String userUid = "";

  void getUserId() async {
    final databaseBox = Hive.box('userProfile');
    final id = await databaseBox.get("userid");
    setState(() {
      userUid = id ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ReviewProvider>(context, listen: false)
          .fetchReviews(widget.itemId);
      Provider.of<ProfileProvider>(context, listen: false).profile;
      Provider.of<ProfileProvider>(context, listen: false).getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);
    final profileData =
        Provider.of<ProfileProvider>(context, listen: false).profile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section: Your Review
        Text(
          "Your Review",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
        const SizedBox(height: 10),
        RatingBar.builder(
          initialRating: _rating,
          minRating: 1,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 28,
          itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            _rating = rating;
          },
        ),
        const SizedBox(height: 10),
        CustomeTextFormField(
          textEditingController: _commentController,
          maxline: 3,
          fillColor: const Color.fromARGB(255, 252, 255, 252),
          hintText: "Write your review here...",
          obscureText: false,
          hintcolors: const Color(0xff3B3B3B),
          borderColor: const Color.fromARGB(255, 252, 255, 252),
          disabledColor: const Color.fromARGB(255, 252, 255, 252),
          enabledColor: AppColors.darkGreen,
          focusedColor: AppColors.darkGreen,
          keyboradType: TextInputType.text,
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.darkGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          ),
          onPressed: () async {
            final databaseBox = Hive.box('userProfile');
            final id = await databaseBox.get("userid");
            final username = profileData?.name;

            await reviewProvider.submitReview(
              itemId: widget.itemId,
              userId: id,
              username: username ?? "N/A",
              rating: _rating,
              comment: _commentController.text,
              foodName: widget.foodName,
              foodCategory: widget.foodCategory,
            );

            _commentController.clear();
            appTostMessage(
              context,
              ToastificationType.success,
              "Review submitted successfully.",
              "assets/images/done.png",
            );
          },
          child: Text(
            "Submit Review",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const Divider(height: 30, thickness: 1),

        // Section: Recent Reviews
        Text(
          "Recent Reviews",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
        const SizedBox(height: 15),
        Consumer<ReviewProvider>(
          builder: (context, provider, child) {
            final reviews = provider.reviews;
            if (reviews.isEmpty) {
              return Center(
                child: Text(
                  "No reviews yet.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.grey.shade300,
                        child: Text(
                          (review['username'] ?? "U")[0].toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Review Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Username and Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  review['username'] ?? "User",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Row(
                                  children: List.generate(
                                    review['rating'].round(),
                                    (i) => const Icon(Icons.star,
                                        size: 16, color: Colors.amber),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  review['comment'] ?? "No comment provided.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  review['rating'].toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
