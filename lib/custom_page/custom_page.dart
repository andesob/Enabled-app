import 'dart:convert';

import 'package:enabled_app/custom_page/custom_category.dart';
import 'package:enabled_app/custom_page/custom_page_button.dart';
import 'package:enabled_app/custom_page/custom_popup.dart';
import 'package:enabled_app/custom_page/custom_horizontal_list.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/tts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

/// Widget representing the CustomPage
class CustomPage extends StatefulWidget {
  CustomPage({
    Key key,
    this.title,
  }) : super(key: key);

  /// Title of the page
  final String title;

  @override
  _CustomPageHome createState() => _CustomPageHome();
}

class _CustomPageHome extends PageState<CustomPage> {
  /// Instance of [FlutterTts] used to convert text to speech
  FlutterTts flutterTts = TTSController().flutterTts;

  SharedPreferences prefs;

  /// This is the vertical list of categories on the [CustomPage]
  ///
  /// [List] containing [CustomCategory] objects.
  List<CustomCategory> categoryList = [];

  /// The horizontal list that is currently entered.
  ///
  /// [List] of [String] objects to keep track of what horizontal list is currently entered.
  /// Used to know what [String] object should be used for text-to-speech.
  List<String> currentHorizontalList = [];

  /// Variable that tells if a horizontal list is entered or not.
  bool inHorizontalList = false;

  /// Keeps track of what category is currently focused.
  ///
  /// [int] ranging between 0 and total amount of categories - 1.
  int currentFocusedVerticalListIndex = 0;

  /// Keeps track of what object is currently focused.
  ///
  /// [int] ranging between 0 and total amount of [String] objects in the category - 1.
  int currentFocusedHorizontalListIndex = 0;

  /// Keeps track of the last index scrolled down to.
  ///
  /// Only gets updated if the list actually scrolls, not if another element is focused.
  /// Used to know if phone can scroll up.
  int lastScrollIndexDown = 0;

  /// Keeps track of the last index scrolled up to.
  ///
  /// Only gets updated if the list actually scrolls, not if another element is focused.
  /// Used to know if the phone can scroll down.
  int lastScrollIndexUp = 0;

  /// Keeps track of the last index scrolled left to.
  ///
  /// Only gets updated if the list actually scrolls, not if another element is focused.
  /// Used to know if the phone can scroll right.
  int lastScrollIndexLeft = 0;

  /// Keeps track of the last index scrolled left to.
  ///
  /// Only gets updated if the list actually scrolls, not if another element is focused.
  /// Used to know if the phone can scroll left.
  int lastScrollIndexRight = 0;

  /// Keeps track of the last index vertically scrolled to.
  ///
  /// Equal to either [lastScrollIndexUp] or [lastScrollIndexUp].
  int lastVerticalScrollIndex = 0;

  /// Keeps track of the last index horizontally scrolled to.
  ///
  /// Equal to either [lastScrollIndexLeft] or [lastScrollIndexRight].
  int lastHorizontalScrollIndex = 0;

  /// Scrollcontroller for the vertical list.
  ItemScrollController itemScrollController;

  /// Scrollcontroller for the horizontal list currently focused.
  ///
  /// Is set when entering a horizontal list.
  ItemScrollController childScrollController;

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      // Adds information stored in SharedPreferences.
      List<String> categories = prefs.getStringList('categories');

      // Returns if no information is stored in SharedPreferences.
      if (categories == null) return;

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

    itemScrollController = ItemScrollController();
  }

  /// Sets the Scrollcontroller for the horizontal list currently focused.
  ///
  /// This method is passed to [CustomHorizontalList] which calls it.
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
                      }).then((value) {
                    setState(() {
                      developer.log("Value");
                    });
                  }).catchError((error) {
                    developer.log("Error");
                    //developer.log(error.toString());
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

  /// Creates the list of [CustomPageButton] objects to be rendered on the page.
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

  /// Navigates to the next element in the list.
  void _goDown() {
    currentFocusedVerticalListIndex++;
    if (_canScrollDown()) {
      _scrollDown();
    }
  }

  /// Navigates to the previous element in the list.
  void _goUp() {
    currentFocusedVerticalListIndex--;
    if (_canScrollUp()) {
      _scrollUp();
    }
  }

  /// Navigates to the next element in the list.
  void _goRight() {
    currentFocusedHorizontalListIndex++;
    if (_canScrollRight()) {
      _scrollRight();
    }
  }

  /// Navigates to the previous element in the list.
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

  /// Enters a horizontal list.
  void _goIntoList() {
    currentHorizontalList =
        categoryList[currentFocusedVerticalListIndex].objects;
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

  /// Scrolls one of the child list left.
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

  /// Scrolls one of the child list right.
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

  /// Scrolls the list up to the selected index.
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

  /// Scrolls the list down to the selected index.
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

  /// Scrolls to the start of the list.
  void _scrollToStart() {
    childScrollController.scrollTo(
      index: 0,
      duration: Duration(
        seconds: 1,
      ),
      curve: Curves.ease,
    );
  }

  /// Use [FlutterTts] to say text out loud.
  void _sayButtonText() {
    currentHorizontalList =
        categoryList[currentFocusedVerticalListIndex].objects;
    flutterTts.speak(currentHorizontalList[currentFocusedHorizontalListIndex]);
  }

  void _sayCategoryText() {
    flutterTts
        .speak(categoryList[currentFocusedVerticalListIndex].categoryName);
  }

  /// Called when the Right button in the bottom navigation bar is pressed.
  @override
  void rightPressed() {
    setState(() {
      if (inHorizontalList) {
        //If not at end of horizontal list
        if (!atHorizontalListEnd()) {
          _goRight();
        }
        return;
      }

      //If not at end of vertical list
      if (!atVerticalListEnd()) {
        _goDown();
        return;
      }
    });
  }

  /// Called when the Left button in the bottom navigation bar is pressed.
  @override
  void leftPressed() {
    setState(() {
      if (inHorizontalList) {
        //If not at start of horizontal list
        if (!atHorizontalListStart()) {
          _goLeft();
        }
        return;
      }

      //If not at start of vertical list
      if (!atVerticalListStart()) {
        _goUp();
        return;
      }
    });
  }

  /// Called when the Pull button in the bottom navigation bar is pressed.
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

  /// Called when the Push button in the bottom navigation bar is pressed.
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

  bool atHorizontalListStart() {
    return currentFocusedHorizontalListIndex == 0;
  }

  bool atHorizontalListEnd() {
    return currentFocusedHorizontalListIndex ==
        currentHorizontalList.length - 1;
  }

  bool atVerticalListStart() {
    return currentFocusedVerticalListIndex == 0;
  }

  bool atVerticalListEnd() {
    return currentFocusedVerticalListIndex == categoryList.length - 1;
  }
}
