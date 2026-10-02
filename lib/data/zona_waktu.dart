// Data & logika zona waktu (termasuk DST Kanada).
// Aturan DST Kanada: mulai Minggu ke-2 Maret pukul 02:00 waktu standar,
// selesai Minggu ke-1 November pukul 02:00 waktu musim panas.

// Tanggal Minggu ke-n pada bulan tertentu
int _mingguKe(int tahun, int bulan, int n) {
  final first = DateTime.utc(tahun, bulan, 1);
  final hariPertama = 1 + (7 - first.weekday % 7) % 7;
  return hariPertama + 7 * (n - 1);
}

class Zona {
  final String nama; // nama tampilan
  final int std; // offset standar (menit dari UTC)
  final String stdAbbr;
  final String? dstAbbr; // null = tidak ada DST

  const Zona(this.nama, this.std, this.stdAbbr, [this.dstAbbr]);

  bool isDst(DateTime utc) {
    if (dstAbbr == null) return false;
    final y = utc.year;
    final mulai = DateTime.utc(y, 3, _mingguKe(y, 3, 2), 2)
        .subtract(Duration(minutes: std));
    final selesai = DateTime.utc(y, 11, _mingguKe(y, 11, 1), 2)
        .subtract(Duration(minutes: std + 60));
    return !utc.isBefore(mulai) && utc.isBefore(selesai);
  }

  int offsetAt(DateTime utc) => std + (isDst(utc) ? 60 : 0);
  String abbrAt(DateTime utc) => isDst(utc) ? dstAbbr! : stdAbbr;

  // wall = jam dinding zona ini (disimpan dalam DateTime.utc sebagai wadah)
  DateTime wallToUtc(DateTime wall) {
    final tebakan = wall.subtract(Duration(minutes: std));
    return wall.subtract(Duration(minutes: offsetAt(tebakan)));
  }

  DateTime utcToWall(DateTime utc) =>
      utc.add(Duration(minutes: offsetAt(utc)));
}

String offsetLabel(int menit) {
  final tanda = menit < 0 ? '-' : '+';
  final h = menit.abs() ~/ 60;
  final m = menit.abs() % 60;
  return m == 0
      ? 'UTC$tanda$h'
      : 'UTC$tanda$h:${m.toString().padLeft(2, '0')}';
}

class ZonaWaktu {
  static const wib = Zona('Indonesia - WIB', 420, 'WIB');
  static const wita = Zona('Indonesia - WITA', 480, 'WITA');
  static const wit = Zona('Indonesia - WIT', 540, 'WIT');
  static const malaysia = Zona('Malaysia (Kuala Lumpur)', 480, 'MYT');

  static const pacific =
      Zona('Kanada - Pacific (Vancouver)', -480, 'PST', 'PDT');
  static const mountain =
      Zona('Kanada - Mountain (Edmonton)', -420, 'MST', 'MDT');
  static const central =
      Zona('Kanada - Central (Winnipeg)', -360, 'CST', 'CDT');
  static const eastern =
      Zona('Kanada - Eastern (Toronto)', -300, 'EST', 'EDT');
  static const atlantic =
      Zona('Kanada - Atlantic (Halifax)', -240, 'AST', 'ADT');
  static const newfoundland =
      Zona('Kanada - Newfoundland (St. John\'s)', -210, 'NST', 'NDT');

  static const List<Zona> indonesia = [wib, wita, wit];

  static const List<Zona> kanada = [
    pacific,
    mountain,
    central,
    eastern,
    atlantic,
    newfoundland,
  ];

  // Zona yang bisa dipilih sebagai asal
  static const List<Zona> semua = [
    wib,
    wita,
    wit,
    malaysia,
    pacific,
    mountain,
    central,
    eastern,
    atlantic,
    newfoundland,
  ];
}
