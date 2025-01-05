import 'package:flutter/foundation.dart';
import 'package:moviewer/boxes/box.dart';
import 'package:moviewer/boxes/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void loadAdminUser() {
    _user = userBox.get('adminUser');
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
}
