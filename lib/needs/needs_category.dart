import 'needs_object.dart';
import 'needs_page_button.dart';

class NeedsCategory {
  String categoryName;
  List<NeedsObject> categoryObjects = [];

  NeedsCategory(this.categoryName, [this.categoryObjects]);

  String get name{
    return this.categoryName;
  }

  List<NeedsObject> get allObjects {
    return this.categoryObjects;
  }

  void addCategoryObjectsList(List<NeedsObject> objects){
    for(NeedsObject s in objects){
      categoryObjects.add(s);
    }
  }

  void addCategoryObject(NeedsObject object){
    categoryObjects.add(object);
  }

  List<NeedsPageButton> allButtons(){
    List<NeedsPageButton> buttonList = [];
    for(var i = 0; i<categoryObjects.length; i++){
      NeedsPageButton button = new NeedsPageButton(text: categoryObjects[i].text);
      buttonList.add(button);
    }
    return buttonList;
  }
}