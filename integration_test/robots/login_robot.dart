import 'package:flutter/material.dart' show Key;
import 'package:flutter_test/flutter_test.dart';

class LoginRobot {
  final WidgetTester tester;

  LoginRobot({required this.tester});

  void verify() {
    final loginScreen = find.byKey(const Key('login_screen'));
    expect(loginScreen, findsOneWidget);
  }

  Future<void> enterEmail(String email) async {
    final emailField = find.byKey(const Key('email'));
    expect(emailField, findsOneWidget);
    await tester.enterText(emailField, email);
    await tester.pump();
  }

  Future<void> enterPassword(String password) async {
    final passwordField = find.byKey(const Key('password'));
    expect(passwordField, findsOneWidget);
    await tester.enterText(passwordField, password);
    await tester.pump();
  }

  Future<void> tapLoginButton() async {
    final loginbutton = find.byKey(Key("login_button"));
    expect(loginbutton, findsOneWidget);
    await tester.tap(loginbutton);
    await tester.pumpAndSettle();
  }
}
