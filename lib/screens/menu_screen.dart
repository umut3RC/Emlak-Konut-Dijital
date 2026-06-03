import 'package:flutter/material.dart';
import '../main.dart';
import 'login_screen.dart';
import 'request_screen.dart';
import 'maintenance_screen.dart';
import 'booking_screen.dart';
import 'payment_screen.dart';
import 'announcement_screen.dart';
import 'security_screen.dart';
import 'survey_screen.dart';

class MenuScreen extends StatelessWidget {
  final String role; // 'Resident' veya 'Staff' olarak rolü tutar

  const MenuScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menuItems = [];

    if (role == 'Resident') {
      menuItems = [
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
        {
          'title': 'Aidat ve Ödemeler',
          'icon': Icons.payment_outlined,
          'page': const PaymentScreen(),
        },
        {
          'title': 'Duyuru ve İletişim',
          'icon': Icons.campaign_outlined,
          'page': const AnnouncementScreen(role: 'Resident'),
        },
        {
          'title': 'Misafir ve Güvenlik',
          'icon': Icons.security_outlined,
          'page': const SecurityScreen(),
        },
        {
          'title': 'Memnuniyet Anketi',
          'icon': Icons.star_border_outlined,
          'page': const SurveyScreen(),
        },
      ];
    } else {
      // Staff (Personel) Menüsü
      menuItems = [
        {
          'title': 'Arıza ve Bildirimler',
          'icon': Icons.build_outlined,
          'page': const MaintenanceScreen(),
        },
        {
          'title': 'Yeni Arıza Kaydı Oluştur',
          'icon': Icons.assignment_add,
          'page': const RequestScreen(),
        },
        {
          'title': 'QR Kod Okuyucu',
          'icon': Icons.qr_code_scanner,
          'page': const SecurityScreen(),
        },
        {
          'title': 'Personel Duyuruları',
          'icon': Icons.campaign_outlined,
          'page': const AnnouncementScreen(role: 'Staff'),
        },
        {
          'title': 'Vardiya Çizelgesi',
          'icon': Icons.calendar_month_outlined,
          'page': null, // Şimdilik boş
        },
      ];
    }

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
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Web ve Tablet uyumluluğu için genişliğe göre kolon sayısını belirliyoruz
          int crossAxisCount = 2; // Mobil için varsayılan
          if (constraints.maxWidth > 1200) {
            crossAxisCount = 5; // Masaüstü
          } else if (constraints.maxWidth > 800) {
            crossAxisCount = 4; // Tablet yatay
          } else if (constraints.maxWidth > 600) {
            crossAxisCount = 3; // Tablet dikey
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                ),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    // Hardcoded white colors removed so it adapts to dark mode automatically
                    child: InkWell(
                      onTap: () {
                        if (item['page'] != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => item['page'] as Widget,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${item['title']} yapım aşamasında...',
                              ),
                            ),
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
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
