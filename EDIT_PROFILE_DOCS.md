# Dokumentasi Fitur Edit Profile

## 📋 Overview
Fitur Edit Profile memungkinkan user (mahasiswa) untuk melengkapi dan memperbarui data profile mereka.

## 🎯 Fitur yang Sudah Diimplementasikan

### 1. **Profile Page** (`lib/pages/profile_page.dart`)
✅ **Warning Banner** - Muncul otomatis jika profile belum lengkap
- Kondisi: Jika salah satu dari `nim`, `full_name`, `jurusan`, atau `phone_number` kosong
- Aksi: Klik banner untuk navigate ke Edit Profile
- UI: Background kuning dengan icon warning

✅ **Profile Card**
- Menampilkan foto profile (default icon jika belum upload)
- Nama Lengkap (default "Jane Doe" jika null)
- NIM (default "23756003" jika null)
- Tombol Edit (icon kecil di foto profile)

✅ **Auto Refresh**
- Data profile otomatis refresh setelah berhasil update

### 2. **Edit Profile Page** (`lib/pages/edit_profile_page.dart`)
✅ **Form Fields**
1. **NIM** 
   - Pre-filled dari API
   - Disabled (tidak bisa diedit)
   - Validasi: Required

2. **Nama Lengkap**
   - Pre-filled dari API
   - Validasi: Required, tidak boleh kosong

3. **Jurusan**
   - Pre-filled dari API
   - Validasi: Required, tidak boleh kosong

4. **Nomor Telepon**
   - Pre-filled dari API
   - Keyboard: Numeric
   - Validasi: 
     - Required
     - Hanya angka
     - Panjang 10-15 digit

✅ **UI/UX**
- Form dengan `GlobalKey<FormState>` untuk validasi
- Loading indicator saat fetch data
- Loading spinner di tombol saat submit
- Tombol disabled saat loading
- Auto focus ke field error pertama

✅ **Error Handling**
- Success: SnackBar hijau + navigate back + refresh profile
- Error: SnackBar merah dengan pesan dari backend

### 3. **Mahasiswa Service** (`lib/services/mahasiswa_service.dart`)
✅ **Method: getMyProfile()**
- Endpoint: `GET /api/mahasiswa/me`
- Headers: Authorization Bearer Token
- Return: Profile data (nim, full_name, jurusan, phone_number)

✅ **Method: updateMyProfile()**
- Endpoint: `PUT /api/mahasiswa/me`
- Headers: Authorization Bearer Token + Content-Type JSON
- Body: `{ nim, full_name, jurusan, phone_number }`
- Return: Success/error message

## 🔧 Backend API

### Endpoint 1: Get Profile
```
GET /api/mahasiswa/me
Headers: Authorization: Bearer {token}

Response (200):
{
  "success": true,
  "data": {
    "nim": "237B6003",
    "full_name": "Jane Doe",
    "jurusan": "Teknik Informatika",
    "phone_number": "081234567890"
  }
}
```

### Endpoint 2: Update Profile
```
PUT /api/mahasiswa/me
Headers: 
  Authorization: Bearer {token}
  Content-Type: application/json

Body:
{
  "nim": "237B6003",
  "full_name": "Jane Doe Updated",
  "jurusan": "Teknik Informatika",
  "phone_number": "081234567890"
}

Response (200):
{
  "success": true,
  "message": "Profile berhasil diperbarui",
  "data": { ... }
}

Response (400):
{
  "success": false,
  "message": "Nomor telepon harus berupa angka (10-15 digit)"
}
```

## ✅ Validasi Client-Side

### 1. NIM
- [x] Required
- [x] Disabled (tidak bisa diedit)

### 2. Nama Lengkap
- [x] Required
- [x] Tidak boleh kosong

### 3. Jurusan
- [x] Required
- [x] Tidak boleh kosong

### 4. Nomor Telepon
- [x] Required
- [x] Hanya angka (regex: `^[0-9]+$`)
- [x] Panjang 10-15 digit
- [x] Keyboard numeric

## 🎨 UI Flow

### Flow 1: Profile Belum Lengkap
```
1. User buka Profile Page
2. System check: profile incomplete? → YES
3. Show warning banner (kuning)
4. User klik banner
5. Navigate to Edit Profile Page
6. Pre-fill form dengan data dari API
7. User isi/update field yang kosong
8. Submit form
9. Success → Navigate back + refresh profile
10. Warning banner hilang (karena sudah lengkap)
```

### Flow 2: Update Profile yang Sudah Lengkap
```
1. User buka Profile Page
2. User klik icon edit (di foto profile)
3. Navigate to Edit Profile Page
4. Pre-fill form dengan data dari API
5. User ubah data (misal: nomor telepon)
6. Submit form
7. Success → Navigate back + refresh profile
8. Data terupdate di Profile Page
```

## 🔒 Security
✅ Authorization: Semua request menggunakan Bearer Token
✅ Token auto-inject via Dio Interceptor
✅ Token expired handling (401)

## 📝 File yang Terlibat

### Pages
- `lib/pages/profile_page.dart` - Halaman profile utama
- `lib/pages/edit_profile_page.dart` - Form edit profile

### Services
- `lib/services/mahasiswa_service.dart` - API service untuk mahasiswa
- `lib/services/api_client.dart` - HTTP client dengan Dio

### Models (Optional - bisa ditambahkan)
- `lib/models/profile.dart` - Model data profile

## 🚀 Testing Checklist

### Scenario 1: Profile Kosong
- [ ] Warning banner muncul
- [ ] Klik banner → navigate ke Edit Profile
- [ ] Form fields kosong/default
- [ ] Isi semua field dengan data valid
- [ ] Submit → Success
- [ ] Back to profile → warning banner hilang

### Scenario 2: Update Profile
- [ ] Klik icon edit
- [ ] Form pre-filled dengan data existing
- [ ] Ubah nomor telepon
- [ ] Submit → Success
- [ ] Back to profile → data terupdate

### Scenario 3: Validation Error
- [ ] Kosongkan field Nama Lengkap
- [ ] Submit → Error "tidak boleh kosong"
- [ ] Isi nomor telepon < 10 digit
- [ ] Submit → Error "harus 10-15 digit"
- [ ] Isi nomor telepon dengan huruf
- [ ] Submit → Error "hanya boleh berisi angka"

### Scenario 4: Network Error
- [ ] Matikan backend
- [ ] Submit → Error message dari catch block
- [ ] Nyalakan backend
- [ ] Submit lagi → Success

## 🎯 Next Enhancement (Future)
- [ ] Upload foto profile
- [ ] Validasi NIM format (misalnya: 23xxxx)
- [ ] Dropdown untuk Jurusan (dari API)
- [ ] Email field (optional)
- [ ] Loading skeleton di Profile Page
- [ ] Pull-to-refresh di Profile Page

## 📌 Notes
- File `.dart_tool/` tidak perlu di-commit (sudah di .gitignore)
- Endpoint menggunakan `/api/mahasiswa/me` (specific untuk mahasiswa)
- Alternatif endpoint general: `/api/me` dan `/api/profile` bisa digunakan untuk semua role
