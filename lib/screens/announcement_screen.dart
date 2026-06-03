import 'package:flutter/material.dart';

class AnnouncementScreen extends StatefulWidget {
  final String role;
  const AnnouncementScreen({super.key, required this.role});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  // Örnek duyurular listesi (Artık state içinde olduğu için yeni veri eklenebilecek)
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

  // Personel için Duyuru Oluşturma Modalı
  void _showAddAnnouncementModal() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    bool isImportant = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(ctx).viewInsets.bottom, // Klavye açıldığında yukarı kayması için
                left: 24,
                right: 24,
                top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text('Yeni Duyuru Oluştur', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Duyuru Başlığı', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descController,
                    maxLines: 4,
                    decoration: const InputDecoration(labelText: 'Duyuru Detayı', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Önemli Duyuru (Kırmızı Etiket)'),
                    activeColor: Colors.red,
                    value: isImportant,
                    onChanged: (val) {
                      setModalState(() {
                        isImportant = val;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
                        setState(() {
                          // Yeni duyuruyu listenin en başına ekle
                          announcements.insert(0, {
                            'title': titleController.text,
                            'date': 'Şimdi',
                            'desc': descController.text,
                            'isImportant': isImportant,
                          });
                        });
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Duyuru başarıyla yayınlandı.')));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lütfen tüm alanları doldurun.')));
                      }
                    },
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                    child: const Text('Yayınla', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.role == 'Staff' ? 'Personel Duyuruları' : 'Duyuru ve İletişim'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // Personel ise en üstte sabit buton gösterilir
              if (widget.role == 'Staff')
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showAddAnnouncementModal,
                      icon: const Icon(Icons.add_alert),
                      label: const Text('Yeni Duyuru Oluştur', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blueGrey,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ),
              
              // Duyurular Listesi (Scroll edilebilir alan)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    left: 16, 
                    right: 16, 
                    bottom: 16, 
                    top: widget.role == 'Staff' ? 0 : 16, // Buton varsa üst boşluğu al, yoksa ekle
                  ),
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
                                color: ann['isImportant'] ? Colors.red : null,
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
      ],
    ),
  ),
),
);
  }
}
