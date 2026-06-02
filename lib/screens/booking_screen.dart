import 'package:flutter/material.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> areas = [
      {'title': 'Kapalı Spor Salonu', 'icon': Icons.fitness_center},
      {'title': 'Toplantı Odası (B Blok)', 'icon': Icons.meeting_room},
      {'title': 'Barbekü Alanı', 'icon': Icons.outdoor_grill},
      {'title': 'Tenis Kortu', 'icon': Icons.sports_tennis},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ortak Alan Rezervasyonu'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: areas.length,
        itemBuilder: (context, index) {
          final area = areas[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Icon(area['icon'], size: 36, color: Theme.of(context).primaryColor),
              title: Text(area['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              trailing: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${area['title']} için randevu ekranı açılıyor...')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text('Randevu Al'),
              ),
            ),
          );
        },
      ),
    );
  }
}
