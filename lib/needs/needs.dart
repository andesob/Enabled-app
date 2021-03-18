import 'package:enabled_app/custom_page/custom_category.dart';
import 'package:enabled_app/custom_page/custom_popup.dart';
import 'package:enabled_app/main_layout/button_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/needs/needs_category.dart';
import 'package:enabled_app/needs/needs_vertical_list.dart';
import 'package:enabled_app/needs/needs_page_button.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:enabled_app/colors/colors.dart';

class NeedsPage extends StatefulWidget {
  NeedsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NeedsPageState createState() => _NeedsPageState();
}

class _NeedsPageState extends PageState<NeedsPage> {
  List<NeedsCategory> categoryList = [];
  List<NeedsVerticalList> verticalList = [];

  int verticalListIndex = 0;
  int lastScrollIndexDown = 0;
  int lastScrollIndexUp = 0;
  int lastScrollIndex = 0;

  ItemScrollController childController;
  NeedsVerticalList focusedList;

  ItemScrollController itemScrollController;
  ItemPositionsListener itemPositionsListener;

  bool inChildLevel = false;

  void initState() {
    super.initState();

    List<String> testObjects = ['1', '2', '3', '4', '5'];
    NeedsCategory needsCategory = new NeedsCategory();
    needsCategory.categoryName = 'Sundeersot123';
    needsCategory.categoryObjects = testObjects;

    for (var i = 0; i < 5; i++) {
      categoryList.add(needsCategory);
    }
    for (var item in categoryList) {
      NeedsVerticalList list = new NeedsVerticalList(
        categoryTitle: item.categoryName,
        buttonList: item.allButtons(),
      );
      verticalList.add(list);
      focusedList = verticalList[0];
      focusedList.isFocused = true;
    }
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
    itemScrollController = ItemScrollController();

    itemPositionsListener = ItemPositionsListener.create();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20,),
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
