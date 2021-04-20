import 'dart:async';
import 'dart:convert';

import 'package:enabled_app/custom_page/custom_category.dart';
import 'package:enabled_app/custom_page/custom_page_button.dart';
import 'package:enabled_app/custom_page/custom_popup.dart';
import 'package:enabled_app/custom_page/custom_horizontal_list.dart';
import 'package:enabled_app/desktop_connection/server_socket.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/tts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

//TODO create a solution for the "result" object returned from the alert dialog.

class CustomPageHome extends StatefulWidget {
  CustomPageHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CustomPageHome createState() => _CustomPageHome();
}

class _CustomPageHome extends PageState<CustomPageHome> {
  FlutterTts flutterTts = TTSController().flutterTts;

  SharedPreferences prefs;

  List<CustomCategory> categoryList = [];
  List<String> horizontalList = [];

  bool inHorizontalList = false;
  int currentFocusedVerticalListIndex;
  int currentFocusedHorizontalListIndex;

  int lastScrollIndexDown = 0;
  int lastScrollIndexUp = 0;
  int lastScrollIndexLeft = 0;
  int lastScrollIndexRight = 0;
  int lastVerticalScrollIndex = 0;
  int lastHorizontalScrollIndex = 0;

  ItemScrollController itemScrollController;
  ItemScrollController childScrollController;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> categories = prefs.getStringList('categories');
      for (String s in categories) {
        CustomCategory category = CustomCategory.fromJson(jsonDecode(s));
        categoryList.add(category);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    initPrefs();

    currentFocusedVerticalListIndex = 0;
    currentFocusedHorizontalListIndex = 0;

    itemScrollController = ItemScrollController();
  }

  void _setChildScrollController(ItemScrollController controller) {
    childScrollController = controller;
  }

  @override
  Widget build(BuildContext context) {
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
                      }).catchError((error) {
                    print(error);
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
              initialScrollIndex: 0,
              itemScrollController: itemScrollController,
              itemCount: categoryList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return new CustomHorizontalList(
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

  List<CustomPageButton> _createButtons(index) {
    List<CustomPageButton> buttonList = [];
    List<String> objects = categoryList[index].objects;
    for (int i = 0; i < objects.length; i++) {
      CustomPageButton button = new CustomPageButton(
        text: objects[i],
        isFocused: inHorizontalList &&
            i == currentFocusedHorizontalListIndex &&
            index == currentFocusedVerticalListIndex,
      );
      buttonList.add(button);
    }
    return buttonList;
  }

  /// Scrolls the list down to the selected index.
  void _goDown() {
    currentFocusedVerticalListIndex++;
    if (_canScrollDown()) {
      _scrollDown();
    }
  }

  /// Scrolls the list up to the selected index.
  void _goUp() {
    currentFocusedVerticalListIndex--;
    if (_canScrollUp()) {
      _scrollUp();
    }
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

  void _goOutOfList() {
    currentFocusedHorizontalListIndex = 0;
    lastScrollIndexRight = 0;
    lastScrollIndexLeft = 0;
    lastHorizontalScrollIndex = 0;
    inHorizontalList = false;
    _scrollToStart();
  }

  void _goIntoList() {
    horizontalList = categoryList[currentFocusedVerticalListIndex].objects;
    inHorizontalList = true;
  }

  bool _canScrollUp() {
    if (currentFocusedVerticalListIndex < lastScrollIndexDown - 3 &&
        lastScrollIndexDown != 0) {
      return true;
    }
    return false;
  }

  bool _canScrollDown() {
    if (currentFocusedVerticalListIndex > lastScrollIndexUp + 3 &&
        currentFocusedVerticalListIndex > lastVerticalScrollIndex) {
      return true;
    }
    return false;
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

  void _scrollUp() {
    lastScrollIndexUp = currentFocusedVerticalListIndex;
    lastVerticalScrollIndex = currentFocusedVerticalListIndex;

    itemScrollController.scrollTo(
      index: currentFocusedVerticalListIndex,
      duration: Duration(
        seconds: 1,
      ),
      curve: Curves.ease,
    );
  }

  void _scrollDown() {
    lastScrollIndexDown = currentFocusedVerticalListIndex;
    lastVerticalScrollIndex = currentFocusedVerticalListIndex;

    itemScrollController.scrollTo(
      index: currentFocusedVerticalListIndex,
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

  void _sayButtonText() {
    horizontalList = categoryList[currentFocusedVerticalListIndex].objects;
    flutterTts.speak(horizontalList[currentFocusedHorizontalListIndex]);
  }

  void _sayCategoryText() {
    flutterTts
        .speak(categoryList[currentFocusedVerticalListIndex].categoryName);
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
        _goDown();
        return;
      }
    });
  }

  @override
  void leftPressed() {
    setState(() {
      if (inHorizontalList) {
        //If not at start of horizontal list
        if (checkIfAtHorizontalListStart()) {
          _goLeft();
        }
        return;
      }

      //If not at start of vertical list
      if (checkIfAtVerticalListStart()) {
        _goUp();
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
      if (!inHorizontalList) {
        _goIntoList();
      } else {
        _sayButtonText();
      }
    });
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
