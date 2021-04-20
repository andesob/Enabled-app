import 'package:enabled_app/keyboard_page/custom_dictionary.dart';
import 'package:enabled_app/keyboard_page/custom_keyboard.dart';
import 'package:enabled_app/keyboard_page/dictionary_item.dart';
import 'package:enabled_app/keyboard_page/keyboard_backspace_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_capslock_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_horizontal_list.dart';
import 'package:enabled_app/keyboard_page/keyboard_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(home: child);
  }

  testWidgets('Keyboard page testing', (WidgetTester tester) async{
    KeyboardPage page = KeyboardPage();
    await tester.pumpWidget(makeTestableWidget(child: page));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(CustomKeyboard), findsOneWidget);
    expect(find.byType(CustomDictionary), findsOneWidget);

    expect(find.byType(KeyboardHorizontalList), findsNWidgets(6));
    expect(find.byType(KeyboardKey), findsNWidgets(31));
    expect(find.byType(KeyboardBackspaceKey), findsOneWidget);
    expect(find.byType(KeyboardCapslockKey), findsOneWidget);
    expect(find.text("A"), findsOneWidget);
    expect(find.byType(DictionaryItem), findsNothing);
  });
}