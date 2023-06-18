// ignore_for_file: non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter_chat_types/src/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import '../Screen/chat/my_room_object.dart';
import 'Constants/constants.dart';
import 'Constants/enums.dart';

class StorageController {
  static StorageController? _instance;

  List<types.User> listUsers = [];

  List<types.Room> listRooms = [];

  var myRoomObject = MyRoomObject();

  factory StorageController() => _instance ??= StorageController._();

  StorageController._();

  final _id = ReadWriteValue(Constants.langKey, '');
  final _lang = ReadWriteValue(Constants.langKey, '');
  final _token = ReadWriteValue(Constants.tokenKey, '');
  final _remember_token = ReadWriteValue(Constants.rememberTokenKey, '');
  final _user = ReadWriteValue(Constants.userKey, '');
  final _theme = ReadWriteValue(Constants.themeKey, ThemeColor.light.name);
  final _notification = ReadWriteValue(Constants.notificationKey, 'false');
  final _videoPaths = ReadWriteValue(Constants.paths, '');
  final _fcm = ReadWriteValue(Constants.fcm, '');
  final _userType = ReadWriteValue(Constants.userType, '');
  final _methodTakeAuthentication =
      ReadWriteValue(Constants.methodTakeAuthentication, '');

  String get token => _token.val;

  String get loginOrSignUpWithAnyMethod => _methodTakeAuthentication.val;

  String get id => _id.val;

  String get rememberToken => _remember_token.val;

  String get user => _user.val;

  String get theme => _theme.val;

  String get notification => _notification.val;

  String get videoPaths => _videoPaths.val;

  String get fcm => _fcm.val;

  String get langName => _lang.val;

  String get langCode => langArabic ? 'ar' : 'en';

  bool get hasLang => _lang.val.isNotEmpty;

  bool get langArabic => _lang.val == 'Arabic';

  bool get langEnglish => _lang.val == 'English';

  String get userType => _userType.val;

  firebase.User? firebaseUser;

  set rememberToken(String val) => _remember_token.val = val;

  set methodTakeAuthentication(String val) => _methodTakeAuthentication.val = val;

  set token(String val) => _token.val = val;

  set id(String id) => _id.val = id;

  set user(data) => _user.val = data;

  set theme(val) => _theme.val = val;

  set notification(val) => _notification.val = val;

  set videoPaths(val) => _videoPaths.val = val;

  set fcm(val) => _fcm.val = val;

  set userType(val) => _userType.val = val;

  set lang(String value) => _lang.val = value;
}
