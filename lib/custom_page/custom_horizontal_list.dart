import 'package:enabled_app/custom_page/custom_page_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../tts_controller.dart';

/// Widget representing a horizontal list or category in the [CustomPage].
class CustomHorizontalList extends StatefulWidget {
  CustomHorizontalList({
    Key key,
    this.categoryTitle,
    this.buttonList,
    this.isFocused = false,
    this.setScrollController,
  }) : super(key: key);

  /// Title of the list
  final String categoryTitle;

  /// [List] containing [CustomPageButton] objects.
  final List<CustomPageButton> buttonList;

  /// [bool] True if this list is focused
  final bool isFocused;

  /// Reports that an [ItemScrollController] has been set.
  final ValueSetter<ItemScrollController> setScrollController;

  @override
  _CustomHorizontalList createState() => _CustomHorizontalList();
}

class _CustomHorizontalList extends State<CustomHorizontalList> {
  FlutterTts flutterTts = TTSController().flutterTts;

  /// Controller to scroll or jump to a particular item.
  ItemScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = new ItemScrollController();
    if (widget.isFocused) {
      widget.setScrollController(scrollController);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isFocused) {
      widget.setScrollController(scrollController);
    }

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
