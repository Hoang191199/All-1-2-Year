import 'dart:convert';

import 'package:get/get.dart';
import 'package:mooc_app/domain/entities/user_sso.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum _Key {
  user,
  token,
  notiToken,
  // favList
}

class LocalStorageService extends GetxService {
  SharedPreferences? _sharedPreferences;
  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    // _sharedPreferences?.setStringList(_Key.favList.toString(),<String>[]);
    return this;
  }

  UserSSO? get userFromStorage {
    final rawJson = _sharedPreferences?.getString(_Key.user.toString());
    if (rawJson == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(rawJson);
    return UserSSO.fromJson(map);
  }

  set userToStorage(UserSSO? value) {
    if (value != null) {
      _sharedPreferences?.setString(_Key.user.toString(), json.encode(value.toJson()));
    } else {
      _sharedPreferences?.remove(_Key.user.toString());
    }
  }

  String get tokenFromStorage {
    final rawJson = _sharedPreferences?.getString(_Key.token.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set tokenToStorage(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.token.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.token.toString());
    }
  }

  String get notiTokenFromStorage {
    final rawJson = _sharedPreferences?.getString(_Key.notiToken.toString());
    if (rawJson == null) {
      return '';
    }
    return rawJson;
  }

  set notiTokenToStorage(String? value) {
    if (value!.isNotEmpty) {
      _sharedPreferences?.setString(_Key.notiToken.toString(), value);
    } else {
      _sharedPreferences?.remove(_Key.notiToken.toString());
    }
  }

  // set favListToStore(String value) {
  //   final List<String>? fav = _sharedPreferences?.getStringList(_Key.favList.toString());
  //   if (fav != null && value != null && value != "") {
  //     if(fav.contains(value) != true) {
  //       fav.add(value);
  //     }
  //     else{
  //       fav.remove(value);
  //     }
  //     // fav.add(value);
  //     _sharedPreferences?.setStringList(_Key.favList.toString(),fav);
  //   }
  // }
  //
  // List<String> get favListFromStorage {
  //   final List<String>? fav = _sharedPreferences?.getStringList(_Key.favList.toString());
  //   if (fav == null) {
  //     return [];
  //   }
  //   return fav;
  // }
}
