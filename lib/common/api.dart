import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

import '../views/account/model/account_model.dart';

class Api {
  static const authority = "frozit-api.onrender.com";

  static const loginPath = "/auth/login";
  static const registerPath = "/auth/register";
  static const getUserPath = "/auth/get-user";

  // TODO: Get categories from API
  // Select -> catageory id (), Item group id, itemvariety id

  // Get

  static Future<String> get _localPath async {
    final localDirectory = await getApplicationDocumentsDirectory();
    final path = localDirectory.path;
    return path;
  }

  static String? _token;

  static Future<String?> getToken() async {
    if (_token != null) {
      return _token;
    }
    String path = await _localPath;
    final localFile = File('$path/token.txt');
    if (localFile.existsSync()) {
      _token = localFile.readAsStringSync();
      return _token;
    }
    return null;
  }

  static Future<void> setToken(String token) async {
    _token = token;
    String path = await _localPath;
    final localFile = File('$path/token.txt');
    localFile.writeAsStringSync(token);
  }

  static Future<UserAccount?> getUser({
    String? token,
    String? firebaseToken,
  }) async {
    String? header = token ?? "Bearer $firebaseToken";
    final response = await get(
      Uri.https(authority, getUserPath),
      headers: {
        "Authorization": header,
      },
    );

    log("getUser Response: ${response.body}");

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      List<dynamic> jwt = body['data']['jwt'];
      List<String> jwtString = jwt.cast<String>();
      String token = jwtString[(firebaseToken == null) ? 0 : 1];
      setToken(token);
      // log(body);
      return UserAccount(
        email: body['data']['userData']['email'],
        phone: body['data']['userData']['phoneNumber'],
        uid: body['data']['userData']['uid'],
      );
    } else {
      return null;
    }
  }

  static Future<UserAccount?> loginEmail({
    String? email,
    String? password,
    String? firebaseToken,
  }) async {
    if (firebaseToken != null) {
      return await getUser(firebaseToken: firebaseToken);
    }
    if (email == null || password == null) {
      return null;
    }

    final response = await post(
      Uri.https(authority, loginPath),
      body: {
        "email": email,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // Fetch user details from API
      return await getUser(token: body['data']['jwt']);
    } else {
      return null;
    }
  }

  static Future<UserAccount?> register(
    String email,
    String phone,
    String password,
  ) async {
    final response = await post(
      Uri.https(authority, registerPath),
      body: {
        "phoneNumber": phone,
        "email": email,
        "password": password,
      },
    );

    log(response.body);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      setToken(body['data']['jwt']);
      return UserAccount(
        email: email,
        phone: phone,
        uid: body['data']['userUid'],
      );
    } else {
      return null;
    }
  }
}
