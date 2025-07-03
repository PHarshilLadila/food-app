import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderRow extends StatelessWidget {
  final String? amount;
  final String? keys;
  final double? fontSizes;
  final Color? textColor;

  const OrderRow(
      {super.key, this.amount, this.keys, this.fontSizes, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          keys!,
          style: GoogleFonts.poppins(
              color: textColor ?? Colors.black,
              fontSize: fontSizes,
              fontWeight: FontWeight.w500),
          textDirection: TextDirection.ltr,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          amount!,
          style: GoogleFonts.poppins(
              color: textColor ?? Colors.black,
              fontSize: fontSizes,
              fontWeight: FontWeight.w500),
          textDirection: TextDirection.ltr,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
