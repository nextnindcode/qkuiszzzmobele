import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ResultItem {
  final String label;
  final String value;
  final bool highlight;
  const ResultItem(this.label, this.value, {this.highlight = false});
}

// Kartu hasil perhitungan (label di kiri, nilai di kanan)
class ResultCard extends StatelessWidget {
  final String title;
  final List<ResultItem> items;
  final IconData icon;

  const ResultCard({
    super.key,
    required this.title,
    required this.items,
    this.icon = Icons.calculate_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.putih,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.hijauSage.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColors.coklatTua.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.hijauTua),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.coklatTua,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 22),
          ...items.map(_row),
        ],
      ),
    );
  }

  Widget _row(ResultItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: item.highlight ? AppColors.krem : null,
        borderRadius: BorderRadius.circular(12),
        border:
            item.highlight ? Border.all(color: AppColors.orangeTerang) : null,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.label,
              style: const TextStyle(color: Colors.black87, fontSize: 14),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              item.value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: item.highlight ? 17 : 15,
                color:
                    item.highlight ? AppColors.orangeGelap : AppColors.coklatTua,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Kotak rumus (hijau) di bawah form
class FormulaBox extends StatelessWidget {
  final List<String> lines;
  const FormulaBox({super.key, required this.lines});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.hijauTua,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rumus yang dipakai',
            style: TextStyle(color: AppColors.krem, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          ...lines.map(
            (l) => Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                l,
                style: const TextStyle(
                  color: AppColors.krem,
                  fontSize: 12.5,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
