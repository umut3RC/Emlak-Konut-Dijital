import 'package:flutter/material.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  final List<Map<String, dynamic>> tasks = [
    {
      'id': 'TSK-1045',
      'title': 'Daire Su Basması (Patlak Boru)',
      'location': 'A1 Blok - Daire 15',
      'status': 'Bekliyor',
      'date': 'Şimdi',
      'isUrgent': true,
    },
    {
      'id': 'TSK-1042',
      'title': 'B Blok Asansör Arızası',
      'location': 'B Blok - Zemin Kat',
      'status': 'İşlemde',
      'date': '12 Eki 2023, 14:30',
      'isUrgent': false,
    },
    {
      'id': 'TSK-1038',
      'title': 'Ortak Alan Aydınlatma',
      'location': 'Otopark - Kat 1',
      'status': 'Çözüldü',
      'date': '11 Eki 2023, 09:15',
      'isUrgent': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bakım ve Onarım'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              final isUrgent = task['isUrgent'] == true;

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: isUrgent ? const BorderSide(color: Colors.red, width: 2) : BorderSide.none,
                ),
                color: isUrgent ? Colors.red.withOpacity(0.05) : null,
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Row(
                    children: [
                      if (isUrgent) ...[
                        const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
                        const SizedBox(width: 4),
                        const Text('ÇOK ACİL', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(width: 8),
                      ],
                      Text(task['id'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(task['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 4),
                      Text('${task['location']} • ${task['date']}'),
                    ],
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
        ),
      ),
    );
  }
}
