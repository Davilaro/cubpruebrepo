import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../features/login/services/auth_service.dart';

class ProvidersApp extends StatelessWidget {
  const ProvidersApp({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: child,
    );
  }
}
