import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'screens/login_screen.dart';

void main() async {
  // Widget ağacının hazır olduğundan emin olmak (asenkron işlemler için zorunludur)
  WidgetsFlutterBinding.ensureInitialized();
  
  // Kaydedilmiş son tema tercihini hafızadan (SharedPreferences) çekiyoruz
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  
  runApp(EmlakKonutApp(savedThemeMode: savedThemeMode));
}

class EmlakKonutApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const EmlakKonutApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5), brightness: Brightness.light),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        useMaterial3: true,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // Koyu arka plan
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5), brightness: Brightness.dark),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E), // Koyu appbar
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        cardColor: const Color(0xFF1E1E1E), // Kartlar için koyu renk
        useMaterial3: true,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'Emlak Konut Dijital',
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        builder: (context, child) {
          // Global Tema Değişim Butonu (Her ekranın üstünde kalır)
          return Stack(
            children: [
              if (child != null) child,
              Positioned(
                bottom: 24.0,
                right: 24.0,
                child: SafeArea(
                  child: Material(
                    color: Colors.transparent,
                    child: Builder(
                      builder: (innerContext) {
                        final isDark = AdaptiveTheme.of(innerContext).mode.isDark;
                        return FloatingActionButton(
                          heroTag: 'global_theme_toggle',
                          onPressed: () {
                            if (isDark) {
                              AdaptiveTheme.of(innerContext).setLight();
                            } else {
                              AdaptiveTheme.of(innerContext).setDark();
                            }
                          },
                          child: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
                        );
                      }
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        home: const LoginScreen(),
      ),
    );
  }
}
