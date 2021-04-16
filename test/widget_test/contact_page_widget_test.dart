import 'package:enabled_app/contacts_page/contact_item.dart';
import 'package:enabled_app/contacts_page/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(home: child);
  }

  testWidgets("Contacts Page testing", (WidgetTester tester) async{
    contacts page = contacts(title: "Contacts",);

    //Find only one Add new contact button
    await tester.pumpWidget(makeTestableWidget(child: page));
    var addContactButton = find.byType(FlatButton);
    expect(addContactButton, findsOneWidget);
  });
}