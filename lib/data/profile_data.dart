// =====================================================================
// DATA DIRI untuk menu Profile.
// TODO: sesuaikan tempat lahir, tanggal lahir, dan hobi dengan data aslimu.
// Foto: taruh file di assets/images/foto_profil.jpg lalu daftarkan di
// pubspec.yaml. Kalau file belum ada, halaman Profile menampilkan ikon
// default (aplikasi tidak error).
// =====================================================================
class ProfileData {
  static const String nama = 'Anindya Zahir Adianputri';
  static const String nim = '124240113';
  static const String tempatLahir = 'Yogyakarta'; // TODO: ganti
  static final DateTime tanggalLahir = DateTime(2004, 2, 9); // TODO: ganti
  static const List<String> hobi = [
    'Membaca',
    'Mendengarkan musik',
    'Traveling',
  ]; // TODO: ganti
  static const String fotoAsset = 'assets/images/foto_profil.jpg';
}
