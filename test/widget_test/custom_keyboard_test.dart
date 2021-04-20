import 'package:enabled_app/keyboard_page/custom_dictionary.dart';
import 'package:enabled_app/keyboard_page/custom_keyboard.dart';
import 'package:enabled_app/keyboard_page/keyboard_horizontal_list.dart';
import 'package:enabled_app/keyboard_page/keyboard_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(home: child,);
  }

  testWidgets('Keyboard page testing', (WidgetTester tester) async{
    List<String> firstRow = [" ", "E", "A", "N", "L", "F"];
    List<String> secondRow = ["T", "O", "S", "D", "P", "B"];
    List<String> thirdRow = ["I", "R", "C", "G", "V", "J"];
    List<String> fourthRow = ["H", "U", "W", "K", "Q", "?"];
    List<String> fifthRow = ["M", "Y", "X", "Z", ",", "!"];

    List<List<String>> allRows = [];
    allRows.add(firstRow);
    allRows.add(secondRow);
    allRows.add(thirdRow);
    allRows.add(fourthRow);
    allRows.add(fifthRow);

    CustomKeyboard page = CustomKeyboard(allRows: allRows,);
    await tester.pumpWidget(makeTestableWidget(child: page));

    expect(find.byType(KeyboardHorizontalList), findsNWidgets(6));
    expect(find.byType(KeyboardKey), findsNothing);
  });
}