import 'package:flutter/material.dart';

import '../data/profile_data.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';
import 'login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final yakin = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Yakin ingin keluar dari aplikasi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
    if (yakin == true && context.mounted) {
      Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _header(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    onPressed: () => _logout(context),
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Logout'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(
                        color: AppColors.error,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24, bottom: 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.coklatTua, AppColors.orangeGelap],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Column(
        children: [
          _foto(),
          const SizedBox(height: 14),
          Text(
            ProfileData.nama,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.krem,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'NIM ${ProfileData.nim}',
            style: TextStyle(color: AppColors.krem.withValues(alpha: 0.85)),
          ),
        ],
      ),
    );
  }

  Widget _foto() {
    return Container(
      width: 130,
      height: 130,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.krem,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          ProfileData.fotoAsset,
          width: 122,
          height: 122,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) => Container(
            color: AppColors.putih,
            child: const Icon(
              Icons.person_rounded,
              size: 72,
              color: AppColors.hijauSage,
            ),
          ),
        ),
      ),
    );
  }

  Widget _info(IconData icon, String label, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: _kartu(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.krem,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.hijauTua),
          ),
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
      width: double.infinity,
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
