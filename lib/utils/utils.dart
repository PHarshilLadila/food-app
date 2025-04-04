import 'package:flutter/material.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

void showAlertDialog(
    BuildContext context, String title, String message, String buttonText,
    {required List<Widget> actions}) {
  Widget continueButton = CustomeButton(
    name: buttonText,
    ontap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const BottomScreen(),
        ),
      );
    },
    heights: 45,
    widths: 150,
  );
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// my3DAvatar.dart
loadHtmlFromAssets(WebViewController controller, String asset) async {
  String fileText = await rootBundle.loadString(asset);
  controller.loadRequest(Uri.dataFromString(fileText,
      mimeType: 'text/html', encoding: Encoding.getByName('utf-8')));
}

// Avatar Profile
userFromPrefs(SharedPreferences prefs) {
  final Map<String, dynamic> json =
      jsonDecode(prefs.getString('avatar') ?? '{}');
  if (json.isNotEmpty) {
    final avatarUrl = json['data']['url'];
    final avatarId =
        avatarUrl?.split('/').last.toString().replaceAll('.glb', '').trim();
    return ProfileData(avatarId, avatarUrl: avatarUrl);
  }
  return null;
}

// Avatar Profile
class ProfileData {
  ProfileData(this.avatarId, {this.name, this.avatarUrl, this.email});
  final String? avatarId;
  final String? name;
  final String? email;
  final String? avatarUrl;
}

Widget myProccesser() {
  return Center(
    child: LoadingAnimationWidget.discreteCircle(
      color: AppColors.darkGreen,
      secondRingColor: AppColors.lightGreen,
      thirdRingColor: AppColors.extraLightGreen,
      size: 30,
    ),
  );
}
