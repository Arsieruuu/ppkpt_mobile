# Illustrations Assets

Folder ini khusus untuk menyimpan ilustrasi utama setiap halaman aplikasi PPKPT.

## File yang dibutuhkan:

### 🎨 **Main Illustrations**
- `illustration_home.png` - Ilustrasi dashboard beranda
- `illustration_report.png` - Ilustrasi form laporan (orang dengan smartphone)
- `illustration_history.png` - Ilustrasi riwayat/tracking laporan
- `illustration_profile.png` - Ilustrasi profil pengguna

### 📋 **Optional Illustrations**
- `illustration_empty_state.png` - Untuk kondisi data kosong
- `illustration_success.png` - Ilustrasi berhasil submit laporan
- `illustration_error.png` - Ilustrasi error/gagal

## Spesifikasi Gambar:
- **Format**: PNG dengan transparansi atau JPG
- **Ukuran**: 300x200px - 600x400px
- **Style**: Modern flat design, friendly illustration
- **Warna**: Brand colors (#0068FF, #FFBB00) + neutral colors
- **Tone**: Professional tapi approachable

## Tips Design:
- Gunakan karakter yang inclusive dan representatif
- Hindari detail berlebihan, focus pada clarity
- Pastikan ilustrasi mudah dipahami dalam konteks mobile
- Konsisten dengan overall brand identity

## Implementasi:
Ilustrasi akan ditempatkan di center halaman sebagai visual hero element.

```dart
Image.asset(
  'assets/images/illustrations/illustration_report.png',
  height: 240,
  fit: BoxFit.contain,
)
```