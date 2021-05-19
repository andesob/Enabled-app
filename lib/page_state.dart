import 'package:flutter/material.dart';

/// The abstract class PageState ensures that all pages has the methods for
/// navigating the application through inputs.
abstract class PageState<T extends StatefulWidget> extends State<T> {
  void rightPressed();

  void leftPressed();

  void pushPressed();

  void pullPressed();
}
