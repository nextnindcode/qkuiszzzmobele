import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/helpers.dart';
import '../widget/input_field.dart';
import '../widget/result_card.dart';

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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final s = parseNum(_sisiC.text)!;
    final t = parseNum(_tinggiC.text)!;
    final luasAlas = s * s;
    final volume = luasAlas * t / 3;
    final kelilingAlas = 4 * s;
    final tinggiSisiTegak = sqrt((t * t) + ((s / 2) * (s / 2)));
    final rusukTegak = sqrt((t * t) + ((s * s) / 2));
    final kelilingRusuk = kelilingAlas + (4 * rusukTegak);
    final luasPermukaan = luasAlas + (2 * s * tinggiSisiTegak);

    setState(() {
      _hasil = [
        ResultItem(
          'Luas Alas',
          '${fmt(luasAlas)} cm²',
          formula: 's² = ${fmt(s)}²',
        ),

        ResultItem(
          'Tinggi Sisi Tegak',
          '${fmt(tinggiSisiTegak)} cm',
          formula: '√(t² + (½ × s)²)',
        ),

        ResultItem(
          'Luas Permukaan',
          '${fmt(luasPermukaan)} cm²',
          formula: 's² + (2 × s × tinggi sisi tegak)',
        ),

        ResultItem(
          'Volume',
          '${fmt(volume)} cm³',
          formula: '⅓ × s² × t',
          highlight: true,
        ),

        ResultItem(
          'Keliling Alas',
          '${fmt(kelilingAlas)} cm',
          formula: '4 × s',
        ),

        ResultItem(
          'Panjang Rusuk Tegak',
          '${fmt(rusukTegak)} cm',
          formula: '√(t² + s²/2)',
        ),

        ResultItem(
          'Keliling Seluruh Rusuk',
          '${fmt(kelilingRusuk)} cm',
          formula: '4s + (4 × rusuk tegak)',
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Hitung Piramida'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),

        child: Form(
          key: _formKey,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              const Text(
                'Kalkulator Piramida',
                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Masukkan nilai sisi alas dan tinggi piramida '
                'untuk menghitung luas alas, luas permukaan, '
                'keliling, dan volume piramida.',

                textAlign: TextAlign.center,

                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.black54,
                  height: 1.45,
                ),
              ),

              const SizedBox(height: 20),

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

              const SizedBox(height: 18),

              ElevatedButton.icon(
                onPressed: _hitung,

                icon: const Icon(Icons.calculate_rounded),

                label: const Text('Hitung Piramida'),
              ),

              const SizedBox(height: 20),

              if (_hasil != null)
                ResultCard(
                  title: 'Hasil Perhitungan',
                  items: _hasil!,
                  icon: Icons.change_history_rounded,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
