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

/// Widget representing the Needs page.
class NeedsPage extends StatefulWidget {
  NeedsPage({Key key, this.title}) : super(key: key);

  /// Title of the page
  final String title;

  @override
  _NeedsPageState createState() => _NeedsPageState();
}

class _NeedsPageState extends PageState<NeedsPage> {
  /// Instance of [FlutterTts] used to convert text to speech
  FlutterTts flutterTts = TTSController().flutterTts;

  /// This is the vertical list of categories on the [NeedsPage]
  ///
  /// [List] containing [NeedsCategory] objects.
  List<NeedsCategory> categoryList = [];

  /// The horizontal list that is currently entered.
  ///
  /// [List] of [String] objects to keep track of what horizontal list is currently entered.
  /// Used to know what [String] object should be used for text-to-speech.
  List<NeedsObject> horizontalList = [];

  /// Variable that tells if a horizontal list is entered or not.
  bool inHorizontalList = false;

  /// Keeps track of what category is currently focused.
  ///
  /// [int] ranging between 0 and total amount of categories - 1.
  int currentFocusedVerticalListIndex;

  /// Keeps track of what object is currently focused.
  ///
  /// [int] ranging between 0 and total amount of [String] objects in the category - 1.
  int currentFocusedHorizontalListIndex;

  /// Keeps track of the last index scrolled down to.
  ///
  /// Only gets updated if the list actually scrolls, not if another element is focused.
  /// Used to know if phone can scroll up.
  int lastScrollIndexLeft = 0;

  /// Keeps track of the last index scrolled up to.
  ///
  /// Only gets updated if the list actually scrolls, not if another element is focused.
  /// Used to know if the phone can scroll down.
  int lastScrollIndexRight = 0;

  /// Keeps track of the last index horizontally scrolled to.
  ///
  /// Equal to either [lastScrollIndexLeft] or [lastScrollIndexRight].
  int lastHorizontalScrollIndex = 0;

  /// Scrollcontroller for the vertical list.
  ItemScrollController childScrollController;

  void initState() {
    super.initState();

    currentFocusedVerticalListIndex = 0;
    currentFocusedHorizontalListIndex = 0;

    /// Creates the pre-set objects from NeedsData.
    NeedsCategory foodDrinkCategory =
        NeedsCategory(Strings.FOOD_DRINK, NeedsData.FOOD_DRINK_OBJECTS);
    NeedsCategory hygieneCategory =
        NeedsCategory(Strings.HYGIENE, NeedsData.HYGIENE_OBJECTS);
    NeedsCategory emotionsCategory =
        NeedsCategory(Strings.EMOTIONS, NeedsData.EMOTION_OBJECTS);
    NeedsCategory roomCategory =
        NeedsCategory(Strings.ROOMS, NeedsData.ROOM_OBJECTS);

    /// Adds the pre-set objects to the category list.
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

  /// Creates the list of [NeedsPageButton] objects to be rendered on the page.
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

  ///Scrolls one of the child lists right.
  void _goRight() {
    currentFocusedHorizontalListIndex++;
    if (_canScrollRight()) {
      _scrollRight();
    }
  }

  /// Scrolls one of the child lists left.
  void _goLeft() {
    currentFocusedHorizontalListIndex--;
    if (_canScrollLeft()) {
      _scrollLeft();
    }
  }

  /// Moves the focus to the horizontal list.
  void _goIntoList() {
    horizontalList = categoryList[currentFocusedVerticalListIndex].objects;
    inHorizontalList = true;
  }

  /// Moves the focus away from the horizontal list and to the vertical list.
  void _goOutOfList() {
    currentFocusedHorizontalListIndex = 0;
    lastScrollIndexRight = 0;
    lastScrollIndexLeft = 0;
    lastHorizontalScrollIndex = 0;
    inHorizontalList = false;
    _scrollToStart();
  }

  /// Checks if it is possible to navigate to the right.
  bool _canScrollRight() {
    //If rightmost button on screen is focused
    if (currentFocusedHorizontalListIndex > lastScrollIndexLeft + 3 &&
        currentFocusedHorizontalListIndex > lastHorizontalScrollIndex) {
      return true;
    }
    return false;
  }

  /// Checks if it is possible to navigate to the left.
  bool _canScrollLeft() {
    //If leftmost button on screen is focused
    if (lastScrollIndexRight != 0 &&
        currentFocusedHorizontalListIndex < lastScrollIndexRight - 3) {
      return true;
    }
    return false;
  }

  /// Scrolls the list to the left.
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

  /// Scrolls the list to the right.
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

  /// Scrolls the list to the start.
  void _scrollToStart() {
    childScrollController.scrollTo(
      index: 0,
      duration: Duration(
        seconds: 1,
      ),
      curve: Curves.ease,
    );
  }

  /// Sets the child controller.
  void _setChildScrollController(ItemScrollController controller) {
    childScrollController = controller;
  }

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
        currentFocusedVerticalListIndex++;
        return;
      }
    });
  }

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

  /// Reads the text of the button out loud through the text-to-speech controller.
  void _sayButtonText() {
    flutterTts.speak(horizontalList[currentFocusedHorizontalListIndex].text);
  }

  /// Checks if the horizontal list is at the start.
  bool atHorizontalListStart() {
    return currentFocusedHorizontalListIndex == 0;
  }

  /// Check if the horizontal list is at the end.
  bool atHorizontalListEnd() {
    return currentFocusedHorizontalListIndex == horizontalList.length - 1;
  }

  /// Check if the vertical list is at the start.
  bool atVerticalListStart() {
    return currentFocusedVerticalListIndex == 0;
  }

  /// Check if the vertical list is at the end.
  bool atVerticalListEnd() {
    return currentFocusedVerticalListIndex < categoryList.length - 1;
  }
}
