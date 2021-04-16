import 'package:enabled_app/home_page/home_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(home: child);
  }

  testWidgets('Home page button testing', (WidgetTester tester) async {
    HomePageButton needsPage = HomePageButton(text: "Needs", focused: true,);
    await tester.pumpWidget(makeTestableWidget(child: needsPage));

    //Verify that title is found once, and that other strings are not found
    expect(find.text("Needs"), findsOneWidget);
    expect(find.text("Enabled"), findsNothing);

    HomePageButton customPage = HomePageButton(text: "Custom", focused: false,);
    await tester.pumpWidget(makeTestableWidget(child: customPage));

    //Verify that the title is found once, and that previous title not found
    expect(find.text("Custom"), findsOneWidget);
    expect(find.text("Needs"), findsNothing);

  });
}