import 'dart:convert';
import 'dart:io';

import 'package:coopi_app/pages/auth_page.dart';
import 'package:coopi_app/features/login/services/auth_service.dart';


import 'package:coopi_app/features/widgets/exports_widgets.dart'; 


import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';


import '../../../../database/database_service.dart';
import '../../../scanner/presentation/pages/bluetoothScanner.dart';
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

  var userPrueba = User(
      DateTime.now().toString(),
      id: 0,
      username: 'prueba',
      password: '1234',
      token: '1216164654',
      role: '1',
      createdAt: DateTime.now().toString(),
    );

  void signUserIn(BuildContext context) async {

    // usuario y contraseña para probar: adm7axm:adm7axm

    AuthService authService = Provider.of<AuthService>(context, listen: false);

    await authService.login(usernameController.text, passwordController.text);

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
              //const SizedBox(height: 50,),
              Image.asset('assets/images/Barcode-amico.png',
                height: 280,
              ),
          
              // const Icon(
              //   Icons.lock,
              //   size: 120,
              // ),
              //const SizedBox(height: 15,),
              const Text(
                'INICIO DE SESIÓN',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 23,
                  fontWeight: FontWeight.bold
                ),
              ),
              //const SizedBox(height: 50,),
              CustomTextField(
                controller: usernameController,
                hintText: 'Usuario',
                obscureText: false,
              ),
             // const SizedBox(height: 20,),
              CustomTextField(
                controller: passwordController,
                hintText: 'Contraseña',
                obscureText: true,
              ),
             // const SizedBox(height: 20,),
              // Text(
              //   'Recuperar contraseña',
              //   style: TextStyle(color: Colors.grey[600]),
              // ),
             // const SizedBox(height: 50,),
              CustomButton(onTap: () => 
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarcodeScannerView()),
                  )
                //signUserIn(context),
                //AuthPage()
                ),
          
              CustomTextButton(
                text: 'Recuperar Contraseña',
                textSize: 16,
                )
          
             // const SizedBox(height: 50,),
           //   ElevatedButton(onPressed: () => listUsers(), child: const Text('data')),
             // const SizedBox(height: 50,),
          
             // ElevatedButton(onPressed: () => deleteUsers(), child: const Text('delete users')),
              // Text(users.toString()),
            ],
          ),
        ),
      ),
    );
  }
}