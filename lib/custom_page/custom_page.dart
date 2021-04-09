import 'dart:async';

import 'package:enabled_app/custom_page/custom_category.dart';
import 'package:enabled_app/custom_page/custom_page_button.dart';
import 'package:enabled_app/custom_page/custom_popup.dart';
import 'package:enabled_app/custom_page/custom_horizontal_list.dart';
import 'package:enabled_app/desktop_connection/server_socket.dart';
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
  ItemPositionsListener itemPositionsListener;

  StreamSubscription sub;

  @override
  void dispose() {
    super.dispose();
    sub.cancel();
  }

  // TODO remove test objects.
  @override
  void initState() {
    super.initState();
    currentFocusedVerticalListIndex = 0;
    currentFocusedHorizontalListIndex = 0;

    void mentalCommands(state) {
      switch (state) {
        case 'right':
          {
            rightPressed();
          }
          break;

        case 'left':
          {
            leftPressed();
          }
          break;
        case 'push':
          {
            pushPressed();
          }
          break;
        case 'pull':
          {
            pullPressed();
          }
          break;
        default:
          {}
          break;
      }
    }

    SocketSingleton socket = SocketSingleton();
    Stream stream = socket.getStream();
    sub = stream.listen((value) {
      setState(() {
        print('Custom page command: ' + value);
        mentalCommands(value);
      });
    });

    /// For testing purposes
    List<String> testObjects = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    CustomCategory customCategory = new CustomCategory("Eskil", testObjects);

    for (var i = 0; i < 7; i++) {
      categoryList.add(customCategory);
    }
  }

  /// Scrolls the list down to the selected index.
  void scrollDown() {
    if (canScrollDown()) {
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
  }

  /// Scrolls the list up to the selected index.
  void scrollUp() {
    if (canScrollUp()) {
      lastScrollIndexUp = currentFocusedVerticalListIndex;
      lastVerticalScrollIndex = currentFocusedVerticalListIndex;

      itemScrollController.scrollTo(
        index: currentFocusedVerticalListIndex,
        duration: Duration(
          seconds: 1,
        ),
        alignment: 0,
        curve: Curves.ease,
      );
    }
  }

  ///Scrolls one of the child list right.
  void scrollRight() {
    if (canScrollRight()) {
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
  }

  // Scrolls one of the child list left.
  void scrollLeft() {
    if (canScrollLeft()) {
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
  }

  bool canScrollUp() {
    if (currentFocusedVerticalListIndex < lastScrollIndexDown - 3 &&
        lastScrollIndexDown != 0) {
      return true;
    }
    return false;
  }

  bool canScrollDown() {
    if (currentFocusedVerticalListIndex > lastScrollIndexUp + 3 &&
        currentFocusedVerticalListIndex > lastVerticalScrollIndex) {
      return true;
    }
    return false;
  }

  bool canScrollRight() {
    //If rightmost button on screen is focused
    if (currentFocusedHorizontalListIndex > lastScrollIndexLeft + 3 &&
        currentFocusedHorizontalListIndex > lastHorizontalScrollIndex) {
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
                        value,
                        ['1', '2', '3'],
                      );
                      categoryList.add(customCategory);
                    });
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
              itemPositionsListener: itemPositionsListener,
              itemCount: categoryList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return new CustomHorizontalList(
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

  List<CustomPageButton> createButtons(index) {
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

  @override
  void rightPressed() {
    setState(() {
      if (inHorizontalList) {
        List<String> horizontalList =
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
        scrollDown();
        return;
      }
    });
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
        scrollUp();
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
        lastHorizontalScrollIndex = 0;
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
}
