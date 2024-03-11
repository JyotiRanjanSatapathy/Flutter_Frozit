import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:frozit/views/account/model/account_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../../common/api.dart';

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

  void _setUser(UserAccount user) {
    _user = user;
    notifyListeners();
  }

  void _removeUser() {
    _user = null;
    notifyListeners();
  }

  static Future<String> get _localPath async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final path = localDirectory.path;
    return path;
  }

  String? phone;
  String? verificationId;
  int? resendToken;

  Future<bool> verifyOTP(String smsCode) async {
    if (verificationId == null) {
      log('Verification ID is null');
      return false;
    }
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    String? firebaseToken = await userCredential.user?.getIdToken();
    log('Firebase Token: $firebaseToken');
    if (firebaseToken != null) {
      Api.getUser(firebaseToken: firebaseToken).then((user) {
        if (user != null) {
          log('User: $user');
          saveUserDetails(user);
          log('User saved');
        }
      });
    }

    return true;
  }

  Future<void> saveAddress({
    required String name,
    required String address,
    required String city,
    required String state,
    required String pincode,
  }) async {
    final user = _user;
    if (user != null) {
      user.address = Address(
        name: name,
        area: address,
        city: city,
        state: state,
        pincode: pincode,
      );

      _user = user;
      saveUserDetails(user);
      notifyListeners();
    }
  }

  Future<void> loadUserDetails() async {
    String path = await _localPath;
    final localFile = File('$path/user.json');
    if (localFile.existsSync()) {
      final user =
          UserAccount.fromJson(jsonDecode(localFile.readAsStringSync()));
      _setUser(user);
    }
    // Fetch user details from local storage
  }

  Future<void> saveUserDetails(UserAccount user) async {
    String path = await _localPath;
    final localFile = File('$path/user.json');
    localFile.writeAsStringSync(jsonEncode(user.toJson()));
    _setUser(user);
  }

  Future<void> logout() async {
    String path = await _localPath;
    final localFile = File('$path/user.json');
    localFile.deleteSync();
    _removeUser();
  }

  // Add more methods to manage the user account
}
