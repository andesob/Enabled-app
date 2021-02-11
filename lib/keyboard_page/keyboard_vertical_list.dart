import 'package:enabled_app/custom_page/custom_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class KeyboardVerticalList extends StatefulWidget {
  KeyboardVerticalList({Key key,  this.buttonList})
      : super(key: key);

  final List<CustomPageButton> buttonList;
  bool isFocused = false;
  _KeyboardVerticaList state;

  @override
  _KeyboardVerticaList createState() {
    state = _KeyboardVerticaList();
    return state;
  }
}

class _KeyboardVerticaList extends State<KeyboardVerticalList> {
  int listIndex = 0;
  int lastScrollIndexLeft = 0;
  int lastScrollIndexRight = 0;
  int lastScrollIndex = 0;
  CustomPageButton currentFocusButton;

  /// Controller to scroll or jump to a particular item.
  final ItemScrollController scrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();

  /// Sets the focus around this list.
  void setFocus() {
    if (this.mounted) {
      setState(() {
        widget.isFocused = true;
      });
    } else {
      print("not mounted");
    }
  }

  /// Removes the focus of this list.
  void removeFocus() {
    setState(() {
      widget.isFocused = false;
    });
  }

  /// Scrolls the list to the right of the screen if possible.
  void scrollRight() {
    if (listIndex < widget.buttonList.length - 1) {
      listIndex++;
      if (canScrollRight()) {
        lastScrollIndexRight = listIndex;
        lastScrollIndex = listIndex;
        print("last scroll right :" + lastScrollIndexRight.toString());
        scrollController.scrollTo(
            index: listIndex,
            duration: Duration(
              seconds: 1,
            ),
            alignment: 0.75,
            curve: Curves.ease);
      }
    }
    this.setButtonFocus();
  }

  /// Scrolls the list to the left of the screen if possible.
  void scrollLeft() {
    if (listIndex > 0) {
      listIndex--;
      if (canScrollLeft()) {
        lastScrollIndexLeft = listIndex;
        lastScrollIndex = listIndex;
        scrollController.scrollTo(
            index: listIndex,
            duration: Duration(
              seconds: 1,
            ),
            curve: Curves.ease);
      }
      this.setButtonFocus();
    }
  }

  /// Checks of the list can scroll to the right or not.
  /// Return true if it can scroll and false if it can't.
  bool canScrollRight() {
    bool canScroll = false;
    if (listIndex < widget.buttonList.length && listIndex > 3) {
      if (listIndex > lastScrollIndexLeft + 3 && listIndex > lastScrollIndex) {
        canScroll = true;
      }
    }
    return canScroll;
  }

  /// Checks of the list can scroll to the left or not.
  /// Return true if it can scroll and false if it can't.
  bool canScrollLeft() {
    bool canScroll = false;
    if (listIndex < widget.buttonList.length - 3) {
      if (lastScrollIndexRight != 0 && listIndex < lastScrollIndexRight - 3) {
        canScroll = true;
      }
    }
    return canScroll;
  }

  /// Sets the focus of a button.
  void setButtonFocus() {
    if (currentFocusButton == null) {
      currentFocusButton = widget.buttonList[0];
      currentFocusButton = widget.buttonList[listIndex];
      currentFocusButton.state.setFocus();
    } else {
      currentFocusButton.state.removeFocus();
      currentFocusButton = widget.buttonList[listIndex];
      currentFocusButton.state.setFocus();
    }
  }

  /// Removes the focus of a button.
  void removeButtonFocus() {
    if (currentFocusButton != null) {
      currentFocusButton.state.removeFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Align(alignment: Alignment.topCenter, child: Text("")),
      Flexible(
        child: Container(
          //color: Colors.grey,
          decoration: BoxDecoration(
              border: widget.isFocused
                  ? Border(
                  top: BorderSide(width: 16, color: Colors.grey),
                  bottom: BorderSide(width: 16, color: Colors.grey))
                  : null),
          margin: EdgeInsets.fromLTRB(12, 12, 12, 12),
          height: (MediaQuery.of(context).size.height -
              AppBar().preferredSize.height) /
              6.0,
          child: ScrollablePositionedList.builder(
            initialScrollIndex: 0,
            itemScrollController: scrollController,
            itemPositionsListener: itemPositionsListener,
            itemCount: widget.buttonList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Row(
              children: [
                Container(
                    height: MediaQuery.of(context).size.width * (0.24),
                    width: MediaQuery.of(context).size.width * (0.24),
                    child: widget.buttonList[index])
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
