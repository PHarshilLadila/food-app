import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactUsTab extends StatelessWidget {
  const ContactUsTab({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> makePhoneCall(String phoneNumber) async {
      final Uri launchUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      await launchUrl(launchUri);
    }

    Future<void> launchWhatsapp() async {
      const url = "https://wa.me/?text=Hey buddy, try this super cool new app!";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    Future<void> launchURL(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              makePhoneCall("9613811624");
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height / 50, horizontal: width / 60),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.headset,
                        size: height / 32, color: Colors.black),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      AppLocalizations.of(context)!.contactUs,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: height / 50,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height / 80,
          ),
          GestureDetector(
            onTap: () {
              launchWhatsapp();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height / 50, horizontal: width / 60),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.whatsapp,
                        size: height / 32, color: Colors.black),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      AppLocalizations.of(context)!.whatsapp,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: height / 50,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height / 80,
          ),
          GestureDetector(
            onTap: () {
              launchURL("https://www.facebook.com/");
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height / 50, horizontal: width / 60),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.facebookF,
                        size: height / 32, color: Colors.black),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      AppLocalizations.of(context)!.facebook,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: height / 50,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height / 80,
          ),
          GestureDetector(
            onTap: () {
              launchURL("https://www.instagram.com/?hl=en");
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height / 50, horizontal: width / 60),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.instagram,
                        size: height / 32, color: Colors.black),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      AppLocalizations.of(context)!.insta,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: height / 50,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: height / 80,
          ),
          GestureDetector(
            onTap: () {
              launchURL("https://www.zomato.com/ahmedabad/delivery");
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: height / 50, horizontal: width / 60),
                child: Row(
                  children: [
                    FaIcon(FontAwesomeIcons.globe,
                        size: height / 32, color: Colors.black),
                    SizedBox(
                      width: width / 30,
                    ),
                    Text(
                      AppLocalizations.of(context)!.website,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      CupertinoIcons.right_chevron,
                      size: height / 50,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
