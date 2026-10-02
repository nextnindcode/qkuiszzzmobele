import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class ResultItem {
  final String label;
  final String value;
  final String? formula;
  final bool highlight;

  const ResultItem(
    this.label,
    this.value, {
    this.formula,
    this.highlight = false,
  });
}

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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.putih,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.hijauSage.withValues(alpha: 0.35)),
        boxShadow: [
          BoxShadow(
            color: AppColors.coklatTua.withValues(alpha: 0.12),
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),

          const Divider(height: 20),

          ...items.map(_buildItem),
        ],
      ),
    );
  }

  Widget _buildItem(ResultItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 2),

          if (item.formula != null)
            Text(
              'Rumus: ${item.formula}',
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black54,
                height: 1.35,
              ),
            ),

          const SizedBox(height: 1),

          Text(
            'Hasil: ${item.value}',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
