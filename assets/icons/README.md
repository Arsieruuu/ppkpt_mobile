# Assets Icons

Folder ini digunakan untuk menyimpan icon-icon custom untuk aplikasi PPKPT.

## Struktur Folder:
```
assets/
└── icons/
    ├── icon_beranda.png      # Icon untuk tab beranda
    ├── icon_lapor.png        # Icon untuk tab lapor  
    ├── icon_riwayat.png      # Icon untuk tab riwayat
    ├── icon_profile.png      # Icon untuk tab profile
    └── ... (icon lainnya)
```

## Format Icon yang Disarankan:
- **Format**: PNG dengan background transparan
- **Ukuran**: 24x24px, 48x48px (untuk berbagai density)
- **Style**: Outline untuk state normal, filled untuk state active

## Cara Menggunakan Icon Custom:

Setelah upload icon ke folder ini, edit `main.dart` pada bagian `_buildNavItem`:

```dart
// Contoh penggunaan icon custom
Image.asset(
  'assets/icons/icon_beranda.png',
  width: 20,
  height: 20,
  color: isSelected ? Colors.white : Colors.grey[600],
)
```

## Catatan:
- Pastikan icon sudah ditambahkan ke `pubspec.yaml` di bagian assets
- Jalankan `flutter pub get` setelah menambah asset baru
- Icon akan otomatis ter-load dengan berbagai density (1x, 2x, 3x)