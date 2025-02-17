import 'dart:convert';
import 'dart:io';

import 'package:coopi_app/pages/auth_page.dart';
import 'package:coopi_app/features/login/services/auth_service.dart';


import 'package:coopi_app/features/widgets/exports_widgets.dart';


import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


import '../../../../database/database_service.dart';
import '../../../scanner/presentation/pages/bluetooth_scanner.dart';
import '../../data/models/user.dart';
//import '../features/login/data/models/user.dart';
//import '../database/database_service.dart';
//import '../services/http_service.dart';

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

  List<dynamic>? errorMessage;

  void signUserIn(BuildContext context) async {
    // usuario y contraseña para probar: pruebasmov:123456

    AuthService authService = Provider.of<AuthService>(context, listen: false);

    var response = await authService.login(
        usernameController.text, passwordController.text);

    setState(() {
      errorMessage = response;
    });

    print(response);
  }

  void listUsers() async {
    print('funcion listar usuarios');

    DatabaseService dbService = DatabaseService();

    var userResults = await dbService.getUsers();

    // setState(() {
    //   users = userResults;
    // });

    print(userResults);
  }

  void deleteUsers() async {
    DatabaseService dbService = DatabaseService();

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(224, 224, 224, 1),
        body: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/Barcode-amico.png',
                height: 280,
              ),
              const Text(
                'INICIO DE SESIÓN',
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              CustomTextField(
                controller: usernameController,
                hintText: 'Usuario',
                obscureText: false,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
              ),
             
              // CustomButton(onTap: () => 
              // Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => BarcodeScannerView()),
              //     )
              //   //signUserIn(context),
              //   //AuthPage()
              //   ),
          
            errorMessage != null
                  ? Text(
                      errorMessage![0]['message'],
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    )
                  : const Text(''),
                    
                  // const Text(''),
              CustomButton(
                onTap: () => signUserIn(context),
              ),

              CustomTextButton(
                text: 'Recuperar Contraseña',
                textSize: 16,
              ),
          
              // ElevatedButton(onPressed: () => listUsers(), child: const Text('data')),
          
              // ElevatedButton(onPressed: () => deleteUsers(), child: const Text('delete users')),
            ],
          ),
        ),
      ),
    );
  }
}
