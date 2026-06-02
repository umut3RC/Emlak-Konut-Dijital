import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const EmlakKonutApp());
}

class EmlakKonutApp extends StatelessWidget {
  const EmlakKonutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emlak Konut Dijital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
        ), // Emlak Konut mavisine yakın bir ton
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
