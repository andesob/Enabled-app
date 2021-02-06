import 'package:enabled_app/custom_page/CustomPageButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CustomVerticalList extends StatefulWidget {
  CustomVerticalList({Key key, this.categoryTitle, this.buttonList})
      : super(key: key);

  final String categoryTitle;
  List<CustomPageButton> buttonList = [];
  bool isFocused = false;
  _CustomVerticaList state;

  @override
  _CustomVerticaList createState() {
    state = _CustomVerticaList();
    return state;
  }
}

//TODO Find a solution to the "buggy" behavior on the last scrolls in the scrollable position list
class _CustomVerticaList extends State<CustomVerticalList> {
  /// The name of the Category
  int listIndex = 0;
  CustomPageButton currentFocusButton;

  /// Controller to scroll or jump to a particular item.
  final ItemScrollController scrollController = ItemScrollController();

  /// Listener that reports the position of items when the list is scrolled.
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  void setFocus() {
    if (this.mounted) {
      setState(() {
        widget.isFocused = true;
      });
    } else {
      print("not mounted");
    }
  }

  void removeFocus() {
    setState(() {
      widget.isFocused = false;
    });
  }

  // TODO create a scroll-check.
  scrollRight() {
    if (listIndex < widget.buttonList.length - 1) {
      listIndex++;
      if (listIndex < widget.buttonList.length - 3) {
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

  scrollLeft() {
    if (listIndex > 0) {
      listIndex--;
      if (listIndex < widget.buttonList.length - 3) {
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

  void removeButtonFocus() {
    if (currentFocusButton != null) {
      currentFocusButton.state.removeFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Align(alignment: Alignment.topCenter, child: Text(widget.categoryTitle)),
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
                              height:
                                  MediaQuery.of(context).size.width * (0.24),
                              width: MediaQuery.of(context).size.width * (0.24),
                              child: widget.buttonList[index])
                        ],
                      )))),
    ]);
  }
}
