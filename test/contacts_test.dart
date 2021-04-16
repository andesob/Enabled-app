import 'package:enabled_app/contacts_page/contact_item.dart';
import 'package:enabled_app/contacts_page/contacts.dart';
import 'package:enabled_app/home_page/home_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(home: child);
  }

  testWidgets('Home page testing', (WidgetTester tester) async {
    contacts page = contacts();

    await tester.pumpWidget(makeTestableWidget(child: page));

    expect(find.byType(ContactItem), findsWidgets);

  });
}