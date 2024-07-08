import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import '../components/custom_textField.dart';
import '../components/custom_button.dart';

import '../models/user.dart';
import '../database/database_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  List<User>? users;

  var userPrueba = User(
      DateTime.now().toString(),
      id: 0,
      username: 'prueba',
      password: '1234',
      token: '1216164654',
      createdAt: DateTime.now().toString(),
    );

  void signUserIn() async {

    String credentials = '${usernameController.text}:${passwordController.text}';
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(credentials);

    var url = Uri.http(
      'ec2-54-82-137-7.compute-1.amazonaws.com',
      'webapi_qa/api/Auth/token'
    );

    final response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Basic $encoded',
      },
    );

    print(response.statusCode);

    List responseJson = [{
      'message': 'peticion rechazada',
    }];

    if (response.statusCode == 200) {
      responseJson = jsonDecode(response.body) as List<dynamic>;
    }

    print(responseJson);

    DatabaseService dbService = DatabaseService(userData: userPrueba);

    await dbService.insertUser();

    print(usernameController.text);
    print(passwordController.text);
  }

  void listUsers() async {
    print('funcion listar usuarios');
    
    DatabaseService dbService = DatabaseService(userData: userPrueba);

    var userResults = await dbService.getUsers();

    // setState(() {
    //   users = userResults;
    // });

    print(userResults);

  }

  void deleteUsers() async {

    DatabaseService dbService = DatabaseService(userData: userPrueba);

    await dbService.deleteAllUsers();

    print('usuarios eliminados');
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50,),
              const Icon(
                Icons.lock,
                size: 120,
              ),
              const SizedBox(height: 50,),
              const Text(
                'Bienvenido de nuevo',
                style: TextStyle(
                  color: Color.fromRGBO(97, 97, 97, 1),
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 50,),
              CustomTextField(
                controller: usernameController,
                hintText: 'Usuario',
                obscureText: false,
              ),
              const SizedBox(height: 20,),
              CustomTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
              ),
              const SizedBox(height: 20,),
              Text(
                'Recuperar contraseña',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 50,),
              CustomButton(onTap: signUserIn,),

              const SizedBox(height: 50,),
              ElevatedButton(onPressed: () => listUsers(), child: const Text('data')),
              const SizedBox(height: 50,),

              ElevatedButton(onPressed: () => deleteUsers(), child: const Text('delete users')),
              // Text(users.toString()),
            ],
          ),
        ),
      ),
    );
  }
}