const List<String> namaHari = [
  'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu',
];

const List<String> namaBulan = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli',
  'Agustus', 'September', 'Oktober', 'November', 'Desember',
];

String tanggalIndo(DateTime d) =>
    '${d.day} ${namaBulan[d.month - 1]} ${d.year}';

String tanggalLengkap(DateTime d) =>
    '${namaHari[d.weekday - 1]}, ${tanggalIndo(d)}';

String dua(int n) => n.toString().padLeft(2, '0');

// Terima angka dengan koma atau titik desimal
double? parseNum(String? t) =>
    double.tryParse((t ?? '').trim().replaceAll(',', '.'));

// Format angka gaya Indonesia: 1.234,56 (nol di belakang koma dibuang)
String fmt(double v, {int digits = 2}) {
  if (v.isNaN || v.isInfinite) return '-';
  var s = v.abs().toStringAsFixed(digits);
  if (s.contains('.')) {
    s = s.replaceFirst(RegExp(r'0+$'), '').replaceFirst(RegExp(r'\.$'), '');
  }
  final parts = s.split('.');
  final ip = parts[0];
  final buf = StringBuffer();
  for (var i = 0; i < ip.length; i++) {
    if (i > 0 && (ip.length - i) % 3 == 0) buf.write('.');
    buf.write(ip[i]);
  }
  final desimal = parts.length > 1 ? ',${parts[1]}' : '';
  final negatif = v < 0 && (buf.toString() != '0' || desimal.isNotEmpty);
  return '${negatif ? '-' : ''}$buf$desimal';
}

// Validator: wajib diisi, harus angka, harus > 0
String? validasiPositif(String? v) {
  if (v == null || v.trim().isEmpty) return 'Wajib diisi';
  final n = parseNum(v);
  if (n == null) return 'Isi dengan angka yang valid';
  if (n <= 0) return 'Harus lebih dari 0';
  return null;
}
