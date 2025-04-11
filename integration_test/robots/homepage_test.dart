import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/functionalities/home/screen/home_screen.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("E2E (login) - ", () {
    testWidgets("Unauthenticated Flow", (tester) async {
      HomeScreen();
      await tester.pumpAndSettle();

      tester.viewOf(find.byKey(Key("foodCategoryList")));

      await tester.tap(find.byKey(Key("otherCategories")));

      await tester.pumpAndSettle();

      // expect(find.byType(SignupProcess), findsOneWidget);
    });
  });
}
