# Assets Images

Folder ini digunakan untuk menyimpan gambar/ilustrasi untuk aplikasi PPKPT.

## 📁 **Struktur Folder:**

### `/backgrounds/` 
Background elements dan pattern untuk setiap halaman
- `bg_beranda.png`, `bg_lapor.png`, `bg_riwayat.png`, `bg_profile.png`

### `/illustrations/`
Ilustrasi utama untuk setiap halaman
- `illustration_report.png`, `illustration_home.png`, dll.

### `/icons/`  
Icon custom dan elemen UI
- `emergency_icon.png`, custom navigation icons, dll.

## File yang dibutuhkan:

### 📱 **Halaman Lapor**
- `illustrations/illustration_report.png` - Ilustrasi utama (orang dengan smartphone)
- `backgrounds/bg_lapor.png` - Background pattern/elements

### 🏠 **Halaman Beranda**  
- `illustrations/illustration_home.png` - Ilustrasi dashboard beranda
- `backgrounds/bg_beranda.png` - Background pattern/elements
- `icons/emergency_icon.png` - Icon tombol darurat

### 📊 **Halaman Riwayat**
- `illustrations/illustration_history.png` - Ilustrasi riwayat laporan
- `backgrounds/bg_riwayat.png` - Background pattern/elements

### 👤 **Halaman Profile**
- `illustrations/illustration_profile.png` - Ilustrasi profil pengguna
- `backgrounds/bg_profile.png` - Background pattern/elements

## Format Gambar yang Disarankan:
- **Format**: PNG dengan background transparan atau JPG
- **Ilustrasi**: 300x200px - 600x400px 
- **Background**: Full screen mobile (375x812px+)
- **Icons**: 24x24px - 64x64px
- **Style**: Flat design, modern illustration
- **Warna**: Sesuai dengan color scheme app (#0068FF, #FFBB00, cream)

## Cara Upload:
1. Simpan file gambar di folder yang sesuai
2. Pastikan nama file sesuai dengan yang digunakan di code
3. Update `pubspec.yaml` jika diperlukan
4. Jalankan `flutter pub get` setelah menambah asset baru

## Contoh Penggunaan di Code:
```dart
// Background
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/backgrounds/bg_beranda.png'),
      fit: BoxFit.cover,
      opacity: 0.3,
    ),
  ),
)

// Ilustrasi
Image.asset(
  'assets/images/illustrations/illustration_report.png',
  height: 280,
  fit: BoxFit.cover,
)

// Icon
Image.asset(
  'assets/images/icons/emergency_icon.png',
  width: 32,
  height: 32,
)
```

**Note**: Sementara menggunakan gradasi bulat. Upload gambar sesuai design untuk hasil optimal.