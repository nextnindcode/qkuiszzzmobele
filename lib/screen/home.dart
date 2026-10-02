import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import '../widget/menu_card.dart';
import 'cek_hari.dart';
import 'konversi_waktu.dart';
import 'piramida.dart';
import 'segitiga.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _buka(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final namaDepan = ProfileData.nama.split(' ').first;

    return Scaffold(
      appBar: AppBar(title: const Text('Kuis Mobile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.hijauTua, AppColors.hijauSage],
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: AppColors.hijauTua.withValues(alpha: 0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo, $namaDepan!',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.krem,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Bangun Datar & Utilitas\nPilih salah satu menu di bawah.',
                        style: TextStyle(color: AppColors.krem, height: 1.4),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.calculate_rounded,
                  size: 56,
                  color: AppColors.krem,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            'Menu Utama',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.coklatTua,
            ),
          ),
          const SizedBox(height: 12),
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
