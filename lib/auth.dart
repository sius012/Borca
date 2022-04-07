import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  signUp(String email, String pass) async {
    Uri url = Uri.parse(
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithCustomToken?key=[API_KEY]");

    var response = await http.post(url,
        body: json.encode(
            {"email": email, "password": pass, "returnSecureToken": true}));

    print(json.decode(response.body));
  }
}
