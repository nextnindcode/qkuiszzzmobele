import 'package:flutter/material.dart';

import '../data/zona_waktu.dart';
import '../utils/helpers.dart';
import '../widget/input_field.dart';
import '../widget/result_card.dart';

// Konversi waktu ke Indonesia (WIB/WITA/WIT), Malaysia, dan Kanada
class KonversiWaktuPage extends StatefulWidget {
  const KonversiWaktuPage({super.key});

  @override
  State<KonversiWaktuPage> createState() => _KonversiWaktuPageState();
}

class _KonversiWaktuPageState extends State<KonversiWaktuPage> {
  Zona _asal = ZonaWaktu.wib;
  DateTime _tanggal = DateTime.now();
  TimeOfDay _waktu = TimeOfDay.now();
  DateTime? _utc; // waktu hasil input dalam UTC (null = belum dikonversi)

  Future<void> _pilihTanggal() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _tanggal = picked;
        _utc = null;
      });
    }
  }

  Future<void> _pilihWaktu() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _waktu,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() {
        _waktu = picked;
        _utc = null;
      });
    }
  }

  void _konversi() {
    final wall = DateTime.utc(
      _tanggal.year,
      _tanggal.month,
      _tanggal.day,
      _waktu.hour,
      _waktu.minute,
    );
    setState(() => _utc = _asal.wallToUtc(wall));
  }

  ResultItem _item(Zona z, DateTime utc, {bool highlight = false}) {
    final w = z.utcToWall(utc);
    final jam = '${dua(w.hour)}:${dua(w.minute)} ${z.abbrAt(utc)}';
    final off = offsetLabel(z.offsetAt(utc));
    return ResultItem(
      z.nama,
      '$jam ($off)\n${tanggalLengkap(w)}',
      highlight: highlight,
    );
  }

  @override
  Widget build(BuildContext context) {
    final utc = _utc;

    return Scaffold(
      appBar: AppBar(title: const Text('Konversi Waktu')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Pilih zona asal, tanggal, dan jam, lalu tekan Konversi.',
            ),
            const SizedBox(height: 16),
            ZonaDropdown(
              label: 'Zona waktu asal',
              value: _asal,
              items: ZonaWaktu.semua,
              onChanged: (z) => setState(() {
                _asal = z;
                _utc = null;
              }),
            ),
            const SizedBox(height: 14),
            PickerTile(
              label: 'Tanggal',
              value: tanggalLengkap(_tanggal),
              icon: Icons.calendar_today_rounded,
              onTap: _pilihTanggal,
            ),
            const SizedBox(height: 14),
            PickerTile(
              label: 'Jam (24 jam)',
              value: '${dua(_waktu.hour)}:${dua(_waktu.minute)}',
              icon: Icons.access_time_rounded,
              onTap: _pilihWaktu,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _konversi, child: const Text('Konversi')),
            const SizedBox(height: 20),
            if (utc != null) ...[
              ResultCard(
                title: 'Indonesia',
                icon: Icons.flag_rounded,
                items: [
                  _item(ZonaWaktu.wib, utc, highlight: true),
                  _item(ZonaWaktu.wita, utc),
                  _item(ZonaWaktu.wit, utc),
                ],
              ),
              const SizedBox(height: 14),
              ResultCard(
                title: 'Malaysia',
                icon: Icons.flag_rounded,
                items: [_item(ZonaWaktu.malaysia, utc, highlight: true)],
              ),
              const SizedBox(height: 14),
              ResultCard(
                title: 'Kanada',
                icon: Icons.flag_rounded,
                items: ZonaWaktu.kanada.map((z) => _item(z, utc)).toList(),
              ),
              const SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }
}
