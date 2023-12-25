import 'dart:convert';

import 'package:get/get.dart';
import 'package:mobiedu_kids/domain/entities/children_data.dart';
// import 'package:mobiedu_kids/domain/entities/log_info.dart';
import 'package:mobiedu_kids/domain/entities/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  user,
  children,
  accessToken,
  email,
  password,
  groupname,
  grouptitle,
  groupId,
  pagename,
  schoolname,
  map,
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

  String get emailFromStorage {
    final rawJson = _sharedPreferences?.getString(_Key.email.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set emailToStorage(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.email.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.email.toString());
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

  String get getGroupname {
    final rawJson = _sharedPreferences?.getString(_Key.groupname.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set setGroupname(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.groupname.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.groupname.toString());
    }
  }

  String get getGrouptitle {
    final rawJson = _sharedPreferences?.getString(_Key.grouptitle.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set setGrouptitle(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.grouptitle.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.grouptitle.toString());
    }
  }

  String get getGroupId {
    final rawJson = _sharedPreferences?.getString(_Key.groupId.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set setGroupId(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.groupId.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.groupId.toString());
    }
  }

  String get getPagename {
    final rawJson = _sharedPreferences?.getString(_Key.pagename.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set setPagename(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.pagename.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.pagename.toString());
    }
  }

  String get getSchoolname {
    final rawJson = _sharedPreferences?.getString(_Key.schoolname.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set setSchoolname(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.schoolname.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.schoolname.toString());
    }
  }

  // ChildrenData get getChild {
  //   final rawJson = _sharedPreferences?.getString(_Key.children.toString());
  //   if (rawJson == null) {
  //     return null;
  //   }
  //   return rawJson;
  // }

  // set setChild(String? value) {
  //   if (value!.isNotEmpty) {
  //     _sharedPreferences?.setString(_Key.children.toString(), value);
  //   } else {
  //     _sharedPreferences?.remove(_Key.children.toString());
  //   }
  // }
  ChildrenData? get getChild {
    final rawJson = _sharedPreferences?.getString(_Key.children.toString());
    if (rawJson == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(rawJson);
    return ChildrenData.fromJson(map);
  }

  set setChild(ChildrenData? value) {
    if (value != null) {
      _sharedPreferences?.setString(
          _Key.children.toString(), json.encode(value.toJson()));
    } else {
      _sharedPreferences?.remove(_Key.children.toString());
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

  String get getAcc {
    final rawJson = _sharedPreferences?.getString(_Key.map.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set setAcc(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.map.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.map.toString());
    }
  }
}
