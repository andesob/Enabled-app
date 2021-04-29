import 'package:enabled_app/custom_page/custom_page.dart';
import 'package:enabled_app/home_page/home_page_button.dart';
import 'package:enabled_app/needs/needs.dart';
import 'package:enabled_app/needs/needs_horizontal_list.dart';
import 'package:enabled_app/needs/needs_page_button.dart';
import 'package:enabled_app/smart/smart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(home: child);
  }

  testWidgets("", (WidgetTester tester) async{
    SmartMainPage page = SmartMainPage(title: "Smart", );

//Custom Buttons Test
    await tester.pumpWidget(makeTestableWidget(child: page));
    var smartButtons = find.byType(HomePageButton);
    expect(smartButtons, findsNWidgets(2));
  });
}