import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/needs/needs_category.dart';
import 'package:enabled_app/needs/needs_data.dart';
import 'package:enabled_app/needs/needs_horizontal_list.dart';
import 'package:enabled_app/needs/needs_page_button.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/tts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'needs_object.dart';

class NeedsPage extends StatefulWidget {
  NeedsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NeedsPageState createState() => _NeedsPageState();
}

class _NeedsPageState extends PageState<NeedsPage> {
  FlutterTts flutterTts = TTSController().flutterTts;

  List<NeedsCategory> categoryList = [];
  List<NeedsObject> horizontalList = [];

  bool inHorizontalList = false;
  int currentFocusedVerticalListIndex;
  int currentFocusedHorizontalListIndex;

  int lastScrollIndexLeft = 0;
  int lastScrollIndexRight = 0;
  int lastHorizontalScrollIndex = 0;

  ItemScrollController childScrollController;

  void initState() {
    super.initState();

    currentFocusedVerticalListIndex = 0;
    currentFocusedHorizontalListIndex = 0;

    NeedsCategory foodDrinkCategory =
        NeedsCategory(Strings.FOOD_DRINK, NeedsData.FOOD_DRINK_OBJECTS);
    NeedsCategory hygieneCategory =
        NeedsCategory(Strings.HYGIENE, NeedsData.HYGIENE_OBJECTS);
    NeedsCategory emotionsCategory =
        NeedsCategory(Strings.EMOTIONS, NeedsData.EMOTION_OBJECTS);
    NeedsCategory roomCategory =
        NeedsCategory(Strings.ROOMS, NeedsData.ROOM_OBJECTS);

    categoryList.add(foodDrinkCategory);
    categoryList.add(hygieneCategory);
    categoryList.add(emotionsCategory);
    categoryList.add(roomCategory);
  }

  @override
  Widget build(BuildContext context) {
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
              itemCount: categoryList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return new NeedsHorizontalList(
                  categoryTitle: categoryList[index].name,
                  buttonList: _createButtons(index),
                  isFocused: index == currentFocusedVerticalListIndex,
                  setScrollController: _setChildScrollController,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<NeedsPageButton> _createButtons(index) {
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

  ///Scrolls one of the child list right.
  void _goRight() {
    currentFocusedHorizontalListIndex++;
    if (_canScrollRight()) {
      _scrollRight();
    }
  }

  // Scrolls one of the child list left.
  void _goLeft() {
    currentFocusedHorizontalListIndex--;
    if (_canScrollLeft()) {
      _scrollLeft();
    }
  }

  void _goIntoList() {
    horizontalList = categoryList[currentFocusedVerticalListIndex].objects;
    inHorizontalList = true;
  }

  void _goOutOfList() {
    currentFocusedHorizontalListIndex = 0;
    lastScrollIndexRight = 0;
    lastScrollIndexLeft = 0;
    lastHorizontalScrollIndex = 0;
    inHorizontalList = false;
    _scrollToStart();
  }

  bool _canScrollRight() {
    //If rightmost button on screen is focused
    if (currentFocusedHorizontalListIndex > lastScrollIndexLeft + 3 &&
        currentFocusedHorizontalListIndex > lastHorizontalScrollIndex) {
      return true;
    }
    return false;
  }

  bool _canScrollLeft() {
    //If leftmost button on screen is focused
    if (lastScrollIndexRight != 0 &&
        currentFocusedHorizontalListIndex < lastScrollIndexRight - 3) {
      return true;
    }
    return false;
  }

  void _scrollLeft() {
    lastScrollIndexLeft = currentFocusedHorizontalListIndex;
    lastHorizontalScrollIndex = currentFocusedHorizontalListIndex;

    childScrollController.scrollTo(
      index: currentFocusedHorizontalListIndex,
      duration: Duration(
        seconds: 1,
      ),
      curve: Curves.ease,
    );
  }

  void _scrollRight() {
    lastScrollIndexRight = currentFocusedHorizontalListIndex;
    lastHorizontalScrollIndex = currentFocusedHorizontalListIndex;

    childScrollController.scrollTo(
      index: currentFocusedHorizontalListIndex,
      duration: Duration(
        seconds: 1,
      ),
      alignment: 0.75,
      curve: Curves.ease,
    );
  }

  void _scrollToStart() {
    childScrollController.scrollTo(
      index: 0,
      duration: Duration(
        seconds: 1,
      ),
      curve: Curves.ease,
    );
  }

  void _setChildScrollController(ItemScrollController controller) {
    childScrollController = controller;
  }

  @override
  void rightPressed() {
    setState(() {
      if (inHorizontalList) {
        //If not at end of horizontal list
        if (checkIfAtHorizontalListEnd()) {
          _goRight();
        }
        return;
      }

      //If not at end of vertical list
      if (checkIfAtVerticalListEnd()) {
        currentFocusedVerticalListIndex++;
        return;
      }
    });
  }

  @override
  void leftPressed() {
    setState(() {
      if (inHorizontalList) {
        if (checkIfAtHorizontalListStart()) {
          _goLeft();
        }
        return;
      }

      if (checkIfAtVerticalListStart()) {
        currentFocusedVerticalListIndex--;
        return;
      }
    });
  }

  @override
  void pullPressed() {
    setState(() {
      if (inHorizontalList) {
        _goOutOfList();
      } else {
        Navigator.pushReplacementNamed(context, Strings.HOME);
      }
    });
  }

  @override
  void pushPressed() {
    setState(() {
      if (inHorizontalList) {
        _sayButtonText();
      } else {
        _goIntoList();
      }
    });
  }

  void _sayButtonText() {
    flutterTts.speak(horizontalList[currentFocusedHorizontalListIndex].text);
  }

  bool checkIfAtHorizontalListStart() {
    return currentFocusedHorizontalListIndex > 0;
  }

  bool checkIfAtHorizontalListEnd() {
    return currentFocusedHorizontalListIndex < horizontalList.length - 1;
  }

  bool checkIfAtVerticalListStart() {
    return currentFocusedVerticalListIndex > 0;
  }

  bool checkIfAtVerticalListEnd() {
    return currentFocusedVerticalListIndex < categoryList.length - 1;
  }
}
