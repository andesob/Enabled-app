import 'package:flutter/cupertino.dart';

class MainPage extends StatefulWidget{
  MainPage({Key key, this.pageContent}) : super(key: key);
  final StatefulWidget pageContent;

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  @override
  Widget build(BuildContext context) {
    return widget.pageContent;
  }
}