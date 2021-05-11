class HueResults {
  static const int CONNECTION_SUCCESSFUL = 1;
  static const int USER_IN_PREFS = 2;
  static const int USER_CREATED = 3;
  static const int NO_BRIDGE_FOUND = 10;
  static const int PRESS_BUTTON = 11;
  static const int UNKNOWN_USER_ERROR = 12;

  int id;
  bool success;
  String message;

  HueResults(this.id, this.success, this.message);
}
