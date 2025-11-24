# PPKPT Mobile App

Aplikasi mobile PPKPT (Perlindungan Perempuan dan Kekerasan dalam Pacaran dan Teman) yang dirancang untuk membantu pengguna melaporkan dan melacak kasus kekerasan.

## Fitur Utama

### 🏠 **Beranda**
- Dashboard utama dengan informasi selamat datang
- Tombol darurat untuk panggilan emergency
- Menu layanan cepat:
  - Lapor Kejadian
  - Riwayat Laporan
  - Lokasi Aman
  - Kontak Darurat

### 📝 **Lapor**
- Form laporan kejadian yang komprehensif
- Kategori kejadian:
  - Kekerasan Seksual
  - Kekerasan Fisik
  - Kekerasan Psikis
  - Penelantaran
  - Trafficking
  - Lainnya
- Upload bukti pendukung (foto, video, dokumen)
- Lokasi kejadian dengan GPS tracking
- Opsi laporan anonim

### 📊 **Riwayat**
- Tab "Selesai" untuk laporan yang telah ditindaklanjuti
- Tab "Ditolak" untuk laporan yang tidak dapat diproses
- Detail lengkap setiap laporan termasuk ID tracking
- Status real-time dari setiap laporan

### 👤 **Profile**
- Informasi profil pengguna
- Pengaturan akun dan keamanan
- Menu bantuan dan dukungan
- Kebijakan privasi
- Fitur logout yang aman

## Struktur Proyek

```
lib/
├── main.dart                 # Entry point aplikasi dengan bottom navigation
├── pages/
│   ├── beranda_page.dart    # Halaman beranda
│   ├── lapor_page.dart      # Halaman form laporan
│   ├── riwayat_page.dart    # Halaman riwayat laporan
│   └── profile_page.dart    # Halaman profil pengguna
```

## Instalasi dan Menjalankan

1. Pastikan Flutter sudah terinstall di sistem Anda
2. Clone atau download project ini
3. Buka terminal/command prompt di folder project
4. Jalankan command berikut:

```bash
flutter pub get
flutter run
```

## Teknologi yang Digunakan

- **Flutter**: Framework UI cross-platform
- **Material Design 3**: Design system untuk UI yang modern
- **Dart**: Bahasa pemrograman

## Screenshots

Aplikasi ini memiliki tampilan yang responsif dan user-friendly dengan:
- Bottom navigation bar dengan 4 tab utama
- Design yang clean dan modern
- Warna yang konsisten (biru untuk beranda, hijau untuk riwayat, purple untuk profile)
- Form yang mudah digunakan

## Catatan Pengembangan

- Aplikasi ini masih dalam tahap pengembangan
- Beberapa fitur seperti GPS tracking dan upload file masih dalam pengembangan
- Database integration belum diimplementasikan (saat ini menggunakan data dummy)

## Kontribusi

Silakan berkontribusi untuk mengembangkan aplikasi ini lebih baik lagi!

---

**Developed with ❤️ for women safety and protection**
