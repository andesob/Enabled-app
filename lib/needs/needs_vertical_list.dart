import 'package:enabled_app/needs/needs_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NeedsVerticalList extends StatefulWidget {
  NeedsVerticalList({Key key, this.categoryTitle, this.buttonList})
      : super(key: key);

  final String categoryTitle;
  final List<NeedsPageButton> buttonList;
  _NeedsVerticalList state;
  bool isFocused = false;

  @override
  _NeedsVerticalList createState() {
    state = _NeedsVerticalList();
    return state;
  }
}

class _NeedsVerticalList extends State<NeedsVerticalList> {
  int listIndex = 0;
  int lastScrollIndexLeft = 0;
  int lastScrollIndexRight = 0;
  int lastScrollIndex = 0;
  NeedsPageButton currentFocusButton;

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  /// Sets the focus around this list.
  void setFocus() {
    setState(() {
      widget.isFocused = true;
    });
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(widget.categoryTitle),
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                border: widget.isFocused
                    ? Border(
                        top: BorderSide(width: 8, color: Colors.grey),
                        bottom: BorderSide(width: 8, color: Colors.grey),
                      )
                    : null),
            margin: EdgeInsets.fromLTRB(6, 6, 6, 6),
            height: (MediaQuery.of(context).size.height -
                    AppBar().preferredSize.height -
                    kBottomNavigationBarHeight) /
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
                    child: widget.buttonList[index],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
