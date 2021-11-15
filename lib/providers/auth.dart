import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  String? _email;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token!;
    }
    return '';
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyCmLh0iROU2VK_mIQpn6PB2Kf8eZHu4Ms4';
    final response = await http.post(
      Uri.parse(url),
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _email = responseData['email'];
    // _expiryDate = DateTime.parse(responseData['expiresIn']);

    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(
          responseData['expiresIn'],
        ),
      ),
    );
    print("hello : $_email");
    if (urlSegment == 'signUp') {
      _token = null;
      _expiryDate = null;
      _userId = null;
    }
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

  Future<void> Register(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }
}
