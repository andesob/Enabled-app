import 'package:enabled_app/global_data/custom_icons_icons.dart';
import 'package:enabled_app/global_data/strings.dart';
import 'package:enabled_app/needs/needs_object.dart';
import 'package:flutter/material.dart';

/// A class representing the pre-set needs data.
class NeedsData {
  //Food and drink needs page object
  static const NeedsObject HUNGRY_OBJECT =
      const NeedsObject(Strings.HUNGRY, CustomIcons.food);
  static const NeedsObject THIRSTY_OBJECT =
      const NeedsObject(Strings.THIRSTY, Icons.local_drink);
  static const NeedsObject SNACKS_OBJECT =
      const NeedsObject(Strings.SNACKS, CustomIcons.cookie_bite);
  static const NeedsObject CANDY_OBJECT =
      const NeedsObject(Strings.CANDY, CustomIcons.candy_cane);

  //Hygiene needs page object
  static const NeedsObject TOILET_OBJECT =
      const NeedsObject(Strings.TOILET, CustomIcons.toilet);
  static const NeedsObject SHOWER_OBJECT =
      const NeedsObject(Strings.SHOWER, CustomIcons.shower);
  static const NeedsObject BATH_OBJECT =
      const NeedsObject(Strings.BATH, Icons.hot_tub);
  static const NeedsObject MEDICATION_OBJECT =
      const NeedsObject(Strings.MEDICATION, CustomIcons.briefcase_medical);

  //Emotions needs page object
  static const NeedsObject HAPPY_OBJECT =
      const NeedsObject(Strings.HAPPY, CustomIcons.smile_1);
  static const NeedsObject SAD_OBJECT =
      const NeedsObject(Strings.SAD, CustomIcons.frown);
  static const NeedsObject ANGRY_OBJECT =
      const NeedsObject(Strings.ANGRY, CustomIcons.angry);
  static const NeedsObject TIRED_OBJECT =
      const NeedsObject(Strings.TIRED, CustomIcons.tired);
  static const NeedsObject SURPRISED_OBJECT =
      const NeedsObject(Strings.SURPRISED, CustomIcons.surprise);

  //Room needs page object
  static const NeedsObject OUTSIDE_OBJECT =
      const NeedsObject(Strings.OUTSIDE, CustomIcons.tree);
  static const NeedsObject LIVING_ROOM_OBJECT =
      const NeedsObject(Strings.LIVING_ROOM, CustomIcons.tv);
  static const NeedsObject KITCHEN_OBJECT =
      const NeedsObject(Strings.KITCHEN, CustomIcons.kitchen);
  static const NeedsObject BEDROOM_OBJECT =
      const NeedsObject(Strings.BEDROOM, CustomIcons.bed);
  static const NeedsObject BASEMENT_OBJECT =
      const NeedsObject(Strings.BASEMENT, CustomIcons.door_open);

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
