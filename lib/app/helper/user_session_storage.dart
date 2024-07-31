import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:posting_sample_app/app/model/user_session.dart';

class UserSessionStorage {
  void setUserSession(UserSession userSession) {
    final resultOfUserSession = jsonEncode(userSession.toJson());
    localStorage.setItem('user_session', resultOfUserSession);
  }

  UserSession? get getUserSession {
    try {
      final resultFromStorage = localStorage.getItem('user_session');
      return UserSession.fromJson(jsonDecode(resultFromStorage ?? ''));
    } catch (e) {
      return null;
    }
  }
}
