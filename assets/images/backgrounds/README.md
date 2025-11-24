# Background Assets

Folder ini khusus untuk menyimpan gambar background halaman aplikasi PPKPT.

## File yang dibutuhkan:

### 🎨 **Background Elements**
- `bg_beranda.png` - Background elements untuk halaman Beranda
- `bg_lapor.png` - Background elements untuk halaman Lapor  
- `bg_riwayat.png` - Background elements untuk halaman Riwayat
- `bg_profile.png` - Background elements untuk halaman Profile

### 🔮 **Alternative: Pattern/Texture**
- `bg_pattern.png` - Pattern/texture umum untuk semua halaman
- `bg_overlay.png` - Overlay transparan untuk efek tambahan

## Spesifikasi Gambar:
- **Format**: PNG dengan transparansi
- **Ukuran**: Full screen mobile (375x812px) atau lebih besar
- **Style**: Subtle pattern, geometric shapes, atau abstract elements
- **Opacity**: Disesuaikan dengan design (biasanya 20-40%)
- **Warna**: Sesuai brand colors (#0068FF, #FFBB00)

## Implementasi di Code:
Background ini akan menggantikan gradasi bulat saat ini dengan gambar yang lebih rich.

```dart
// Contoh penggunaan:
Container(
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/images/backgrounds/bg_beranda.png'),
      fit: BoxFit.cover,
      opacity: 0.3,
    ),
  ),
  child: // konten halaman
)
```

## Catatan:
- Upload file sesuai nama yang sudah ditentukan
- Pastikan ukuran file tidak terlalu besar (< 500KB per file)
- Test di berbagai ukuran layar untuk memastikan responsivitas