import 'package:flutter/material.dart';
import 'package:food_app/constant/app_button.dart';
import 'package:food_app/constant/app_colors.dart';
import 'package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart'
    show
        CloseButtonShowType,
        ToastCloseButton,
        ToastificationCallbacks,
        ToastificationItem,
        ToastificationStyle,
        ToastificationType,
        toastification;
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

ToastificationItem appTostMessage(
  BuildContext context,
  ToastificationType type,
  String title,
  String imageAssetSrc,
) {
  return toastification.show(
    context: context,
    type: type,
    style: ToastificationStyle.flatColored,
    autoCloseDuration: const Duration(seconds: 4),
    title: Text(
      title,
      style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
    ),
    // you can also use RichText widget for title and description parameters

    alignment: Alignment.topRight,
    direction: TextDirection.ltr,
    animationDuration: const Duration(milliseconds: 300),

    icon: Image.asset(
      imageAssetSrc,
      height: 50,
      width: 50,
    ),
    showIcon: true, // show or hide the icon
    primaryColor: Colors.green,
    backgroundColor: Colors.white,
    foregroundColor: Colors.black,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: const [
      BoxShadow(
        color: Color(0x07000000),
        blurRadius: 16,
        offset: Offset(0, 16),
        spreadRadius: 0,
      )
    ],

    closeButton: ToastCloseButton(
      showType: CloseButtonShowType.onHover,
      buttonBuilder: (context, onClose) {
        return OutlinedButton.icon(
          onPressed: onClose,
          icon: const Icon(Icons.close, size: 20),
          label: const Text('Close'),
        );
      },
    ),
    closeOnClick: true,
    pauseOnHover: true,
    dragToClose: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    applyBlurEffect: true,
    callbacks: ToastificationCallbacks(
      onTap: (toastItem) => debugPrint('Toast ${toastItem.id} tapped'),
      onCloseButtonTap: (toastItem) =>
          debugPrint('Toast ${toastItem.id} close button tapped'),
      onAutoCompleteCompleted: (toastItem) =>
          debugPrint('Toast ${toastItem.id} auto complete completed'),
      onDismissed: (toastItem) => debugPrint('Toast ${toastItem.id} dismissed'),
    ),
  );
}
