import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/cart/screens/cart_screen.dart';
import 'package:food_app/functionalities/home/screen/home_screen.dart';
import 'package:food_app/functionalities/profile/screen/profile_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  final List<Widget> _widgetOptions = [
    const HomeScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(241, 248, 255, 1),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
            child: GNav(
              rippleColor: const Color.fromARGB(255, 243, 255, 241),
              haptic: true,
              tabBorderRadius: 10,
              textStyle: const TextStyle(fontSize: 16, fontFamily: "Lato"),
              curve: Curves.easeInCubic,
              duration: const Duration(milliseconds: 500),
              gap: 8,
              color: Colors.white,
              activeColor: AppColors.darkGreen,
              iconSize: 24,
              tabBackgroundColor: const Color.fromARGB(255, 229, 255, 239),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 9),
              tabs: [
                GButton(
                  icon: CupertinoIcons.home,
                  text:
                      // "Home",
                      AppLocalizations.of(context)!.home,
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  iconSize: 25,
                  iconColor: Colors.black,
                ),
                GButton(
                  icon: CupertinoIcons.shopping_cart,
                  text:
                      //  "Cart",
                      AppLocalizations.of(context)!.cart,
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  iconSize: 28,
                  iconColor: Colors.black,
                ),
                GButton(
                  icon: CupertinoIcons.profile_circled,
                  iconSize: 25,
                  textStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  text:
                      //  "Profile",
                      AppLocalizations.of(context)!.profile,
                  iconColor: Colors.black,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
