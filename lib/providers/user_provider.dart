import 'package:flutter/material.dart';
import 'package:grocery_app/models/account.dart';
import 'package:grocery_app/models/customer.dart';

class UserProvider extends ChangeNotifier {
  Account _account = Account(
    email: '',
    password: '',
    token: '',
    customer: Customer(
      name: '',
      gender: '',
      address: '',
      phone: '',
    ),
  );
  Account get account => _account;
  void setUser(String user) {
    _account = Account.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(Account user) {
    _account = user;
    notifyListeners();
  }

  void clear() {
    _account = Account(
      email: '',
      password: '',
      token: '',
      customer: Customer(
        name: '',
        gender: '',
        address: '',
        phone: '',
      ),
    );
  }
}
