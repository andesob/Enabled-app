import 'needs_page_button.dart';

class NeedsCategory {
  String categoryName;
  List<String> categoryObjects;

  NeedsCategory({this.categoryName,this.categoryObjects});

  String get name{
    return this.categoryName;
  }

  List<String> get allObjects {
    return this.categoryObjects;
  }

  List<NeedsPageButton> allButtons(){
    List<NeedsPageButton> buttonList = [];
    for(var i = 0; i<categoryObjects.length; i++){
      NeedsPageButton button = new NeedsPageButton(text: categoryObjects[i]);
      buttonList.add(button);
    }
    return buttonList;
  }
}