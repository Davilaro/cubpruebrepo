import 'dart:convert';

import 'package:coopi_app/database/database_service.dart';
import 'package:coopi_app/services/http_service.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  bool isLogged = false;

  Future<void> login(String email, String password) async {

    String credentials = '${email}:${password}';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = 'Basic ${stringToBase64.encode(credentials)}';

    String route = 'webapi_qa/api/Auth/token';

    var params = {'data': encoded};

    HttpService http = HttpService(params: params, route: route);

    final response = await http.postMethod();

    print(response.statusCode);

    List responseJson = [{
      'message': 'peticion rechazada',
    }];

    if (response.statusCode == 200) {
      responseJson = jsonDecode(response.body) as List<dynamic>;
      isLogged = true;
      notifyListeners();
    }
    

    print(responseJson);

    // DatabaseService dbService = DatabaseService(userData: userPrueba);

    // await dbService.insertUser();

  }

  Future<void> logout() async {
    isLogged = false;
  }
}