import 'package:enabled_app/emergency_page/emergency_button.dart';
import 'package:enabled_app/home_page/home_page.dart';
import 'package:enabled_app/home_page/home_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(home: child);
  }

  testWidgets('Home page testing', (WidgetTester tester) async {
    MyHomePage page = MyHomePage();

    await tester.pumpWidget(makeTestableWidget(child: page));

    //Verify that each string is only found once.
    expect(find.text("Needs"), findsOneWidget);
    expect(find.text("Custom"), findsOneWidget);
    expect(find.text("Keyboard"), findsOneWidget);
    expect(find.text("Contacts"), findsOneWidget);
    expect(find.text("Smart"), findsOneWidget);
    expect(find.text("Emergency"), findsOneWidget);

    //Verify that strings from other pages are not found.
    expect(find.text("Medication"), findsNothing);
    expect(find.text("Enabled"), findsNothing);

    //Verify that only 5 HomePageButtons and 1 EmergencyButton are found.
    var homePageBtn = find.byType(HomePageButton);
    expect(homePageBtn, findsNWidgets(5));

    var emergencyBtn = find.byType(EmergencyButton);
    expect(emergencyBtn, findsOneWidget);
  });
}
