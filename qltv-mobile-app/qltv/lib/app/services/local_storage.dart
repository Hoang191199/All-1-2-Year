import 'dart:convert';

import 'package:get/get.dart';
import 'package:qltv/domain/entities/reader_data.dart';
import 'package:qltv/domain/entities/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  user,
  reader,
  accessToken,
  username,
  password,
  notification,
  locale
}

class LocalStorageService extends GetxService {
  SharedPreferences? _sharedPreferences;
  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  UserData? get userFromStorage {
    final rawJson = _sharedPreferences?.getString(_Key.user.toString());
    if (rawJson == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(rawJson);
    return UserData.fromJson(map);
  }

  set userToStorage(UserData? value) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.user.toString(), json.encode(value.toJson()));
    } else {
      _sharedPreferences?.remove(_Key.user.toString());
    }
  }

  ReaderData? get readerFromStorage {
    final rawJson = _sharedPreferences?.getString(_Key.reader.toString());
    if (rawJson == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(rawJson);
    return ReaderData.fromJson(map);
  }

  set readerToStorage(ReaderData? value) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.reader.toString(), json.encode(value.toJson()));
    }
    // else {
    //   _sharedPreferences?.remove(_Key.reader.toString());
    // }
  }

  String get accessTokenFromStorage {
    final rawJson = _sharedPreferences?.getString(_Key.accessToken.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set accessTokenToStorage(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.accessToken.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.accessToken.toString());
    }
  }

  String get usernameFromStorage {
    final rawJson = _sharedPreferences?.getString(_Key.username.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set usernameToStorage(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.username.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.username.toString());
    }
  }

  String get passwordFromStorage {
    final rawJson = _sharedPreferences?.getString(_Key.password.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set passwordToStorage(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.password.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.password.toString());
    }
  }

  bool get checkNotification {
    final value = _sharedPreferences?.getBool(_Key.notification.toString());
    if (value == null) {
      return false;
    }
    return value;
  }

  set setNotification(bool value) {
    if (value) {
      _sharedPreferences?.setBool(_Key.notification.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.notification.toString());
    }
  }

  List<String> get checkLocale {
    final value = _sharedPreferences?.getStringList(_Key.locale.toString());
    if (value == null) {
      return [];
    }
    return value;
  }

  set setLocale(List<String> value) {
    if (value.isNotEmpty) {
      _sharedPreferences?.setStringList(_Key.locale.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.locale.toString());
    }
  }
}
