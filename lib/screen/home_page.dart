import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widget/menu_card.dart';
import 'cek_hari_page.dart';
import 'konversi_waktu_page.dart';
import 'piramida_page.dart';
import 'segitiga_page.dart';

// Home: 4 menu utama
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _buka(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kuis Mobile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Bangun Datar & Utilitas',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.coklatTua,
            ),
          ),
          const SizedBox(height: 4),
          const Text('Pilih salah satu menu di bawah ini.'),
          const SizedBox(height: 20),
          MenuCard(
            icon: Icons.change_history_rounded,
            title: 'Piramida',
            subtitle: 'Hitung volume dan keliling piramida',
            onTap: () => _buka(context, const PiramidaPage()),
          ),
          MenuCard(
            icon: Icons.signal_cellular_4_bar_rounded,
            title: 'Segitiga',
            subtitle: 'Luas & keliling sama kaki, sama sisi, siku-siku',
            onTap: () => _buka(context, const SegitigaPage()),
          ),
          MenuCard(
            icon: Icons.public_rounded,
            title: 'Konversi Waktu',
            subtitle: 'WIB, WITA, WIT, Malaysia, dan Kanada',
            onTap: () => _buka(context, const KonversiWaktuPage()),
          ),
          MenuCard(
            icon: Icons.calendar_month_rounded,
            title: 'Cek Hari',
            subtitle: 'Nomor 1-7 menjadi nama hari (Senin-Minggu)',
            onTap: () => _buka(context, const CekHariPage()),
          ),
        ],
      ),
    );
  }
}
