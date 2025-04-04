import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_app/functionalities/3d%20avatar/avatar_profile.dart';
import 'package:food_app/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';

class My3dAvatar extends StatefulWidget {
  const My3dAvatar({super.key});

  @override
  State<My3dAvatar> createState() => _My3dAvatarState();
}

class _My3dAvatarState extends State<My3dAvatar> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    initializeWebView();
  }

  void initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'AvatarCreated',
        onMessageReceived: (JavaScriptMessage message) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('avatar', message.message);
          final user = userFromPrefs(prefs);
          if (!mounted) return;
          if (user != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AvatarProfile(
                  data: user,
                ),
              ),
            );
          }
          debugPrint("Received message from WebView: ${message.message}");
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            debugPrint("WebView Error: ${error.description}");
          },
          onPageFinished: (String url) {
            debugPrint("WebView Loaded: $url");
          },
        ),
      );

    loadHtmlFromAssets();
  }

  Future<void> loadHtmlFromAssets() async {
    String fileText = await rootBundle.loadString('assets/iframe.html');
    _controller.loadRequest(
      Uri.dataFromString(
        fileText,
        mimeType: 'text/html',
        encoding: Encoding.getByName('utf-8'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: const Text(
          "3D Avatar",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
