import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Örnek veriler
    final List<Map<String, dynamic>> dues = [
      {'month': 'Haziran 2026', 'amount': '1.250 TL', 'status': 'Ödenmedi', 'color': Colors.red},
      {'month': 'Mayıs 2026', 'amount': '1.250 TL', 'status': 'Ödendi', 'color': Colors.green},
      {'month': 'Nisan 2026', 'amount': '1.250 TL', 'status': 'Ödendi', 'color': Colors.green},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aidat ve Ödemeler'),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              // Toplam Borç Özeti
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Güncel Borç', style: TextStyle(color: Colors.white70, fontSize: 16)),
                        SizedBox(height: 8),
                        Text('1.250 TL', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Ödeme sayfasına yönlendiriliyor...')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text('Hemen Öde'),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Geçmiş Dönemler', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),
              // Liste
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: dues.length,
                  itemBuilder: (context, index) {
                    final due = dues[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const Icon(Icons.receipt_long, size: 32),
                        title: Text(due['month'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(due['amount']),
                        trailing: Chip(
                          label: Text(due['status'], style: const TextStyle(color: Colors.white)),
                          backgroundColor: due['color'],
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
