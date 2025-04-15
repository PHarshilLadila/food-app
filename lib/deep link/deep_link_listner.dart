// import 'package:app_links/app_links.dart';
// import 'package:flutter/material.dart';
// import 'package:food_app/functionalities/auth/screen/login_screen.dart';
// import 'package:food_app/functionalities/auth/screen/sign_up_screen.dart';
// import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
// import 'package:food_app/functionalities/cart/screens/cart_screen.dart';
// import 'package:food_app/functionalities/home/screen/home_screen.dart';
// import 'package:food_app/functionalities/profile/screen/profile_screen.dart';
// import 'package:food_app/main.dart';

// void flutterDeepLink() async {
//   final applinks = AppLinks();
//   applinks.uriLinkStream.listen((uri) {
//     debugPrint("URI : ${uri.toString()}");
//     if (uri.pathSegments.first == 'home') {
//       globalNavigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => HomeScreen(),
//         ),
//       );
//     } else if (uri.pathSegments.first == 'cart') {
//       globalNavigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => CartScreen(),
//         ),
//       );
//     } else if (uri.pathSegments.first == 'bottom') {
//       globalNavigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => BottomScreen(),
//         ),
//       );
//     } else if (uri.pathSegments.first == 'login') {
//       globalNavigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => LoginScreen(),
//         ),
//       );
//     } else if (uri.pathSegments.first == 'signup') {
//       globalNavigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => SignUpScreen(),
//         ),
//       );
//     } else if (uri.pathSegments.first == 'profile') {
//       globalNavigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => ProfileScreen(),
//         ),
//       );
//     }
//   });
// }
