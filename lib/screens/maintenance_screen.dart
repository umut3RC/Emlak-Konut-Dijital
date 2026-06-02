import 'package:flutter/material.dart';

class MaintenanceScreen extends StatelessWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek veriler
    final List<Map<String, dynamic>> tasks = [
      {'title': 'A Blok Asansör Arızası', 'status': 'Bekliyor', 'color': Colors.orange},
      {'title': 'Peyzaj Sulama Sistemi', 'status': 'İşlemde', 'color': Colors.blue},
      {'title': 'Otopark Aydınlatma', 'status': 'Çözüldü', 'color': Colors.green},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakım ve Onarım'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 1,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: task['color'].withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.build_outlined, color: task['color']),
              ),
              title: Text(task['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text('Durum: ${task['status']}', style: TextStyle(color: task['color'], fontWeight: FontWeight.w600)),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${task['title']} detayı açılıyor...')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
