import 'dart:convert';

import 'package:coopi_app/database/database_service.dart';
import 'package:coopi_app/features/login/data/models/user.dart';
import 'package:coopi_app/features/login/services/http_service.dart';
import 'package:flutter/material.dart';

class AuthService with ChangeNotifier {
  bool isLogged = false;

  Future<List<dynamic>> login(String email, String password) async {

    String credentials = '$email:$password';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = 'Basic ${stringToBase64.encode(credentials)}';

    String route = 'webapi_qa/api/Auth/token';

    var params = {'data': encoded};

    HttpService http = HttpService(params: params, route: route);

    final response = await http.postMethod();

    print(response.statusCode);

    List responseJson = [{
      'message': 'Usuario y/o contraseña incorrectos.',
      'status': 400
    }];

    if (response.statusCode == 200) {
      responseJson = jsonDecode(response.body) as List<dynamic>;

      var userPrueba = User(
        DateTime.now().toString(),
        id: responseJson[0]['IdUsuario'],
        username: email,
        password: password,
        token: responseJson[0]['token'],
        role: responseJson[0]['IdRol'].toString(),
        createdAt: DateTime.now().toString(),
      );

      DatabaseService dbService = DatabaseService(userData: userPrueba);
      await dbService.insertUser();

      isLogged = true;
      notifyListeners();
    }

    return responseJson;
  }

  Future<void> logout() async {
    isLogged = false;
    notifyListeners();
  }
}