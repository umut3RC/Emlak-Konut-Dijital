import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'request_screen.dart';
import 'maintenance_screen.dart';
import 'booking_screen.dart';

class MenuScreen extends StatelessWidget {
  final String role; // 'Resident' veya 'Staff' olarak rolü tutar

  const MenuScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    // Vaka çalışmasındaki başlıklara göre menü listesi
    // Yönlendirmeler için routeBuilder eklendi
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Talep / Arıza Bildir', 
        'icon': Icons.report_problem_outlined,
        'page': const RequestScreen(),
      },
      {
        'title': 'Bakım-Onarım', 
        'icon': Icons.build_outlined,
        'page': const MaintenanceScreen(),
      },
      {
        'title': 'Ortak Alan Kullanımı', 
        'icon': Icons.event_available_outlined,
        'page': const BookingScreen(),
      },
      {'title': 'Aidat ve Ödemeler', 'icon': Icons.payment_outlined, 'page': null},
      {'title': 'Duyuru ve İletişim', 'icon': Icons.campaign_outlined, 'page': null},
      {'title': 'Misafir ve Güvenlik', 'icon': Icons.security_outlined, 'page': null},
      {'title': 'Memnuniyet Anketi', 'icon': Icons.star_border_outlined, 'page': null},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(role == 'Resident' ? 'Ana Menü' : 'Personel Paneli'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            tooltip: 'Çıkış Yap',
          )
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Ekranda yan yana 2 kutu
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1, // Kutuların kareye yakın olması için
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            color: Colors.white,
            surfaceTintColor: Colors.white,
            child: InkWell(
              onTap: () {
                if (item['page'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => item['page'] as Widget),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${item['title']} yapım aşamasında...')),
                  );
                }
              },
              borderRadius: BorderRadius.circular(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item['icon'], 
                    size: 48, 
                    color: Theme.of(context).primaryColor
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      item['title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
