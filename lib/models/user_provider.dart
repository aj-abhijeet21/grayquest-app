import 'package:flutter/cupertino.dart';
import 'package:grayquest_app/models/models.dart';

class UserProvider extends ChangeNotifier {
  int userId = 1;

  void setUser(UserDetails user) {
    userId = user.userId;
    notifyListeners();
  }
}
