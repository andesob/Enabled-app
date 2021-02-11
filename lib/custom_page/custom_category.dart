import 'package:enabled_app/custom_page/vertical_list_buttons.dart';

import 'custom_page_button.dart';

class CustomCategory {
  String categoryName;
  List<String> categoryObjects;

  CustomCategory({this.categoryName, this.categoryObjects});

  String get name {
    return this.categoryName;
  }

  List<String> get allObjects {
    return this.categoryObjects;
  }

  List<CustomPageButton> allButtons() {
    List<CustomPageButton> buttonList = [];
    for (var i = 0; i < categoryObjects.length; i++) {
      CustomPageButton button = new CustomPageButton(text: categoryObjects[i]);
      buttonList.add(button);
    }
    return buttonList;
  }
}
