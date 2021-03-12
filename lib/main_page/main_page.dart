import 'package:enabled_app/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'main_page_button.dart';
import '../strings/strings.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color lightPeach = Color(StaticColors.lightPeach);
  Color darkPeach = Color(StaticColors.apricot);
  Color appBarColorLight = Color(StaticColors.apricot);
  Color appBarColorDark = Color(StaticColors.melon);
  Color backgroundColor = Color(StaticColors.onyx);

  bool darkmode = false;

  int horizontalBtns;
  int verticalBtns;

  List<int> currPos = [0, 0];
  int currXPos = 0;
  int currYPos = 0;
  int pos = 0;

  List<MainPageButton> mainPageBtnList = [];
  var list;

  @override
  void initState() {
    super.initState();
    addDefaultButtons();
  }

  void addDefaultButtons() {
    mainPageBtnList.add(MainPageButton(text: Strings.needs));
    mainPageBtnList.add(MainPageButton(text: Strings.custom));
    mainPageBtnList.add(MainPageButton(text: Strings.keyboard));
    mainPageBtnList.add(MainPageButton(text: Strings.contacts));
    mainPageBtnList.add(MainPageButton(text: Strings.smart));
    mainPageBtnList.add(MainPageButton(text: Strings.emergency));
  }

  void _changeDarkmode() {
    setState(() {
      darkmode = !darkmode;
    });
  }

  void setGridSize(useMobileLayout) {
    setState(() {
      horizontalBtns = useMobileLayout ? 2 : 3;
      verticalBtns = useMobileLayout ? 3 : 2;
      list = List.generate(verticalBtns, (i) => List(horizontalBtns),
          growable: false);

      int index = 0;
      for (int i = 0; i < list.length; i++) {
        for (int j = 0; j < list[i].length; j++) {
          list[i][j] = mainPageBtnList[index];
          index++;
        }
      }
    });
  }

  void moveRight() {
    removeAllFocus();
    currPos[0] == horizontalBtns - 1 ? currPos[0] = 0 : currPos[0]++;
    list[currPos[1]][currPos[0]]._state.setFocus();
  }

  void moveDown() {
    removeAllFocus();
    currPos[1] == verticalBtns - 1 ? currPos[1] = 0 : currPos[1]++;
    list[currPos[1]][currPos[0]]._state.setFocus();
  }

  void goTo() {
    list[currPos[1]][currPos[0]]._state.goToPage(context);
  }

  void removeAllFocus() {
    for (int i = 0; i < mainPageBtnList.length; i++) {
      mainPageBtnList[i].state.removeFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    var shortestSide = MediaQuery.of(context).size.shortestSide;
    bool useMobileLayout = shortestSide < 600;

    setGridSize(useMobileLayout);

    if (useMobileLayout) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight
      ]);
    }

    return _buildLayout(useMobileLayout);
  }

  Widget _buildLayout(useMobileLayout) {

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [lightPeach, darkPeach],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: darkmode ? backgroundColor : Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? MediaQuery.of(context).size.height * 0.07
                  : MediaQuery.of(context).size.height * 0.1),
          child: GradientAppBar(
            gradient:
                LinearGradient(colors: [appBarColorLight, appBarColorDark]),
            actions: <Widget>[
              Material(
                type: MaterialType.transparency,
                child: IconButton(
                    icon: Icon(Icons.accessible_forward),
                    color: Color(
                        darkmode ? StaticColors.black : StaticColors.white),
                    splashColor: Color(Colors.grey.value),
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      _changeDarkmode();
                    }),
              )
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: new ListView(
            children: <Widget>[
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: useMobileLayout ? 2 : 3,
                children: mainPageBtnList.cast<Widget>(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      moveDown();
                    },
                    child: Text(Strings.down),
                    color: Color(StaticColors.lighterSlateGray),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      moveRight();
                    },
                    child: Text(Strings.right),
                    color: Color(StaticColors.lighterSlateGray),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      goTo();
                    },
                    child: Text(Strings.enter),
                    color: Color(StaticColors.lighterSlateGray),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
