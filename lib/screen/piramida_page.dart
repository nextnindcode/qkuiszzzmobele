import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/helpers.dart';
import '../widget/input_field.dart';
import '../widget/result_card.dart';

// Piramida alas persegi: volume & keliling
class PiramidaPage extends StatefulWidget {
  const PiramidaPage({super.key});

  @override
  State<PiramidaPage> createState() => _PiramidaPageState();
}

class _PiramidaPageState extends State<PiramidaPage> {
  final _formKey = GlobalKey<FormState>();
  final _sisiC = TextEditingController();
  final _tinggiC = TextEditingController();
  List<ResultItem>? _hasil;

  @override
  void dispose() {
    _sisiC.dispose();
    _tinggiC.dispose();
    super.dispose();
  }

  void _hitung() {
    if (!_formKey.currentState!.validate()) return;

    final s = parseNum(_sisiC.text)!; // sisi alas
    final t = parseNum(_tinggiC.text)!; // tinggi piramida

    final luasAlas = s * s;
    final volume = luasAlas * t / 3;
    final kelilingAlas = 4 * s;
    final tinggiSisiTegak = sqrt(t * t + (s / 2) * (s / 2)); // apotema
    final rusukTegak = sqrt(t * t + (s * s) / 2);
    final kelilingRusuk = kelilingAlas + 4 * rusukTegak;
    final luasPermukaan = luasAlas + 2 * s * tinggiSisiTegak;

    setState(() {
      _hasil = [
        ResultItem('Volume', fmt(volume), highlight: true),
        ResultItem('Keliling alas', fmt(kelilingAlas), highlight: true),
        ResultItem('Keliling seluruh rusuk', fmt(kelilingRusuk)),
        ResultItem('Luas alas', fmt(luasAlas)),
        ResultItem('Tinggi sisi tegak', fmt(tinggiSisiTegak)),
        ResultItem('Panjang rusuk tegak', fmt(rusukTegak)),
        ResultItem('Luas permukaan', fmt(luasPermukaan)),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Piramida')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Piramida dengan alas persegi. Masukkan sisi alas dan tinggi piramida.',
              ),
              const SizedBox(height: 16),
              NumberField(
                controller: _sisiC,
                label: 'Sisi alas (s)',
                icon: Icons.crop_square_rounded,
              ),
              const SizedBox(height: 14),
              NumberField(
                controller: _tinggiC,
                label: 'Tinggi piramida (t)',
                icon: Icons.height_rounded,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _hitung, child: const Text('Hitung')),
              const SizedBox(height: 20),
              if (_hasil != null)
                ResultCard(
                  title: 'Hasil Perhitungan',
                  items: _hasil!,
                  icon: Icons.change_history_rounded,
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
