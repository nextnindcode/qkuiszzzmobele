import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(child: _foto()),
          const SizedBox(height: 16),
          Center(
            child: Text(
              ProfileData.nama,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.coklatTua,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _info(Icons.badge_rounded, 'Nama', ProfileData.nama),
          _info(Icons.numbers_rounded, 'NIM', ProfileData.nim),
          _info(
            Icons.location_on_rounded,
            'Tempat Lahir',
            ProfileData.tempatLahir,
          ),
          _info(
            Icons.cake_rounded,
            'Tanggal Lahir',
            tanggalIndo(ProfileData.tanggalLahir),
          ),
          _hobi(),
        ],
      ),
    );
  }

  Widget _foto() {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.orangeTerang, width: 3),
        color: AppColors.putih,
      ),
      child: ClipOval(
        child: Image.asset(
          ProfileData.fotoAsset,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => const Icon(
            Icons.person_rounded,
            size: 80,
            color: AppColors.hijauSage,
          ),
        ),
      ),
    );
  }

  Widget _info(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: _kartu(),
      child: Row(
        children: [
          Icon(icon, color: AppColors.hijauTua),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.coklatTua,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hobi() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _kartu(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.favorite_rounded, color: AppColors.hijauTua),
              SizedBox(width: 14),
              Text(
                'Hobi',
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: ProfileData.hobi
                .map(
                  (h) => Chip(
                    label: Text(h),
                    backgroundColor: AppColors.krem,
                    side: const BorderSide(color: AppColors.orangeTerang),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  BoxDecoration _kartu() {
    return BoxDecoration(
      color: AppColors.putih,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: AppColors.coklatTua.withValues(alpha: 0.12),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
