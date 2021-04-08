import 'package:enabled_app/global_data/custom_icons_icons.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/needs/needs_object.dart';
import 'package:flutter/material.dart';

class NeedsData {
  //Food and drink needs page object
  static const NeedsObject HUNGRY_OBJECT =
      const NeedsObject(Strings.HUNGRY, Icon(CustomIcons.food));
  static const NeedsObject THIRSTY_OBJECT =
      const NeedsObject(Strings.THIRSTY, Icon(Icons.local_drink));
  static const NeedsObject SNACKS_OBJECT =
      const NeedsObject(Strings.SNACKS, Icon(CustomIcons.cookie_bite));
  static const NeedsObject CANDY_OBJECT =
      const NeedsObject(Strings.CANDY, Icon(CustomIcons.candy_cane));

  //Hygiene needs page object
  static const NeedsObject TOILET_OBJECT =
      const NeedsObject(Strings.TOILET, Icon(CustomIcons.toilet));
  static const NeedsObject SHOWER_OBJECT =
      const NeedsObject(Strings.SHOWER, Icon(CustomIcons.shower));
  static const NeedsObject BATH_OBJECT =
      const NeedsObject(Strings.BATH, Icon(Icons.hot_tub));
  static const NeedsObject MEDICATION_OBJECT =
      const NeedsObject(Strings.MEDICATION, Icon(CustomIcons.briefcase_medical));

  //Emotions needs page object
  static const NeedsObject HAPPY_OBJECT =
      const NeedsObject(Strings.HAPPY, Icon(CustomIcons.smile_1));
  static const NeedsObject SAD_OBJECT =
      const NeedsObject(Strings.SAD, Icon(CustomIcons.frown));
  static const NeedsObject ANGRY_OBJECT =
      const NeedsObject(Strings.ANGRY, Icon(CustomIcons.angry));
  static const NeedsObject TIRED_OBJECT =
      const NeedsObject(Strings.TIRED, Icon(CustomIcons.tired));
  static const NeedsObject SURPRISED_OBJECT =
      const NeedsObject(Strings.SURPRISED, Icon(CustomIcons.surprise));

  //Room needs page object
  static const NeedsObject OUTSIDE_OBJECT =
      const NeedsObject(Strings.OUTSIDE, Icon(CustomIcons.tree));
  static const NeedsObject LIVING_ROOM_OBJECT =
      const NeedsObject(Strings.LIVING_ROOM, Icon(CustomIcons.tv));
  static const NeedsObject KITCHEN_OBJECT =
      const NeedsObject(Strings.KITCHEN, Icon(CustomIcons.kitchen));
  static const NeedsObject BEDROOM_OBJECT =
      const NeedsObject(Strings.BEDROOM, Icon(CustomIcons.bed));
  static const NeedsObject BASEMENT_OBJECT =
      const NeedsObject(Strings.BASEMENT, Icon(CustomIcons.door_open));

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
