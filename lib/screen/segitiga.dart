import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/helpers.dart';
import '../widget/input_field.dart';
import '../widget/result_card.dart';

enum JenisSegitiga { samaKaki, samaSisi, sikuSiku }

class SegitigaPage extends StatefulWidget {
  const SegitigaPage({super.key});

  @override
  State<SegitigaPage> createState() => _SegitigaPageState();
}

class _SegitigaPageState extends State<SegitigaPage> {
  final _formKey = GlobalKey<FormState>();
  final _c1 = TextEditingController();
  final _c2 = TextEditingController();
  JenisSegitiga _jenis = JenisSegitiga.samaKaki;
  List<ResultItem>? _hasil;

  @override
  void dispose() {
    _c1.dispose();
    _c2.dispose();
    super.dispose();
  }

  String get _namaJenis {
    switch (_jenis) {
      case JenisSegitiga.samaKaki:
        return 'Segitiga Sama Kaki';
      case JenisSegitiga.samaSisi:
        return 'Segitiga Sama Sisi';
      case JenisSegitiga.sikuSiku:
        return 'Segitiga Siku-siku';
    }
  }

  void _gantiJenis(JenisSegitiga j) {
    setState(() {
      _jenis = j;
      _hasil = [
        ResultItem(
          'Tinggi Segitiga',
          '– cm',
          formula: '√(sisi² - (½ × alas)²)',
        ),

        ResultItem(
          'Luas Segitiga',
          '– cm²',
          formula: '½ × alas × tinggi',
          highlight: true,
        ),

        ResultItem('Keliling Segitiga', '– cm', formula: 'alas + sisi + sisi'),
      ];
      _c1.clear();
      _c2.clear();
    });
    _formKey.currentState?.reset();
  }

  void _hitung() {
    if (!_formKey.currentState!.validate()) return;

    final a = parseNum(_c1.text)!;
    late double luas;
    late double keliling;
    final extra = <ResultItem>[];

    switch (_jenis) {
      case JenisSegitiga.samaSisi:
        luas = sqrt(3) / 4 * a * a;
        keliling = 3 * a;
        extra.add(ResultItem('Tinggi', fmt(sqrt(3) / 2 * a)));
        break;
      case JenisSegitiga.samaKaki:
        final b = parseNum(_c2.text)!; // sisi kaki
        final tinggi = sqrt(b * b - a * a / 4);
        luas = 0.5 * a * tinggi;
        keliling = a + 2 * b;
        extra.add(ResultItem('Tinggi', fmt(tinggi)));
        break;
      case JenisSegitiga.sikuSiku:
        final t = parseNum(_c2.text)!;
        final miring = sqrt(a * a + t * t);
        luas = 0.5 * a * t;
        keliling = a + t + miring;
        extra.add(ResultItem('Sisi miring', fmt(miring)));
        break;
    }

    setState(() {
      _hasil = [
        ResultItem('Luas', fmt(luas), highlight: true),
        ResultItem('Keliling', fmt(keliling), highlight: true),
        ...extra,
      ];
    });
  }

  List<Widget> _fields() {
    switch (_jenis) {
      case JenisSegitiga.samaSisi:
        return [
          NumberField(
            controller: _c1,
            label: 'Panjang sisi (a)',
            icon: Icons.straighten_rounded,
          ),
        ];
      case JenisSegitiga.samaKaki:
        return [
          NumberField(
            controller: _c1,
            label: 'Alas (a)',
            icon: Icons.straighten_rounded,
          ),
          const SizedBox(height: 14),
          NumberField(
            controller: _c2,
            label: 'Sisi kaki (b)',
            icon: Icons.call_made_rounded,
            validator: (v) {
              final dasar = validasiPositif(v);
              if (dasar != null) return dasar;
              final a = parseNum(_c1.text);
              final b = parseNum(v)!;
              if (a != null && 2 * b <= a) {
                return 'Sisi kaki harus lebih dari setengah alas';
              }
              return null;
            },
          ),
        ];
      case JenisSegitiga.sikuSiku:
        return [
          NumberField(
            controller: _c1,
            label: 'Alas (a)',
            icon: Icons.straighten_rounded,
          ),
          const SizedBox(height: 14),
          NumberField(
            controller: _c2,
            label: 'Tinggi (t)',
            icon: Icons.height_rounded,
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Segitiga')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Kalkulator Segitiga',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Masukkan nilai alas dan sisi miring segitiga '
                'untuk menghitung tinggi, luas, dan keliling segitiga.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.black54,
                  height: 1.45,
                ),
              ),
              const Text('Pilih jenis segitiga:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _chip('Sama Kaki', JenisSegitiga.samaKaki),
                  _chip('Sama Sisi', JenisSegitiga.samaSisi),
                  _chip('Siku-siku', JenisSegitiga.sikuSiku),
                ],
              ),
              const SizedBox(height: 16),
              ..._fields(),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _hitung, child: const Text('Hitung')),
              const SizedBox(height: 20),
              if (_hasil != null)
                ResultCard(
                  title: _namaJenis,
                  items: _hasil!,
                  icon: Icons.signal_cellular_4_bar_rounded,
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, JenisSegitiga j) {
    final aktif = _jenis == j;
    return ChoiceChip(
      label: Text(label),
      selected: aktif,
      selectedColor: AppColors.hijauTua,
      labelStyle: TextStyle(
        color: aktif ? AppColors.krem : AppColors.coklatTua,
        fontWeight: FontWeight.bold,
      ),
      checkmarkColor: AppColors.krem,
      onSelected: (_) => _gantiJenis(j),
    );
  }
}
