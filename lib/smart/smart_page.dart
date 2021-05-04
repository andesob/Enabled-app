import 'package:enabled_app/global_data/colors.dart';
import 'package:enabled_app/home_page/home_page_button.dart';
import 'package:enabled_app/page_state.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/philips_hue/hue_api.dart';
import 'package:enabled_app/philips_hue/hue_results.dart';
import 'package:enabled_app/smart/refresh_page_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:developer' as developer;

class SmartMainPage extends StatefulWidget {
  SmartMainPage({
    Key key,
    this.title = Strings.SMART,
  }) : super(key: key);

  final String title;

  SmartMainPageState createState() => SmartMainPageState();
}

class SmartMainPageState extends PageState<SmartMainPage> {
  HueApi api;
  bool apiSuccess = false;
  HueResults setupResult;

  @override
  void initState() {
    super.initState();
    checkApi();
  }

  void checkApi() async {
    api = HueApi(new Client());
    setupResult = await api.setup();
    setState(() {
      apiSuccess = setupResult.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (setupResult == null) {
      return Container();
    }
    if (setupResult.id == HueResults.PRESS_BUTTON) {
      return buildRefreshButton();
    } else {
      return buildHueButton();
    }
  }

  Container buildHueButton() {
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

  Container buildRefreshButton() {
    double leftRightPadding = MediaQuery.of(context).size.width / 5;
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.fromLTRB(leftRightPadding, 20, leftRightPadding, 0),
            child: Text(
              "Connecting to Philips Hue Bridge. \nPlease press the button on the bridge and then the button below to continue.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15
              ),
            ),
          ),
          Container(
            padding:
                EdgeInsets.fromLTRB(leftRightPadding, 20, leftRightPadding, 0),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 1,
              children: [
                RefreshPageButton(
                  text: Strings.REFRESH,
                  focused: true,
                  refresh: refreshPage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void refreshPage() {
    setState(() {
      developer.log("Refreshing page: " + widget.title);
      checkApi();
    });
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
    if (apiSuccess) Navigator.pushReplacementNamed(context, Strings.HUE);
    if (setupResult.id == HueResults.PRESS_BUTTON) refreshPage();
  }

  @override
  void rightPressed() {
    // TODO: implement rightPressed
  }
}
