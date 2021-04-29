import 'package:enabled_app/custom_page/custom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(home: child);
  }

  testWidgets("", (WidgetTester tester) async{
    CustomPageHome page = CustomPageHome(title: "Custom", );

    //Find only one Add Custom Button
    await tester.pumpWidget(makeTestableWidget(child: page));
    var addCustomButton = find.byType(FlatButton);
    expect(addCustomButton, findsOneWidget);
  });
}