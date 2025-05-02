// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_textform_field.dart';
import 'package:food_app/functionalities/profile/help%20&%20support/provider/query_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RaisedComplainTab extends StatelessWidget {
  final double height;
  final double width;
  final TextEditingController queryController;
  final Function addQuery;
  final Function getRandomNumber;

  const RaisedComplainTab({
    super.key,
    required this.height,
    required this.width,
    required this.queryController,
    required this.addQuery,
    required this.getRandomNumber,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              // "Help & Support",
              AppLocalizations.of(context)!.help,
              minFontSize: 16,
              maxFontSize: 18,
              style: GoogleFonts.poppins(
                  color: AppColors.blackColor,
                  fontSize: width / 19,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: height / 80,
            ),
            Row(
              children: [
                Expanded(
                  child: CustomeTextFormField(
                    textEditingController: queryController,
                    maxlength: 300,
                    maxline: 5,
                    obscureText: false,
                    borderColor: AppColors.darkGreen.withOpacity(1.0),
                    disabledColor: AppColors.darkGreen.withOpacity(1.0),
                    enabledColor: AppColors.darkGreen.withOpacity(1.0),
                    focusedColor: AppColors.darkGreen.withOpacity(1.0),
                    hintText:
                        // "Explain Your Query",
                        AppLocalizations.of(context)!.explainQuery,
                    fillColor: const Color.fromARGB(55, 232, 255, 227),
                    hintcolors: AppColors.darkGreen.withOpacity(1.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 60,
            ),
            GestureDetector(
              onTap: () {
                getRandomNumber();
                addQuery();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.darkGreen,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade100,
                        offset: const Offset(5, 25),
                        blurRadius: 10),
                  ],
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.raisedyourquiery,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    )),
              ),
            ),
            SizedBox(
              height: height / 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.not} : ',
                  style: GoogleFonts.poppins(
                    color: AppColors.blackColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Flexible(
                  child: Text(
                    AppLocalizations.of(context)!.complainNote,
                    style: GoogleFonts.poppins(
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height / 50,
            ),
            Text(
              AppLocalizations.of(context)!.yourQuiry,
              style: GoogleFonts.poppins(
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: height / 80,
            ),
            Consumer<QueryProvider>(
              builder: (context, value, child) {
                if (value.queries.isEmpty) {
                  return const Center(child: Text("No Query Found"));
                }
                return ListView.builder(
                  physics: const ScrollPhysics(),
                  reverse: true,
                  shrinkWrap: true,
                  itemCount: value.queries.length,
                  itemBuilder: (context, index) {
                    final query = value.queries[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 17, 165, 74)),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(28, 74, 255, 83)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 18),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .ticket,
                                          style: GoogleFonts.poppins(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: ' ${query.ticketId}',
                                              style: GoogleFonts.poppins(
                                                color: AppColors.blackColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: height / 150,
                                      ),
                                      SizedBox(
                                        width: width / 1.5,
                                        child: Text(
                                          '${query.query}',
                                          style: GoogleFonts.poppins(
                                            color: AppColors.blackColor,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                          ),
                                          textAlign: TextAlign.start,
                                          maxLines: 8,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () =>
                                        value.deleteQueries(query.ticketId!),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
