import "package:flutter/foundation.dart";
import "package:flutter_test/flutter_test.dart";
import "package:food_app/functionalities/auth/screen/sign_up_screen.dart";
import "package:food_app/functionalities/auth/screen/signup_process.dart";
import "package:integration_test/integration_test.dart";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("E2E (Register Page) - ", () {
    testWidgets("Unauthenticated Flow", (tester) async {
      SignUpScreen();
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byKey(
            Key("username"),
          ),
          "miraP");
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
      await tester.tap(find.byKey(Key("registration_button")));
      await tester.pumpAndSettle();

      expect(find.byType(SignupProcess), findsOneWidget);
    });
  });
}
