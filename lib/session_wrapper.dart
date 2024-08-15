import 'package:coopi_app/features/app/presentation/pages/home_page.dart';
//import 'package:coopi_app/pages/login_page.dart';
import 'package:coopi_app/features/login/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/login/presentation/pages/login_page.dart';
import 'features/scanner/presentation/pages/bluetooth_scanner.dart';

class SessionWrapper extends StatelessWidget {
  const SessionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    print(authService.isLogged);
    return authService.isLogged ? BarcodeScannerView() : const Login();
  }
}