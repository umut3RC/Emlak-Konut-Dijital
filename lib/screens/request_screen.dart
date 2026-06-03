import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  String? _selectedCategory;
  bool _isUrgent = false;
  final TextEditingController _descriptionController = TextEditingController();
  bool _hasImage = false; // Görsel eklendiğini simüle etmek için

  final List<String> _categories = [
    'Elektrik',
    'Su ve Tesisat',
    'Ortak Alan Temizliği',
    'Güvenlik',
    'Diğer'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Talep / Arıza Bildir'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600), // Formun webde çok uzamaması için
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                Text(
                  'Lütfen probleminizi veya talebinizi aşağıdan detaylandırın.',
                  style: TextStyle(
                    fontSize: 16, 
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 24),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Kategori Seçiniz',
                    border: OutlineInputBorder(),
                  ),
                  value: _selectedCategory,
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Talebinizi / Arızayı Detaylıca Açıklayın',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 16),

                // Görsel Ekleme Alanı
                if (!_hasImage)
                  OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _hasImage = true; // Fotoğraf eklendi simülasyonu
                      });
                    },
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Görsel / Fotoğraf Ekle'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  )
                else
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image_outlined, size: 48, color: Colors.grey),
                            SizedBox(height: 8),
                            Text('ariza_fotografi.jpg', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.cancel, color: Colors.red, size: 28),
                            onPressed: () {
                              setState(() {
                                _hasImage = false; // Fotoğrafı iptal et
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 24),
                // Çok Acil Toggle Kutusu
                Container(
                  decoration: BoxDecoration(
                    color: _isUrgent ? Colors.red.withOpacity(0.1) : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _isUrgent ? Colors.red.shade400 : Colors.grey.shade300,
                    ),
                  ),
                  child: SwitchListTile(
                    title: const Text(
                      'Çok Acil',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text('Örn: Daire su basması, asansörde mahsur kalma'),
                    activeColor: Colors.red,
                    value: _isUrgent,
                    onChanged: (bool value) {
                      setState(() {
                        _isUrgent = value;
                      });
                    },
                  ),
                ),
                if (_isUrgent)
                  const Padding(
                    padding: EdgeInsets.only(top: 12.0, left: 4, right: 4),
                    child: Text(
                      '⚠️ Lütfen asılsız ihbar yapmayınız. Gerçek dışı acil çağrılar teknik ekibin diğer işleyişlerini aksatmaktadır.',
                      style: TextStyle(color: Colors.red, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Form validation & API call
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Talebiniz başarıyla yönetime iletildi.')),
                    );
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Talebi Gönder', style: TextStyle(fontSize: 16)),
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
