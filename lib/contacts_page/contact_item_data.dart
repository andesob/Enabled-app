import 'package:uuid/uuid.dart';

class ContactItemData {
  final String firstName;
  final String lastName;
  final String number;
  String _contactId = Uuid().v4();

  ContactItemData({
    this.firstName,
    this.lastName,
    this.number,
  });

  ContactItemData.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        number = json['number'],
        _contactId = json['contactId'];

  Map<String, dynamic> toJson() {
    return {
      'firstName': this.firstName,
      'lastName': this.lastName,
      'number': this.number,
      'contactId': this._contactId
    };
  }

  String get getFirstname {
    return this.firstName;
  }

  String get getLastname {
    return this.lastName;
  }

  String get getNumber {
    return this.number;
  }

  String get contactId => _contactId;
}
