import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/functionalities/home/screen/home_screen.dart';

void main() {
  //fins all widgets needed
  testWidgets("Test Custom Button", (WidgetTester tester) async {
    final myButton = find.byKey(ValueKey("myCustomButtonKey"));
    final myTextFormField = find.byKey(ValueKey("CustomeTextFormField"));

    // execute the actual test
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));
    await tester.enterText(myButton, "This is the my custom button");
    await tester.tap(myButton);
    await tester.pump(Duration(seconds: 2)); // rebuild the widget after tapping the button
    // await tester.enterText(myTextFormField, "This is the my custom text field");
    // await tester.tap(myTextFormField);
    // await tester.pump(Duration(seconds: 2)); // rebuild the widget after tapping the button

    //check outputs
    expect("This is the my custom button", findsOneWidget);
  });
}
