import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/home_page/home_page_button.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/philips_hue/hue_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SmartMainPage extends StatefulWidget {
  SmartMainPage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  SmartMainPageState createState() => SmartMainPageState();
}

class SmartMainPageState extends PageState<SmartMainPage> {
  HueApi api;
  bool apiSuccess = false;

  @override
  void initState() {
    super.initState();
    checkApi();
  }

  void checkApi() async {
    api = HueApi(new Client());
    bool setupResult = await api.setup();
    setState(() {
      apiSuccess = setupResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    double leftRightPadding = MediaQuery.of(context).size.width / 5;

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.fromLTRB(leftRightPadding, 20, leftRightPadding, 0),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
              children: [
                HomePageButton(
                  text: Strings.HUE,
                  enabled: apiSuccess,
                  focused: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void leftPressed() {
    // TODO: implement leftPressed
  }

  @override
  void pullPressed() {
    Navigator.pushReplacementNamed(context, Strings.HOME);
  }

  @override
  void pushPressed() {
    if(apiSuccess) Navigator.pushReplacementNamed(context, Strings.HUE);
  }

  @override
  void rightPressed() {
    // TODO: implement rightPressed
  }
}
