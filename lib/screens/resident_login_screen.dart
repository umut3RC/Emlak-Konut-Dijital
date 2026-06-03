import 'package:flutter/material.dart';
import 'menu_screen.dart';

class ResidentLoginScreen extends StatefulWidget {
  const ResidentLoginScreen({super.key});

  @override
  State<ResidentLoginScreen> createState() => _ResidentLoginScreenState();
}

class _ResidentLoginScreenState extends State<ResidentLoginScreen> {
  bool _isSmsSent = false;
  final TextEditingController _tcknController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Konut Sahibi Girişi'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  Icons.shield_outlined, 
                  size: 80, 
                  color: Theme.of(context).brightness == Brightness.dark 
                      ? Colors.blue.shade300 
                      : Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Sisteme giriş yapmak için T.C. Kimlik Numaranızı giriniz.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                
                // TCKN Giriş Alanı
                TextField(
                  controller: _tcknController,
                  keyboardType: TextInputType.number,
                  maxLength: 11,
                  enabled: !_isSmsSent, // SMS atıldıysa değiştirilemesin
                  decoration: const InputDecoration(
                    labelText: 'TC Kimlik Numarası',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                
                // İlk Aşama: SMS Gönder Butonu
                if (!_isSmsSent)
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isSmsSent = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Doğrulama Kodu Gönder', style: TextStyle(fontSize: 16)),
                  ),

                // İkinci Aşama: SMS Kodu ve Doğrulama
                if (_isSmsSent) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '05** *** *1 23 numaralı telefonunuza SMS doğrulama kodu gönderildi.',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _smsController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      labelText: '6 Haneli Doğrulama Kodu',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      // Kod boş olsa bile vaka simülasyonu gereği direkt yönlendir
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MenuScreen(role: 'Resident')),
                        (route) => false, // Tüm geçmişi siler (Login sayfalarına geri dönülmesin)
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.green, // Doğrulama için güven veren yeşil renk
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Doğrula ve Giriş Yap', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isSmsSent = false;
                      });
                    },
                    child: const Text('T.C. Kimlik Numaramı Değiştir'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
