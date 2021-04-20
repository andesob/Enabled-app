import 'package:enabled_app/custom_page/custom_page.dart';
import 'package:enabled_app/needs/needs.dart';
import 'package:enabled_app/needs/needs_horizontal_list.dart';
import 'package:enabled_app/needs/needs_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(home: child);
  }

  testWidgets("", (WidgetTester tester) async{
    NeedsPage page = NeedsPage(title: "Needs", );

//Custom Buttons Test
    await tester.pumpWidget(makeTestableWidget(child: page));
    var needsButtons = find.byType(NeedsPageButton);
    expect(needsButtons, findsNWidgets(18));

//tests ignore offstage widgets
    final horizontalList = find.byType(NeedsHorizontalList);
    expect(horizontalList, findsNWidgets(4));
  });
}