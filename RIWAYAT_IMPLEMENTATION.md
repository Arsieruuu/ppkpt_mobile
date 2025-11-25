# Implementasi Halaman Riwayat PPKPT Mobile

## Deskripsi
Halaman Riwayat telah dibuat sesuai dengan desain yang diminta dengan fitur-fitur berikut:

## Fitur yang Diimplementasikan

### 1. AppBar Sederhana
- Title "Riwayat" dengan styling bersih
- Background putih dengan elevation 0
- Text styling: fontSize 18, fontWeight w600

### 2. Segmented Control (Tab Toggle)
- Dua tab: "Selesai" (default aktif) dan "Ditolak"
- Tab aktif: background biru #1683FF, teks putih
- Tab tidak aktif: background putih, border abu #E0E0E0, teks abu #6D6D6D
- Border radius 12 dengan animasi smooth

### 3. Daftar Laporan (ListView)
- Filter otomatis berdasarkan tab yang dipilih
- Padding 16 untuk container utama
- Spacing 12 antar kartu

### 4. Kartu Laporan (ReportCard)
- Container putih dengan borderRadius 16
- Padding 16 di dalam kartu
- Shadow: blur 12, offset (0,4), rgba(0,0,0,0.06)
- Leading icon: kotak 40x40, radius 12, background #E6F2FF, icon dokumen biru #1683FF
- Konten: judul bold, kode laporan biru (tappable), meta info waktu dan tanggal
- Status badge di kanan atas

### 5. Status Badge
- Selesai: ikon favorite_border + teks "Selesai", warna hijau #17C964, background transparan
- Ditolak: ikon close + teks "Ditolak", warna merah #FF4D4F, background transparan
- Border radius 12, padding horizontal 8, vertical 4

### 6. State Management
- Loading state: skeleton shimmer dengan 3 kartu placeholder
- Empty state: ikon folder_open + teks "Belum ada laporan [selesai/ditolak]"
- Error state (ready to implement): teks merah + tombol "Coba Lagi"

### 7. Theme Custom
- Primary: #1683FF (biru)
- Success: #17C964 (hijau)
- Danger: #FF4D4F (merah)
- Background: #F8F9FA (abu terang)

## Struktur File

```
lib/
├── models/
│   └── report.dart              # Model data laporan
├── widgets/
│   ├── segmented_control.dart   # Komponen tab toggle
│   ├── status_badge.dart        # Badge status laporan
│   └── report_card.dart         # Kartu laporan
├── pages/
│   └── riwayat_page.dart        # Halaman utama riwayat
└── main.dart                    # Entry point dengan tema custom
```

## Data Dummy
- 1 laporan selesai: "LP-078957KS - Kekerasan Seksual"
- 1 laporan ditolak: "LP-123456AB - Kekerasan Fisik"

## Interaksi
- Tab switching dengan setState
- Kode laporan dapat di-tap (menampilkan SnackBar)
- Navigation terintegrasi dengan bottom nav existing

## Teknologi
- StatefulWidget untuk state management sederhana
- Custom widgets terpisah untuk reusability
- Material Design 3 dengan custom color scheme
- Responsive layout dengan proper constraints

Implementasi sudah selesai dan dapat dijalankan langsung dengan `flutter run`.