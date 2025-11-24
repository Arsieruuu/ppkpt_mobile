# Assets Images

Folder ini digunakan untuk menyimpan gambar/ilustrasi untuk aplikasi PPKPT.

## File yang dibutuhkan:

### 📱 **Halaman Lapor**
- `illustration_report.png` - Ilustrasi utama (orang dengan smartphone)
- `bg_elements.png` - Elemen dekoratif background (opsional)

### 🏠 **Halaman Beranda**  
- `illustration_home.png` - Ilustrasi dashboard beranda
- `emergency_icon.png` - Icon tombol darurat

### 📊 **Halaman Riwayat**
- `illustration_history.png` - Ilustrasi riwayat laporan

### 👤 **Halaman Profile**
- `illustration_profile.png` - Ilustrasi profil pengguna

## Format Gambar yang Disarankan:
- **Format**: PNG dengan background transparan atau JPG
- **Ukuran**: 300x200px - 600x400px 
- **Style**: Flat design, modern illustration
- **Warna**: Sesuai dengan color scheme app (biru, kuning, cream)

## Cara Upload:
1. Simpan file gambar di folder ini
2. Pastikan nama file sesuai dengan yang digunakan di code
3. Jalankan `flutter pub get` setelah menambah asset baru

## Contoh Penggunaan di Code:
```dart
Image.asset(
  'assets/images/illustration_report.png',
  height: 280,
  fit: BoxFit.cover,
)
```

**Note**: Sementara ini menggunakan placeholder. Upload gambar sesuai design untuk hasil optimal.