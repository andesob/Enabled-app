import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/custom_page/custom_category.dart';
import 'package:enabled_app/custom_page/custom_popup.dart';
import 'package:enabled_app/custom_page/custom_vertical_list.dart';
import 'package:enabled_app/custom_page/vertical_list_buttons.dart';
import 'package:enabled_app/desktop_connection/server_socket.dart';
import 'package:enabled_app/desktop_connection/socket_singleton.dart';
import 'package:enabled_app/observer/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

//TODO create a solution for the "result" object returned from the alert dialog.

class CustomPageHome extends StatefulWidget {
  CustomPageHome({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CustomPageHome createState() => _CustomPageHome();
}

class _CustomPageHome extends State<CustomPageHome> implements StateListener {
  List<CustomCategory> categoryList = [];
  List<CustomVerticalList> verticalList = [];
  List<VerticalListButtons> buttonList = [];

  int verticalListIndex = 0;
  int lastScrollIndexDown = 0;
  int lastScrollIndexUp = 0;
  int lastScrollIndex = 0;

  ItemScrollController childController;
  CustomVerticalList focusedList;

  SocketSingleton socket = SocketSingleton();
  String command = "No message";

  bool inChildLevel = false;

  // TODO remove test objects.
  @override
  void initState() {
    super.initState();
    socket.startSocket();

    /// For testing purposes
    List<String> testObjects = ['1', '2', '3', '4', '5', '6', '7', '8', '9'];
    CustomCategory customCategory = new CustomCategory();
    customCategory.categoryName = "Eskil";
    customCategory.categoryObjects = testObjects;

    for (var i = 0; i < 7; i++) {
      categoryList.add(customCategory);
    }

    for (var item in categoryList) {
      CustomVerticalList list = new CustomVerticalList(
        categoryTitle: item.categoryName,
        buttonList: item.allButtons(),
      );
      verticalList.add(list);
    }
    focusedList = verticalList[0];
    focusedList.isFocused = true;
  }

  @override
  Widget build(BuildContext context) {
    Color lightPeach = Color(StaticColors.lightPeach);
    Color darkPeach = Color(StaticColors.darkPeach);
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    /// Controller to scroll or jump to a particular item.
    final ItemScrollController itemScrollController = ItemScrollController();

    /// Listener that reports the position of items when the list is scrolled.
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();

    /// Sets the focus around the selected list.
    void setListFocus() {
      if (focusedList == null) {
        focusedList = verticalList[0];
        focusedList.state.setFocus();
      } else {
        focusedList.state.removeFocus();
        focusedList = verticalList[verticalListIndex];
        focusedList.state.setFocus();
      }
    }

    /// Scrolls the list down to the selected index.
    void scrollDown() {
      itemScrollController.scrollTo(
          index: verticalListIndex,
          duration: Duration(
            seconds: 1,
          ),
          alignment: 0.75,
          curve: Curves.ease);
    }

    /// Scrolls the list up to the selected index.
    void scrollUp() {
      itemScrollController.scrollTo(
          index: verticalListIndex,
          duration: Duration(
            seconds: 1,
          ),
          alignment: 0,
          curve: Curves.ease);
    }

    ///Scrolls one of the child list right.
    void scrollRight() {
      verticalList[verticalListIndex].state.scrollRight();
    }

    /// Scrolls one of the child list left.
    void scrollLeft() {
      verticalList[verticalListIndex].state.scrollLeft();
    }

    /// Checks if the list can scroll down or not.
    /// Returns a true if it can scroll and a false if it can't.
    bool canScrollDown() {
      bool canScroll = false;
      if (verticalListIndex < verticalList.length && verticalListIndex > 3) {
        if (verticalListIndex > lastScrollIndexUp + 3 &&
            verticalListIndex > lastScrollIndex) {
          canScroll = true;
        }
      }
      return canScroll;
    }

    /// Checks if the list can scroll up or not.
    /// Returns a true if it can scroll and a false if it can't.
    bool canScrollUp() {
      bool canScroll = false;
      if (verticalListIndex < verticalList.length - 4) {
        if (lastScrollIndexDown != 0 &&
            verticalListIndex < lastScrollIndexDown - 3) {
          canScroll = true;
        }
      }
      return canScroll;
    }

    /// Removes the focus from the selected list.
    void removeListFocus() {
      if (focusedList != null) {
        focusedList.state.removeFocus();
      }
    }

    /// Takes a input from the EEG-brainwear to simulate a down-command.
    void downCommand() {
      if (!inChildLevel && verticalListIndex < verticalList.length - 1) {
        verticalListIndex++;
        if (canScrollDown()) {
          lastScrollIndexDown = verticalListIndex;
          lastScrollIndex = verticalListIndex;
          scrollDown();
        }
        setListFocus();
      } else if (inChildLevel) {
        scrollRight();
      }
    }

    /// Takes a input from the EEG-brainwear to simulate an up-command.
    void upCommand() {
      if (!inChildLevel && verticalListIndex > 0) {
        verticalListIndex--;
        if (canScrollUp()) {
          lastScrollIndexUp = verticalListIndex;
          lastScrollIndex = verticalListIndex;
          scrollUp();
        }
        setListFocus();
      } else if (inChildLevel) {
        scrollLeft();
      }
    }

    /// Takes a input from the EEG-brainwear to simulate a select-command.
    void selectCommand() {
      verticalList[verticalListIndex].state.setButtonFocus();
      inChildLevel = true;
    }

    /// Takes a input from the EEG-brainwear to simulate a back-command.
    void backCommand() {
      inChildLevel = false;
      verticalList[verticalListIndex].state.removeButtonFocus();
    }

    return Container(
      decoration: new BoxDecoration(
          gradient: new LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: [0.0, 1.0],
              colors: [lightPeach, darkPeach])),
      child: Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(isPortrait ? 50 : 30),
            child: GradientAppBar(
                gradient: LinearGradient(colors: [lightPeach, darkPeach]),
                actions: <Widget>[
                  Material(
                    type: MaterialType.transparency,
                  )
                ])),
        body: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  child: Align(
                      alignment: Alignment.centerRight,
                      child: FlatButton(
                        child: Text(command),
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
                              CustomCategory customCategory =
                                  new CustomCategory(
                                      categoryObjects: ['1', '2', '3'],
                                      categoryName: value);
                              categoryList.add(customCategory);
                            });
                          }).catchError((error) {
                            print(error);
                          });
                        },
                      ))),
              Expanded(
                child: ScrollablePositionedList.builder(
                    initialScrollIndex: 0,
                    itemScrollController: itemScrollController,
                    itemPositionsListener: itemPositionsListener,
                    itemCount: verticalList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => verticalList[index]),
              ),
              Center(
                child: Row(
                  children: [
                    Container(
                      child: FlatButton(
                        child: new Text("Opp"),
                        onPressed: () {
                          upCommand();
                        },
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        child: new Text("Ned"),
                        onPressed: () {
                          downCommand();
                        },
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        child: new Text("Ok"),
                        onPressed: () {
                          selectCommand();
                        },
                      ),
                    ),
                    //TODO Add back logic
                    Container(
                      child: FlatButton(
                        child: new Text("Tilbake"),
                        onPressed: () {
                          backCommand();
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onStateChanged(ObserverState state) {
    command = socket.command;
  }
}
