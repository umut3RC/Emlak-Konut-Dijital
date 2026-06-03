import 'package:flutter/material.dart';
import 'menu_screen.dart';
import 'resident_login_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500), // Web için maksimum genişlik
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Üst Kısım: Logo ve Başlık
                  Column(
                    children: [
                      const SizedBox(height: 60),
                      Icon(
                        Icons.maps_home_work_outlined,
                        size: 80,
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.blue.shade300 
                            : Theme.of(context).primaryColor,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Emlak Konut Dijital',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Yaşam Deneyimi Platformu',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),

                  // Orta Kısım: Konut Sahibi Butonu
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ResidentLoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Konut Sahibi Girişi',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Alt Kısım: Personel Girişi Butonu
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MenuScreen(role: 'Staff')),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Personel Girişi',
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
