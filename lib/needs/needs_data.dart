import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/needs/needs_object.dart';
import 'package:flutter/material.dart';

class NeedsData {
  //Food and drink needs page object
  static const NeedsObject HUNGRY_OBJECT =
      const NeedsObject(Strings.HUNGRY, Icon(Icons.accessibility));
  static const NeedsObject THIRSTY_OBJECT =
      const NeedsObject(Strings.THIRSTY, Icon(Icons.accessibility));
  static const NeedsObject SNACKS_OBJECT =
      const NeedsObject(Strings.SNACKS, Icon(Icons.accessibility));
  static const NeedsObject CANDY_OBJECT =
      const NeedsObject(Strings.CANDY, Icon(Icons.accessibility));

  //Hygiene needs page object
  static const NeedsObject TOILET_OBJECT =
      const NeedsObject(Strings.TOILET, Icon(Icons.accessibility));
  static const NeedsObject SHOWER_OBJECT =
      const NeedsObject(Strings.SHOWER, Icon(Icons.accessibility));
  static const NeedsObject BATH_OBJECT =
      const NeedsObject(Strings.BATH, Icon(Icons.accessibility));
  static const NeedsObject MEDICATION_OBJECT =
      const NeedsObject(Strings.MEDICATION, Icon(Icons.accessibility));

  //Emotions needs page object
  static const NeedsObject HAPPY_OBJECT =
      const NeedsObject(Strings.HAPPY, Icon(Icons.accessibility));
  static const NeedsObject SAD_OBJECT =
      const NeedsObject(Strings.SAD, Icon(Icons.accessibility));
  static const NeedsObject ANGRY_OBJECT =
      const NeedsObject(Strings.ANGRY, Icon(Icons.accessibility));
  static const NeedsObject TIRED_OBJECT =
      const NeedsObject(Strings.TIRED, Icon(Icons.accessibility));
  static const NeedsObject SCARED_OBJECT =
      const NeedsObject(Strings.SCARED, Icon(Icons.accessibility));
  static const NeedsObject SURPRISED_OBJECT =
      const NeedsObject(Strings.SURPRISED, Icon(Icons.accessibility));

  //Room needs page object
  static const NeedsObject OUTSIDE_OBJECT =
      const NeedsObject(Strings.OUTSIDE, Icon(Icons.accessibility));
  static const NeedsObject LIVING_ROOM_OBJECT =
      const NeedsObject(Strings.LIVING_ROOM, Icon(Icons.accessibility));
  static const NeedsObject KITCHEN_OBJECT =
      const NeedsObject(Strings.KITCHEN, Icon(Icons.accessibility));
  static const NeedsObject BEDROOM_OBJECT =
      const NeedsObject(Strings.BEDROOM, Icon(Icons.accessibility));
  static const NeedsObject BASEMENT_OBJECT =
      const NeedsObject(Strings.BASEMENT, Icon(Icons.accessibility));

  //List for food and drink objects
  static const List<NeedsObject> FOOD_DRINK_OBJECTS = [
    HUNGRY_OBJECT,
    THIRSTY_OBJECT,
    SNACKS_OBJECT,
    CANDY_OBJECT,
  ];

  //List for hygiene objects
  static const List<NeedsObject> HYGIENE_OBJECTS = [
    TOILET_OBJECT,
    SHOWER_OBJECT,
    BATH_OBJECT,
    MEDICATION_OBJECT,
  ];

  //List for emotion objects
  static const List<NeedsObject> EMOTION_OBJECTS = [
    HAPPY_OBJECT,
    SAD_OBJECT,
    ANGRY_OBJECT,
    TIRED_OBJECT,
    SCARED_OBJECT,
    SURPRISED_OBJECT,
  ];

  //List for room objects
  static const List<NeedsObject> ROOM_OBJECTS = [
    OUTSIDE_OBJECT,
    LIVING_ROOM_OBJECT,
    KITCHEN_OBJECT,
    BEDROOM_OBJECT,
    BASEMENT_OBJECT,
  ];
}
