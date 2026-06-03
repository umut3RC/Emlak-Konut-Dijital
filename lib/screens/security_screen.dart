import 'package:flutter/material.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  final TextEditingController _guestDescController = TextEditingController();
  DateTime? _selectedDate;
  bool _isQrGenerated = false;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Misafir ve Güvenlik'),
      ),
      body: Center(
        child: ConstrainedBox(
          // Ekran tasarımlarının esnek kalmasını sağlamak için ConstrainedBox ile sarıyoruz
          constraints: const BoxConstraints(maxWidth: 600), 
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Sitenize gelecek misafirleriniz için önceden QR Kod oluşturarak güvenlik geçişlerini hızlandırabilirsiniz.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  if (!_isQrGenerated) ...[
                    // --- ADIM 1: KAYIT FORMU ---
                    TextField(
                      controller: _guestDescController,
                      decoration: const InputDecoration(
                        labelText: 'Misafir Tanımı',
                        hintText: 'Örn: Ahmet ve ailesi',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.group_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Tarih Seçici (Date Picker)
                    InkWell(
                      onTap: _presentDatePicker,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Ziyaret Tarihi',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                        ),
                        child: Text(
                          _selectedDate == null 
                              ? 'Tarih Seçiniz' 
                              : '${_selectedDate!.day.toString().padLeft(2, '0')}.${_selectedDate!.month.toString().padLeft(2, '0')}.${_selectedDate!.year}',
                          style: TextStyle(
                            fontSize: 16,
                            color: _selectedDate == null ? Colors.grey.shade600 : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    ElevatedButton(
                      onPressed: () {
                        if (_guestDescController.text.isNotEmpty && _selectedDate != null) {
                          setState(() {
                            _isQrGenerated = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Lütfen misafir tanımı ve tarih giriniz.')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Kayıt Oluştur', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ] else ...[
                    // --- ADIM 2: QR KOD OLUŞTURULDU EKRANI ---
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                              size: 64,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Talebiniz Alındı',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Temsili QR Kod (Karanlık temada bile içi beyaz kalsın diye kapsayıcı eklendi)
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: const Icon(
                                Icons.qr_code_2,
                                size: 180,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 24),
                            // Dinamik Açıklama Metni
                            Text(
                              'A1 Blok, Kat: 5, Daire: 15 misafiri\n${_selectedDate!.day.toString().padLeft(2, '0')}.${_selectedDate!.month.toString().padLeft(2, '0')}.${_selectedDate!.year} tarihli ${_guestDescController.text}.',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // QR Paylaş Butonu
                    ElevatedButton.icon(
                      onPressed: () {
                        // QR Paylaşım simülasyonu
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('QR Kod paylaşım ekranı açılıyor...')),
                        );
                      },
                      icon: const Icon(Icons.share_outlined),
                      label: const Text('QR Paylaş', style: TextStyle(fontSize: 16)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isQrGenerated = false;
                          _guestDescController.clear();
                          _selectedDate = null;
                        });
                      },
                      child: const Text('Yeni Misafir Kaydı Oluştur', style: TextStyle(fontSize: 16)),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
