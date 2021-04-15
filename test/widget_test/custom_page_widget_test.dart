import 'package:enabled_app/custom_page/custom_page.dart';
import 'package:enabled_app/custom_page/custom_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(home: child);
  }

  testWidgets("", (WidgetTester tester) async{
    CustomPageHome page = CustomPageHome();

    await tester.pumpWidget(makeTestableWidget(child: page));
    
    expect(find.byType(CustomPageButton), findsWidgets);
  });
}