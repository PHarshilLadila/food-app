import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/constant/app_gredient_text.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: GradientText(
          "Pricacy & Policy",
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
        flexibleSpace: Image(
          opacity: const AlwaysStoppedAnimation(0.3),
          alignment: Alignment.topCenter,
          image: AssetImage('assets/images/Pattern.png'),
          fit: BoxFit.fitWidth,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 224, 250, 228),
                  Color.fromARGB(255, 233, 248, 234)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Blur overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.white.withOpacity(0.05)),
          ),

          // Scrollable Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSection(
                    title: '1. Introduction',
                    content:
                        'Welcome to our Food Delivery App. This Privacy Policy explains how we collect, use, and protect your personal data.',
                  ),
                  _buildSection(
                    title: '2. Information We Collect',
                    content:
                        '- Personal Information (Name, Email, Phone Number)\n'
                        '- Location Data for delivery\n'
                        '- Payment Information (encrypted)\n'
                        '- Order History and Preferences',
                    image: 'assets/images/privacy/data.png',
                  ),
                  _buildSection(
                    title: '3. How We Use Your Information',
                    content: '- To deliver your food accurately and timely.\n'
                        '- To improve our app and personalize your experience.\n'
                        '- To contact you with promotional offers (if opted in).\n'
                        '- To comply with legal obligations.',
                  ),
                  _buildSection(
                    title: '4. Data Security',
                    content:
                        'We implement strong security measures to protect your data from unauthorized access, alteration, or disclosure.',
                    image: 'assets/images/privacy/insurance.png',
                  ),
                  _buildSection(
                    title: '5. Sharing Your Data',
                    content:
                        'We do not sell your data. We only share it with third-party services essential for operations like payment gateways, delivery partners, and analytics tools.',
                  ),
                  _buildSection(
                    title: '6. Your Choices',
                    content: '- You can view, update, or delete your profile.\n'
                        '- You may opt-out of promotional notifications.\n'
                        '- You can contact us to request data deletion.',
                  ),
                  _buildSection(
                    title: '7. Contact Us',
                    content:
                        'If you have questions about this Privacy Policy, please email us at: support@foodapp.com',
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'Last Updated: April 2025',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Text(
                      'Version 1.0.0+1',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required String content,
    String? image,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
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
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            content,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          if (image != null) ...[
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
