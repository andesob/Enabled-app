import 'package:enabled_app/contacts_page/contact_item.dart';
import 'package:enabled_app/contacts_page/contact_popup.dart';
import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/main_layout/button_controller.dart';
import 'package:enabled_app/main_layout/main_appbar.dart';
import 'package:enabled_app/page_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class contacts extends StatefulWidget {
  contacts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _contactState createState() => _contactState();
}

class _contactState extends PageState<contacts> {
  List<ContactItem> items = [];
  int focusIndex = 0;
  int lastFocusIndex = 0;
  final int maxScrollLength = 3;


  bool firstRun = true;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  bool popupActive = false;

  setPopup(bool active) {
    popupActive = active;
  }

  ///Scrolls up to the previous contact on the list.
   void _scrollDown() {
     if (focusIndex < items.length - 1) {
       removeHighlight();
       focusIndex++;
       addHighlight();
       if (canScrollDown()) {
         itemScrollController.scrollTo(
             index: focusIndex, duration: Duration(seconds: 1), alignment: 0.8572);
       }
     }
  }

  ///Scrolls down to the next contact on the list.
  void _scrollUp() {
    if (focusIndex > 0) {
      removeHighlight();
      focusIndex--;
      addHighlight();
      if (canScrollUp()) {
        itemScrollController.scrollTo(
            index: focusIndex, duration: Duration(seconds: 1));
      }
    }
  }

  bool canScrollUp(){
    bool canScroll = false;
    if(focusIndex < items.length - 7){
      canScroll = true;
    }
    return canScroll;
  }

  bool canScrollDown(){
    bool canScroll = false;
    if(focusIndex > 6){
      canScroll = true;
    }
    return canScroll;
  }

  ///Adds bold font to the item in focus.
  addHighlight() {
    setState(() {
      items[focusIndex].state.setHighlightState(true);
    });
  }

  ///Removes bold font to the item not in focus any more.
  removeHighlight() {
    setState(() {
      items[focusIndex].state.setHighlightState(false);
    });
  }

  void _goBack(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: [0.0, 1.0],
              colors: [lightPeach, darkPeach])),
      child: Scaffold(
        appBar: MyAppBar(title: widget.title,),
        body: ScrollablePositionedList.builder(
          padding: EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (context, index){
            final ContactItem item = items[index];
            return item;
          },
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(StaticColors.lighterSlateGray),
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ContactPopup(items: items);
                });
          },
          child: Icon(
            Icons.add,
            color: Color(StaticColors.white),
          ),
        ),
        bottomNavigationBar: ButtonController(onPush: _scrollUp, onPull: _scrollDown, onRight: _goBack,),
      ),
    );
    throw UnimplementedError();
  }

  @override
  void leftPressed() {
    // TODO: implement leftPressed
  }

  @override
  void pullPressed() {
    // TODO: implement pullPressed
  }

  @override
  void pushPressed() {
    // TODO: implement pushPressed
  }

  @override
  void rightPressed() {
    // TODO: implement rightPressed
  }
}
