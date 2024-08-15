import 'package:coopi_app/features/login/services/auth_service.dart';
import 'package:coopi_app/routes/appRoutes.dart';
import 'package:coopi_app/session_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/providers_app.dart';
//import 'pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    return  ProvidersApp(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       // home: const SessionWrapper(),
        initialRoute: 'sessionwrapper',
        routes: appRoutes,
      ),
    );
  }
}
