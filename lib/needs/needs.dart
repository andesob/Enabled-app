import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/needs/needs_category.dart';
import 'package:enabled_app/needs/needs_data.dart';
import 'package:enabled_app/needs/needs_horizontal_list.dart';
import 'package:enabled_app/needs/needs_page_button.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'needs_object.dart';

class NeedsPage extends StatefulWidget {
  NeedsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NeedsPageState createState() => _NeedsPageState();
}

class _NeedsPageState extends PageState<NeedsPage> {
  NeedsCategory foodDrinkCategory;
  NeedsCategory hygieneCategory;
  NeedsCategory emotionsCategory;
  NeedsCategory roomCategory;

  List<NeedsCategory> categoryList = [];

  bool inHorizontalList = false;
  int currentFocusedVerticalListIndex;
  int currentFocusedHorizontalListIndex;

  int lastScrollIndexLeft = 0;
  int lastScrollIndexRight = 0;
  int lastScrollIndex = 0;

  ItemScrollController itemScrollController;
  ItemScrollController childScrollController;
  ItemPositionsListener itemPositionsListener;

  void initState() {
    super.initState();

    currentFocusedVerticalListIndex = 0;
    currentFocusedHorizontalListIndex = 0;

    foodDrinkCategory =
        NeedsCategory(Strings.FOOD_DRINK, NeedsData.FOOD_DRINK_OBJECTS);
    hygieneCategory = NeedsCategory(Strings.HYGIENE, NeedsData.HYGIENE_OBJECTS);
    emotionsCategory =
        NeedsCategory(Strings.EMOTIONS, NeedsData.EMOTION_OBJECTS);
    roomCategory = NeedsCategory(Strings.ROOMS, NeedsData.ROOM_OBJECTS);

    categoryList.add(foodDrinkCategory);
    categoryList.add(hygieneCategory);
    categoryList.add(emotionsCategory);
    categoryList.add(roomCategory);
  }

  ///Scrolls one of the child list right.
  void scrollRight() {
    if (canScrollRight()) {
      lastScrollIndexRight = currentFocusedHorizontalListIndex;
      lastScrollIndex = currentFocusedHorizontalListIndex;

      childScrollController.scrollTo(
        index: currentFocusedHorizontalListIndex,
        duration: Duration(
          seconds: 1,
        ),
        alignment: 0.75,
        curve: Curves.ease,
      );
    }
  }

  bool canScrollRight() {
    //If rightmost button on screen is focused
    if (currentFocusedHorizontalListIndex > lastScrollIndexLeft + 3 &&
        currentFocusedHorizontalListIndex > lastScrollIndex) {
      return true;
    }
    return false;
  }

  bool canScrollLeft() {
    //If leftmost button on screen is focused
    if (lastScrollIndexRight != 0 &&
        currentFocusedHorizontalListIndex < lastScrollIndexRight - 3) {
      return true;
    }
    return false;
  }

  /// Scrolls one of the child list left.
  void scrollLeft() {
    if (canScrollLeft()) {
      lastScrollIndexLeft = currentFocusedHorizontalListIndex;
      lastScrollIndex = currentFocusedHorizontalListIndex;

      childScrollController.scrollTo(
        index: currentFocusedHorizontalListIndex,
        duration: Duration(
          seconds: 1,
        ),
        curve: Curves.ease,
      );
    }
  }

  void scrollToStart() {
    childScrollController.scrollTo(
      index: 0,
      duration: Duration(
        seconds: 1,
      ),
      curve: Curves.ease,
    );
  }

  void setChildScrollController(ItemScrollController controller) {
    childScrollController = controller;
  }

  @override
  Widget build(BuildContext context) {
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();

    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
              initialScrollIndex: 0,
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemCount: categoryList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                //print(index == currentFocusedVerticalListIndex);
                return new NeedsHorizontalList(
                  categoryTitle: categoryList[index].name,
                  buttonList: createButtons(index),
                  isFocused: index == currentFocusedVerticalListIndex,
                  setScrollController: setChildScrollController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<NeedsPageButton> createButtons(index) {
    List<NeedsPageButton> buttonList = [];
    List<NeedsObject> objects = categoryList[index].objects;
    for (int i = 0; i < objects.length; i++) {
      NeedsPageButton button = new NeedsPageButton(
        text: objects[i].text,
        icon: objects[i].icon,
        isFocused: inHorizontalList &&
            i == currentFocusedHorizontalListIndex &&
            index == currentFocusedVerticalListIndex,
      );
      buttonList.add(button);
    }

    return buttonList;
  }

  @override
  void leftPressed() {
    setState(() {
      if (inHorizontalList) {
        if (currentFocusedHorizontalListIndex > 0) {
          currentFocusedHorizontalListIndex--;
          scrollLeft();
        }
        return;
      }

      if (currentFocusedVerticalListIndex > 0) {
        currentFocusedVerticalListIndex--;
        return;
      }
    });
  }

  @override
  void pullPressed() {
    setState(() {
      if (inHorizontalList) {
        currentFocusedHorizontalListIndex = 0;
        lastScrollIndexRight = 0;
        lastScrollIndexLeft = 0;
        lastScrollIndex = 0;
        inHorizontalList = false;
        scrollToStart();
      } else {
        Navigator.pop(context);
      }
    });
  }

  @override
  void pushPressed() {
    setState(() {
      inHorizontalList = true;
    });
  }

  @override
  void rightPressed() {
    setState(() {
      if (inHorizontalList) {
        List<NeedsObject> horizontalList =
            categoryList[currentFocusedVerticalListIndex].objects;

        //If not at end of horizontal list
        if (currentFocusedHorizontalListIndex < horizontalList.length - 1) {
          currentFocusedHorizontalListIndex++;
          scrollRight();
        }
        return;
      }

      //If not at end of vertical list
      if (currentFocusedVerticalListIndex < categoryList.length - 1) {
        currentFocusedVerticalListIndex++;
        return;
      }
    });
  }
}
