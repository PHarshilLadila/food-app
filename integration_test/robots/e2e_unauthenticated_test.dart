// import "dart:math";

import "package:flutter/semantics.dart";
import "package:flutter_test/flutter_test.dart";
import "package:food_app/functionalities/auth/screen/login_screen.dart";
import "package:food_app/functionalities/bottom%20navigation%20bar/bottom_navigation_bar.dart";
// import "package:food_app/main.dart" as app;
import "package:integration_test/integration_test.dart";

// import "login_robot.dart";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // late LoginRobot loginRobot;
  group("E2E (login) - ", () {
    testWidgets("Unauthenticated Flow", (tester) async {
      LoginScreen();
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(
            Key("email"),
          ),
          "mira@gmail.com");
      await tester.enterText(
          find.byKey(
            Key("password"),
          ),
          "Mira@123");
      await tester.tap(find.byKey(Key("login_button")));
      await tester.pumpAndSettle();

      expect(find.byType(BottomScreen), findsOneWidget);

      // loginRobot = LoginRobot(tester: tester);

      // loginRobot.verify();
      // await loginRobot.enterEmail("mira@gmail.com");
      // await loginRobot.enterPassword("Mira@123");
      // await loginRobot.tapLoginButton();
      // loginRobot.verify();
    });
  });
}
