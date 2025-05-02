import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DroppedCartButton extends StatelessWidget {
  const DroppedCartButton({
    super.key,
    required this.height,
    required this.width,
    required Map<String, dynamic>? droppedItem,
    required bool isDropped,
  })  : _droppedItem = droppedItem,
        _isDropped = isDropped;

  final double height;
  final double width;
  final Map<String, dynamic>? _droppedItem;
  final bool _isDropped;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5), BlendMode.dstATop),
          image: const AssetImage(
            "assets/images/Pattern.png",
          ),
        ),
      ),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(15),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: height / 100, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.addtocartdrag,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.infoCircle,
                    size: 14,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: width / 60,
                  ),
                  AutoSizeText(
                    "${AppLocalizations.of(context)!.not} : ",
                    minFontSize: 16,
                    maxFontSize: 16,
                    style: GoogleFonts.poppins(
                        color: AppColors.blackColor,
                        fontSize: width / 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: AutoSizeText(
                      AppLocalizations.of(context)!.dragnoteTwo,
                      minFontSize: 14,
                      maxFontSize: 14,
                      style: GoogleFonts.poppins(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height / 100,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        _droppedItem?["itemImage"] ??
                            "https://cdn-icons-png.flaticon.com/512/624/624826.png",
                        height: height / 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width / 50,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: width / 2,
                        child: Text(
                          _isDropped
                              ? '${_droppedItem?["itemName"] ?? ""}'
                              : AppLocalizations.of(context)!.dragAndDropHere,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          _isDropped
                              ? '\$ ${_droppedItem?["itemPrice"] ?? ""}'
                              : ' ',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.green),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: width / 2,
                        child: Text(
                          _isDropped
                              ? '${_droppedItem?["itemDiscription"] ?? ""}'
                              : ' ',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.black38),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
