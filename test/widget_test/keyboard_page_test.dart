import 'package:enabled_app/keyboard_page/custom_dictionary.dart';
import 'package:enabled_app/keyboard_page/custom_keyboard.dart';
import 'package:enabled_app/keyboard_page/dictionary_item.dart';
import 'package:enabled_app/keyboard_page/keyboard_backspace_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_dictionary_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_horizontal_list.dart';
import 'package:enabled_app/keyboard_page/keyboard_key.dart';
import 'package:enabled_app/keyboard_page/keyboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(home: child);
  }

  //Testing the keyboard page to make sure no duplicate widgets are created,
  //and that the keys behave as expected.
  testWidgets('Keyboard page testing', (WidgetTester tester) async {
    KeyboardPage page = KeyboardPage();
    await tester.pumpWidget(makeTestableWidget(child: page));

    //Expecting to find only one of each of the widgets TextField,
    //CustomKeyboard and CustomDictionary.
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(CustomKeyboard), findsOneWidget);
    expect(find.byType(CustomDictionary), findsOneWidget);

    //Expecting to find 6 rows of keys on the keyboard.
    expect(find.byType(KeyboardHorizontalList), findsNWidgets(6));

    //Expecting 31 KeyboardKeys; 26 letters, spacebar, comma,
    //question mark, exclamation point and send button.
    //Also expecting one backspace key and one dictionary key.
    expect(find.byType(KeyboardKey), findsNWidgets(31));
    expect(find.byType(KeyboardBackspaceKey), findsOneWidget);
    expect(find.byType(KeyboardDictionaryKey), findsOneWidget);

    //Expecting only one widget (Key) with the letter A.
    expect(find.text("A"), findsOneWidget);

    //Expecting no DictionaryItems as files are not read during tests.
    expect(find.byType(DictionaryItem), findsNothing);

    //Testing if TextField gets input when KeyboardKeys are pressed.
    TextField textField = find.byType(TextField).evaluate().first.widget;
    //Expecting empty TextField to begin with.
    expect(textField.controller.text, "");

    //Pressing the keys T-E-S-T.
    await tester.tap(find.byType(KeyboardKey).at(6));
    await tester.tap(find.byType(KeyboardKey).at(1));
    await tester.tap(find.byType(KeyboardKey).at(8));
    await tester.tap(find.byType(KeyboardKey).at(6));

    //Expecting TextField to contain the text "TEST".
    expect(textField.controller.text, "TEST");
  });
}
