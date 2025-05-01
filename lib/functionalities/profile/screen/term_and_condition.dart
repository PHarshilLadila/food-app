import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: GradientText(
          "Terms & Conditions",
          // AppLocalizations.of(context)!.helpAndSupportTitle,
          style: GoogleFonts.poppins(fontSize: 25, fontWeight: FontWeight.w400),
          gradient: const LinearGradient(
            colors: [
              AppColors.lightGreen,
              AppColors.darkGreen,
            ],
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5, left: 12),
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
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.darkGreen,
              ),
            ),
          ),
        ),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(),
          child: Image(
            opacity: const AlwaysStoppedAnimation(0.3),
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/Pattern.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfff5fff7), Color(0xffe8ffe9)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/privacy/terms.jpg',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ..._buildSection(
                context,
                title: "1. Introduction",
                content:
                    "By using SwiftBite, you agree to comply with our terms and policies. These conditions govern your use of the app, services, and website. Kindly review them thoroughly before proceeding.",
              ),
              ..._buildSection(
                context,
                title: "2. User Accounts",
                content:
                    "To access our services, users must create an account with accurate information. You are responsible for keeping your account secure and up-to-date. Any misuse or breach should be reported immediately.",
              ),
              ..._buildSection(
                context,
                title: "3. Orders & Payment",
                content:
                    "Placing an order confirms a binding agreement. All payments must be completed via available methods. We reserve the right to cancel orders in case of fraudulent activity or payment failure.",
              ),
              ..._buildSection(
                context,
                title: "4. Cancellations & Refunds",
                content:
                    "Cancellations are only allowed within a limited time after ordering. Refunds will be processed based on eligibility and in accordance with our refund policy. Refunds may take up to 7 business days.",
              ),
              ..._buildSection(
                context,
                title: "5. Privacy Policy",
                content:
                    "We value your privacy. Your data is securely stored and only used for service improvement and communication. Read our full Privacy Policy to understand your rights and data usage.",
              ),
              ..._buildSection(
                context,
                title: "6. Limitation of Liability",
                content:
                    "SwiftBite is not liable for any indirect or consequential damages arising from the use of our app. This includes but is not limited to delivery delays, order errors, or service downtime.",
              ),
              ..._buildSection(
                context,
                title: "7. Contact Us",
                content:
                    "If you have any questions about these terms, feel free to reach out to us at support@swiftbite.com. We're here to help!",
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.darkGreen,
                    elevation: 6,
                    shadowColor: Colors.green.withOpacity(0.3),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  icon: const Icon(Icons.check_circle_outline,
                      color: Colors.white),
                  label: Text(
                    "Accept & Continue",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSection(BuildContext context,
      {required String title, required String content}) {
    return [
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightGreen.withOpacity(0.08),
              offset: const Offset(0, 2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: GoogleFonts.poppins(
                height: 1.6,
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      )
    ];
  }
}
