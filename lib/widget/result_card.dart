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
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.putih,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.garis),
        boxShadow: [
          BoxShadow(
            color: AppColors.coklatTua.withValues(alpha: 0.10),
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
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.hijauMuda,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: AppColors.hijauTua,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.coklatTua,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 20, color: AppColors.garis),
          ...items.map(_buildItem),
        ],
      ),
    );
  }

  Widget _buildItem(ResultItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: item.highlight
                  ? AppColors.terracotta
                  : AppColors.hijauSage,
              width: 2.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: AppColors.teks,
              ),
            ),
            if (item.formula != null) ...[
              const SizedBox(height: 2),
              Text(
                'Rumus: ' + item.formula!,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.teksSekunder,
                  height: 1.35,
                ),
              ),
            ],
            const SizedBox(height: 1),
            Text(
              'Hasil: ' + item.value,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: item.highlight
                    ? AppColors.terracotta
                    : AppColors.hijauTua,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
            'Rumus yang digunakan',
            style: TextStyle(
              color: AppColors.krem,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          ...lines.map(
            (line) => Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                line,
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
