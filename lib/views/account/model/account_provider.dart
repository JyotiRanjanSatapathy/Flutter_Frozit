import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:frozit/views/account/model/account_model.dart';
import 'package:path_provider/path_provider.dart';

enum LoginStatus { loggedIn, loggedOut }

class AccountProvider with ChangeNotifier {
  UserAccount? _user;
  UserAccount? get user => _user;

  bool get isLoggedIn => _user != null;

  LoginStatus get loginStatus {
    if (_user == null) {
      return LoginStatus.loggedOut;
    } else {
      return LoginStatus.loggedIn;
    }
  }

  void setUser(UserAccount user) {
    _user = user;
    notifyListeners();
  }

  void removeUser() {
    _user = null;
    notifyListeners();
  }

  static Future<String> get _localPath async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final path = localDirectory.path;
    return path;
  }

  Future<void> signupUser({
    required String name,
    required String email,
    required String phone,
  }) async {
    // Save user details to local storage
    final user = UserAccount(
      name: name,
      email: email,
      phone: phone,
    );
    saveUserDetails(user);
    notifyListeners();
  }

  Future<void> saveAddress({
    required String address,
    required String city,
    required String state,
    required String pincode,
  }) async {
    final user = _user;
    if (user != null) {
      user.location = Location(
        address: address,
        city: city,
        state: state,
        pincode: pincode,
      );

      _user = user;
      saveUserDetails(user);
      notifyListeners();
    }
  }

  Future<void> loginUserByPhone(String phone) async {
    // Fetch user details from API
    final user = UserAccount(
      name: 'John Doe',
      email: 'xyz@mail.com',
      phone: phone,
      location: Location(
        address: '123, Main Street',
        city: 'New York',
        state: 'New York',
        pincode: '10001',
      ),
    );
    saveUserDetails(user);
    notifyListeners();
  }

  Future<void> loadUserDetails() async {
    String path = await _localPath;
    final localFile = File('$path/user.json');
    if (localFile.existsSync()) {
      final user =
          UserAccount.fromJson(jsonDecode(localFile.readAsStringSync()));
      setUser(user);
    }
    // Fetch user details from local storage
  }

  Future<void> saveUserDetails(UserAccount user) async {
    String path = await _localPath;
    final localFile = File('$path/user.json');
    localFile.writeAsStringSync(jsonEncode(user.toJson()));
    setUser(user);
  }

  Future<void> logout() async {
    String path = await _localPath;
    final localFile = File('$path/user.json');
    localFile.deleteSync();
    removeUser();
  }

  // Add more methods to manage the user account
}
