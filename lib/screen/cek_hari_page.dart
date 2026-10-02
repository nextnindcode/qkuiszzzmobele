import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import '../utils/helpers.dart';
import '../widget/result_card.dart';

// Cek hari: nomor 1-7 -> Senin sampai Minggu
class CekHariPage extends StatefulWidget {
  const CekHariPage({super.key});

  @override
  State<CekHariPage> createState() => _CekHariPageState();
}

class _CekHariPageState extends State<CekHariPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  int? _nomor;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validasi(String? v) {
    if (v == null || v.trim().isEmpty) return 'Wajib diisi';
    final n = int.tryParse(v.trim());
    if (n == null) return 'Isi dengan angka bulat';
    if (n < 1 || n > 7) return 'Masukkan angka 1 sampai 7';
    return null;
  }

  void _cek() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _nomor = int.parse(_controller.text.trim()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cek Hari')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Masukkan nomor 1 sampai 7 (1 = Senin ... 7 = Minggu).'),
              const SizedBox(height: 16),
              TextFormField(
                controller: _controller,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Nomor hari',
                  prefixIcon:
                      Icon(Icons.tag_rounded, color: AppColors.hijauTua),
                ),
                validator: _validasi,
                onFieldSubmitted: (_) => _cek(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: _cek, child: const Text('Cek Hari')),
              const SizedBox(height: 20),
              if (_nomor != null) ...[
                _hasilBesar(_nomor!),
                const SizedBox(height: 14),
              ],
              ResultCard(
                title: 'Daftar nomor hari',
                icon: Icons.list_alt_rounded,
                items: [
                  for (var i = 0; i < namaHari.length; i++)
                    ResultItem('${i + 1}', namaHari[i],
                        highlight: _nomor == i + 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hasilBesar(int nomor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.hijauTua,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text('Nomor $nomor',
              style: const TextStyle(color: AppColors.krem, fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            namaHari[nomor - 1],
            style: const TextStyle(
              color: AppColors.krem,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
