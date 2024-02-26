// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:mobile_admin/main.dart';
//
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }



import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_admin/screens/all-orders-screen.dart';
import 'package:mobile_admin/screens/all-products-screen.dart';
import 'package:mobile_admin/screens/all-users-screen.dart';
import 'package:mobile_admin/screens/contact-screen.dart';
import 'package:mobile_admin/screens/main-screen.dart';
import 'package:mobile_admin/widgets/drawer-widget.dart';

void main() {
  testWidgets('DrawerWidget UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: DrawerHeader2(),
      ),
    ));

    // Verify the presence of key UI components

    expect(find.text('A.K'), findsOneWidget); // Checking for title
    expect(find.text('Version 1.0.1'), findsOneWidget); // Checking for subtitle
   // Checking for Login icon
  });

}

