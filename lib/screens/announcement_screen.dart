import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek duyurular
    final List<Map<String, dynamic>> announcements = [
      {
        'title': 'Su Kesintisi Uyarısı', 
        'date': '02 Haziran 2026', 
        'desc': 'Ana şebeke çalışması nedeniyle yarın 10:00 - 14:00 arası sular kesilecektir.',
        'isImportant': true
      },
      {
        'title': 'Havuz Sezonu Açıldı', 
        'date': '01 Haziran 2026', 
        'desc': 'Açık havuzumuz bugünden itibaren sakinlerimizin kullanımına açılmıştır.',
        'isImportant': false
      },
      {
        'title': 'Genel Kurul Toplantısı', 
        'date': '25 Mayıs 2026', 
        'desc': 'Yıllık olağan genel kurul toplantısı B Blok toplantı salonunda yapılacaktır.',
        'isImportant': false
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Duyuru ve İletişim'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              final ann = announcements[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              ann['title'], 
                              style: TextStyle(
                                fontSize: 18, 
                                fontWeight: FontWeight.bold,
                                color: ann['isImportant'] ? Colors.red : Colors.black87,
                              ),
                            ),
                          ),
                          Text(ann['date'], style: const TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      const Divider(height: 24),
                      Text(ann['desc'], style: const TextStyle(fontSize: 15, height: 1.4)),
                      const SizedBox(height: 12),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.check, size: 16),
                          label: const Text('Okudum'),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
