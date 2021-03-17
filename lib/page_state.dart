import 'package:flutter/material.dart';

abstract class PageState<T extends StatefulWidget> extends State<T>{
  void rightPressed();
  void leftPressed();
  void pushPressed();
  void pullPressed();
}