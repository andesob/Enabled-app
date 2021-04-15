import 'package:enabled_app/contacts_page/contacts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(home: child);
  }

  testWidgets("", (WidgetTester tester) async{
    contacts page = contacts();

    await tester.pumpWidget(makeTestableWidget(child: page));

  });
}