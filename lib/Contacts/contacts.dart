import 'package:enabled_app/Contacts/ContactPopup.dart';
import 'package:enabled_app/colors/colors.dart';
import 'package:enabled_app/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'ContactItem.dart';

class contacts extends StatefulWidget {
  contacts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _contactState createState() => _contactState();
}

/*

 */
class _contactState extends State<contacts> {
  List<ContactItem> items = [];
  int focusIndex = 0;
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  bool popupActive = false;

  setPopup(bool active) {
    popupActive = active;
  }

  scrollUp(){
    focusIndex++;
    itemScrollController.scrollTo(index: focusIndex, duration: Duration(seconds: 1));
  }

  scrollDown(){
    focusIndex--;
    itemScrollController.scrollTo(index: focusIndex, duration: Duration(seconds: 1));
  }

  bottomButtonPressed(int index){
    print("hello");
  }


  @override
  Widget build(BuildContext context) {
    const Color lightPeach = Color(0xffffecd2);
    const Color darkPeach = Color(0xfffcb7a0);
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    // TODO: REMOVE AFTER TESTING
    for (var i = 0; i < 5; i++) {
      items.add(ContactItem("Test", "Tester", "12345678"));
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
            title: Text("Contacts Page"),
            gradient: LinearGradient(colors: [lightPeach, darkPeach]),
          ),
        ),
        body:
        ScrollablePositionedList.builder(
          padding: EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (context, index) {
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
        bottomNavigationBar: BottomNavigationBar(
          onTap: bottomButtonPressed,
          selectedItemColor: Color(StaticColors.lighterSlateGray),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_upward),
              label: 'Up',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_downward),
              label: 'Down',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Send',
            ),
          ],
        ),
      ),
    );
    throw UnimplementedError();
  }
}
