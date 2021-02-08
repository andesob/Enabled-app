import 'package:enabled_app/needs/needsPageButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class NeedsVerticalList extends StatefulWidget {
  NeedsVerticalList({Key key, this.categoryTitle,this.buttonList})
  : super(key:key);

  final String categoryTitle;
  final List<NeedsVerticalList> buttonList;
  _NeedsVerticalList state;
  bool isFocused = false;

  @override
  _NeedsVerticalList createState(){
    state= _NeedsVerticalList();
    return state;
  }
}

class _NeedsVerticalList extends State<NeedsVerticalList>{
  int listIndex = 0;
  int lastScrollIndexLeft = 0;
  int lastScrollIndexRight = 0;

  final ItemScrollController scrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

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
