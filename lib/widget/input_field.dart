import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/zona_waktu.dart';
import '../theme/app_theme.dart';
import '../utils/helpers.dart';

class NumberField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? Function(String?)? validator;

  const NumberField({
    super.key,
    required this.controller,
    required this.label,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.hijauTua),
      ),
      validator: validator ?? validasiPositif,
    );
  }
}

class ZonaDropdown extends StatelessWidget {
  final String label;
  final Zona value;
  final List<Zona> items;
  final ValueChanged<Zona> onChanged;

  const ZonaDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Zona>(
          value: value,
          isExpanded: true,
          items: items
              .map((z) => DropdownMenuItem<Zona>(value: z, child: Text(z.nama)))
              .toList(),
          onChanged: (z) {
            if (z != null) onChanged(z);
          },
        ),
      ),
    );
  }
}

class PickerTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final VoidCallback onTap;

  const PickerTile({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: AppColors.hijauTua),
        ),
        child: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
