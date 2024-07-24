import 'package:coopi_app/pages/home_page.dart';
import 'package:coopi_app/pages/login_page.dart';
import 'package:coopi_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionWrapper extends StatelessWidget {
  const SessionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    print(authService.isLogged);
    return authService.isLogged ? PrincipalPage() : Login();
  }
}