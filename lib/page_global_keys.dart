import 'package:enabled_app/page_state.dart';
import 'package:flutter/cupertino.dart';

/// The PageGlobalKeys contains the [GlobalKey] for each page. [GlobalKey] is a
/// key that is unique across the entire app. [GlobalKey] can be used to access
/// information about another widget in a different part of the widget tree and
/// allows for change of a parent widget without loosing the state.
class PageGlobalKeys {
  static GlobalKey<PageState> homePageKey = GlobalKey();
  static GlobalKey<PageState> needsPageKey = GlobalKey();
  static GlobalKey<PageState> customPageKey = GlobalKey();
  static GlobalKey<PageState> contactsPageKey = GlobalKey();
  static GlobalKey<PageState> keyboardPageKey = GlobalKey();
  static GlobalKey<PageState> smartPageKey = GlobalKey();
  static GlobalKey<PageState> huePageKey = GlobalKey();
}
