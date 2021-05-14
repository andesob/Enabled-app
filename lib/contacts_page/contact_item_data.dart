import 'package:uuid/uuid.dart';

/// Contains information of a contact
class ContactItemData {
  /// Firstname of contact
  final String firstName;

  /// Lastname of contact
  final String lastName;

  /// Number of contact
  final String number;

  /// Generates a unique ID for contact
  String _contactId = Uuid().v4();

  ContactItemData({
    this.firstName,
    this.lastName,
    this.number,
  });

  /// Creates contact from json data.
  ///
  /// Useful when storing contact information using [SharedPreferences].
  ContactItemData.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        number = json['number'],
        _contactId = json['contactId'];


  /// Converts contact information to json.
  ///
  /// Useful when storing contact information using [SharedPreferences].
  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'number': this.number,
      'contactId': this._contactId
    };
  }

  /// The firstname of the contact
  String get getFirstname {
    return this.firstName;
  }

  /// The lastname of the contact
  String get getLastname {
    return this.lastName;
  }


  /// The number of the contact
  String get getNumber {
    return this.number;
  }


  /// The ID of the contact
  String get contactId => _contactId;
}
