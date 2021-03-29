import 'package:enabled_app/custom_page/custom_category.dart';
import 'package:enabled_app/custom_page/custom_popup.dart';
import 'package:enabled_app/custom_page/custom_vertical_list.dart';
import 'package:enabled_app/custom_page/vertical_list_buttons.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//TODO create a solution for the "result" object returned from the alert dialog.

class CustomPageHome extends StatefulWidget {
  CustomPageHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CustomPageHome createState() => _CustomPageHome();
}

class _CustomPageHome extends PageState<CustomPageHome> {
  List<CustomCategory> categoryList = [];
  List<CustomVerticalList> verticalList = [];
  List<VerticalListButtons> buttonList = [];

  int verticalListIndex = 0;
  int lastScrollIndexDown = 0;
  int lastScrollIndexUp = 0;
  int lastScrollIndex = 0;

  ItemScrollController childController;
  CustomVerticalList focusedList;

  ItemScrollController itemScrollController;
  ItemPositionsListener itemPositionsListener;

  bool inChildLevel = false;

  // TODO remove test objects.
  @override
  void initState() {
    super.initState();
/**
    SocketSingleton socket = SocketSingleton();

    stream = socket.getStream();
    sub = stream.listen((value) {
      control(value);
      setState(() {
        command = value;
      });
    });
    **/

    /// For testing purposes
    List<String> testObjects = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    CustomCategory customCategory = new CustomCategory();
    customCategory.categoryName = "Eskil";
    customCategory.categoryObjects = testObjects;

    for (var i = 0; i < 7; i++) {
      categoryList.add(customCategory);
    }

    for (var item in categoryList) {
      CustomVerticalList list = new CustomVerticalList(
        categoryTitle: item.categoryName,
        buttonList: item.allButtons(),
      );
      verticalList.add(list);
    }
    focusedList = verticalList[0];
    focusedList.isFocused = true;
  }

  /// Scrolls the list down to the selected index.
  void scrollDown() {
    itemScrollController.scrollTo(
        index: verticalListIndex,
        duration: Duration(
          seconds: 1,
        ),
        alignment: 0.75,
        curve: Curves.ease);
  }

  /// Scrolls the list up to the selected index.
  void scrollUp() {
    itemScrollController.scrollTo(
        index: verticalListIndex,
        duration: Duration(
          seconds: 1,
        ),
        alignment: 0,
        curve: Curves.ease);
  }

  ///Scrolls one of the child list right.
  void scrollRight() {
    verticalList[verticalListIndex].state.scrollRight();
  }

  /// Scrolls one of the child list left.
  void scrollLeft() {
    verticalList[verticalListIndex].state.scrollLeft();
  }

  /// Sets the focus around the selected list.
  void setListFocus() {
    if (focusedList == null) {
      focusedList = verticalList[0];
      focusedList.state.setFocus();
    } else {
      focusedList.state.removeFocus();
      focusedList = verticalList[verticalListIndex];
      focusedList.state.setFocus();
    }
  }

  /// Checks if the list can scroll down or not.
  /// Returns a true if it can scroll and a false if it can't.
  bool canScrollDown() {
    bool canScroll = false;
    if (verticalListIndex < verticalList.length && verticalListIndex > 3) {
      if (verticalListIndex > lastScrollIndexUp + 3 &&
          verticalListIndex > lastScrollIndex) {
        canScroll = true;
      }
    }
    return canScroll;
  }

  /// Checks if the list can scroll up or not.
  /// Returns a true if it can scroll and a false if it can't.
  bool canScrollUp() {
    bool canScroll = false;
    if (verticalListIndex < verticalList.length - 4) {
      if (lastScrollIndexDown != 0 &&
          verticalListIndex < lastScrollIndexDown - 3) {
        canScroll = true;
      }
    }
    return canScroll;
  }

  @override
  Widget build(BuildContext context) {
    /// Controller to scroll or jump to a particular item.
    itemScrollController = ItemScrollController();

    /// Listener that reports the position of items when the list is scrolled.
    itemPositionsListener = ItemPositionsListener.create();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    child: Text("Legg til"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomPopup(
                              items: categoryList,
                            );
                          }).then((value) {
                        setState(() {
                          print("reached: " + value);
                          CustomCategory customCategory = new CustomCategory(
                              categoryObjects: ['1', '2', '3'],
                              categoryName: value);
                          categoryList.add(customCategory);
                        });
                      }).catchError((error) {
                        print(error);
                      });
                    },
                  ))),
          Expanded(
            child: ScrollablePositionedList.builder(
                initialScrollIndex: 0,
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionsListener,
                itemCount: verticalList.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => verticalList[index]),
          ),
        ],
      ),
    );
  }

  @override
  void leftPressed() {
    if (!inChildLevel && verticalListIndex > 0) {
      verticalListIndex--;
      if (canScrollUp()) {
        lastScrollIndexUp = verticalListIndex;
        lastScrollIndex = verticalListIndex;
        scrollUp();
      }
      setListFocus();
    } else if (inChildLevel) {
      scrollLeft();
    }
  }

  @override
  void pullPressed() {
    inChildLevel = false;
    verticalList[verticalListIndex].state.removeButtonFocus();
  }

  @override
  void pushPressed() {
    verticalList[verticalListIndex].state.setButtonFocus();
    inChildLevel = true;
  }

  @override
  void rightPressed() {
    if (!inChildLevel && verticalListIndex < verticalList.length - 1) {
      verticalListIndex++;
      if (canScrollDown()) {
        lastScrollIndexDown = verticalListIndex;
        lastScrollIndex = verticalListIndex;
        scrollDown();
      }
      setListFocus();
    } else if (inChildLevel) {
      scrollRight();
    }
  }
}
