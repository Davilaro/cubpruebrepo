//final import 'package:flutter/material.dart';

import 'package:coopi_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';

import '../features/app/presentation/pages/home_page.dart';

Map<String, Widget Function(BuildContext context)> appRoutes= {
  'primeraPage': (_)=> const Login(),
  'segundaPage': (_)=> const PrincipalPage(),
};