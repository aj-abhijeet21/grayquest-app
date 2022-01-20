import 'package:flutter/cupertino.dart';

class UserProvider extends ChangeNotifier {
  int userId = 1;

  void setUser(int user) {
    userId = user;
    notifyListeners();
  }

  int getUserId() {
    return userId;
  }
}
