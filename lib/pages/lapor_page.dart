import 'package:flutter/material.dart';
import 'laporan_success_page.dart';

class LaporPage extends StatefulWidget {
  const LaporPage({super.key});

  @override
  State<LaporPage> createState() => _LaporPageState();
}

class _LaporPageState extends State<LaporPage> {
  int currentStep = 0;

  // Data Diri Controllers
  final TextEditingController namaController = TextEditingController();
  final TextEditingController teleponController = TextEditingController();
  final TextEditingController domisiliController = TextEditingController();

  // Kronologi Controllers
  final TextEditingController jenisKekerasanController =
      TextEditingController();
  final TextEditingController ceritaPeristiwaController =
      TextEditingController();
  final TextEditingController alasanLainController = TextEditingController();

  // Kronologi State
  String buktiFileName = '';
  String? disabilitas;
  String? statusTerlapor;
  String? alasanMelapor;
  String? pendampingan;

  @override
  void dispose() {
    namaController.dispose();
    teleponController.dispose();
    domisiliController.dispose();
    jenisKekerasanController.dispose();
    ceritaPeristiwaController.dispose();
    alasanLainController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/background_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black87,
                          size: 20,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Formurlir Pelaporan',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50),
                  ],
                ),
              ),

              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Harap mengisi formulir dengan teliti dan detail sesuai dengan intruksi, Data anda aman dan terjaga kerahasiaanya',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: Color(0xFF9E9E9E),
                    height: 1.5,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Step Indicator
              _buildStepIndicator(),

              const SizedBox(height: 30),

              // Form Content
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _buildCurrentStepContent(),
                  ),
                ),
              ),

              // Bottom Buttons
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    if (currentStep > 0)
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: OutlinedButton(
                            onPressed: () {
                              setState(() {
                                currentStep--;
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color(0xFF0066FF),
                                width: 1.5,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Kembali',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Color(0xFF0066FF),
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (currentStep > 0) const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            if (currentStep < 2) {
                              setState(() {
                                currentStep++;
                              });
                            } else {
                              // Show confirmation dialog
                              _showConfirmationDialog();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0066FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            currentStep == 2 ? 'Kirim' : 'Berikutnya',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _buildStep(1, 'Data diri', true),
          _buildDashedLine(),
          _buildStep(2, 'Kronologi', false),
          _buildDashedLine(),
          _buildStep(3, 'Preview', false),
        ],
      ),
    );
  }

  Widget _buildStep(int stepNumber, String label, bool isActive) {
    bool isCurrent = stepNumber == currentStep + 1;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCurrent ? const Color(0xFF0066FF) : Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: isCurrent
                    ? const Color(0xFF0066FF)
                    : const Color(0xFFE0E0E0),
                width: 2,
              ),
            ),
            child: Center(
              child: Text(
                stepNumber.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                  color: isCurrent ? Colors.white : const Color(0xFF9E9E9E),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isCurrent ? FontWeight.w600 : FontWeight.normal,
              fontFamily: 'Poppins',
              color: isCurrent ? Colors.black87 : const Color(0xFF9E9E9E),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashedLine() {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: CustomPaint(
          size: const Size(double.infinity, 2),
          painter: DashedLinePainter(),
        ),
      ),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (currentStep) {
      case 0:
        return _buildDataDiriForm();
      case 1:
        return _buildKronologiForm();
      case 2:
        return _buildPreviewForm();
      default:
        return _buildDataDiriForm();
    }
  }

  Widget _buildDataDiriForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data Diri Anda',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Silahkan anda isi form informasi terkait data diri anda agar dapat mempermudah kami dalam menanggapi laporan anda',
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins',
            color: Color(0xFF6D6D6D),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Nama Lengkap
        RichText(
          text: const TextSpan(
            text: 'Nama Lengkap',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: namaController,
          decoration: InputDecoration(
            hintText: 'Isi nama lengkap anda',
            hintStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Color(0xFFBDBDBD),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0066FF),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0066FF),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0066FF), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 8),
        const Text(
          'Nama harus sesuai dengan identitas asli, jangan mengguakan nama samaran atau lainnya',
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            color: Color(0xFF9E9E9E),
          ),
        ),
        const SizedBox(height: 24),

        // Nomor Telepon
        RichText(
          text: const TextSpan(
            text: 'Nomor Telepon',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              width: 100,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFF0066FF), width: 1.5),
              ),
              child: const Center(
                child: Text(
                  'ID +62',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: teleponController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  hintText: 'Masukan no telepon anda',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Color(0xFFBDBDBD),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF0066FF),
                      width: 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF0066FF),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF0066FF),
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Domisili
        RichText(
          text: const TextSpan(
            text: 'Domisili',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: domisiliController,
          decoration: InputDecoration(
            hintText: 'tuliskan domisili anda',
            hintStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Color(0xFFBDBDBD),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0066FF),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0066FF),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0066FF), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 8),
        const Text(
          'Lorem ipsun dolor sit amet yakusibo yare yare ubito kokopi kojo juhan',
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            color: Color(0xFF9E9E9E),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildKronologiForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kronologi Kejadian',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Silahkan anda mengisi form dibawah ini sesuai keterangan, dan sekali lagi kami yakinkan bahwa segala sesuatu yang anda sampaikan bersifat rahasia',
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins',
            color: Color(0xFF6D6D6D),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 32),

        // Jenis Kekerasan
        RichText(
          text: const TextSpan(
            text: 'Jenis Kekerasan',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: jenisKekerasanController,
          decoration: InputDecoration(
            hintText: 'Tulis jenis kekerasa yang anda alami',
            hintStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Color(0xFFBDBDBD),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0066FF),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0066FF),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0066FF), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 8),
        const Text(
          'Narasikan secara singkat kekerasaan yang anda alami',
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            color: Color(0xFFFFA500),
          ),
        ),
        const SizedBox(height: 24),

        // Cerita Peristiwa
        RichText(
          text: const TextSpan(
            text: 'Cerita Peristiwa',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: ceritaPeristiwaController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText:
                'Tuliskan secara rinci peristiwa kejadian yang anda alami',
            hintStyle: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              color: Color(0xFFBDBDBD),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0066FF),
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF0066FF),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF0066FF), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
        ),
        const SizedBox(height: 24),

        // Lampiran Bukti
        RichText(
          text: const TextSpan(
            text: 'Lampiran Bukti Kekerasan',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // TODO: Implement file picker
            setState(() {
              buktiFileName = 'bukti_kekerasan.jpg';
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0066FF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          ),
          child: const Text(
            'Unggah',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          buktiFileName.isEmpty
              ? 'Jika tidak ada lampiran bukti form ini boleh dilewatkan'
              : buktiFileName,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            color: Color(0xFF9E9E9E),
          ),
        ),
        const SizedBox(height: 32),

        // Pertanyaan Lainnya
        const Text(
          'Pertanyaan Lainnya',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Silahkan pilih jawaban dari pertanyaan yang sudah disajikan agar memperjelas laporan anda',
          style: TextStyle(
            fontSize: 13,
            fontFamily: 'Poppins',
            color: Color(0xFF6D6D6D),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),

        // Disabilitas
        RichText(
          text: const TextSpan(
            text: 'Apakah Korban Memiliki Disabilitas?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildRadioOption('Ya', disabilitas, (value) {
          setState(() {
            disabilitas = value;
          });
        }),
        _buildRadioOption('Tidak', disabilitas, (value) {
          setState(() {
            disabilitas = value;
          });
        }),
        const SizedBox(height: 24),

        // Status Terlapor
        RichText(
          text: const TextSpan(
            text: 'Status Terlapor Dikampus?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildRadioOption('Mahasiswa', statusTerlapor, (value) {
          setState(() {
            statusTerlapor = value;
          });
        }),
        _buildRadioOption('Pendidik (Dosen)', statusTerlapor, (value) {
          setState(() {
            statusTerlapor = value;
          });
        }),
        _buildRadioOption('Staff / Teknisi', statusTerlapor, (value) {
          setState(() {
            statusTerlapor = value;
          });
        }),
        _buildRadioOption('Warga Kampus', statusTerlapor, (value) {
          setState(() {
            statusTerlapor = value;
          });
        }),
        _buildRadioOption('Masyarakat Umum', statusTerlapor, (value) {
          setState(() {
            statusTerlapor = value;
          });
        }),
        const SizedBox(height: 24),

        // Alasan Melapor
        RichText(
          text: const TextSpan(
            text: 'Alasan Anda Melapor?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildRadioOption(
          'Saya seorang korban yang memerlukan bantuan pemulihan',
          alasanMelapor,
          (value) {
            setState(() {
              alasanMelapor = value;
            });
          },
        ),
        _buildRadioOption(
          'Saya seorang saksi yang khwatir dengan keadaan korban',
          alasanMelapor,
          (value) {
            setState(() {
              alasanMelapor = value;
            });
          },
        ),
        _buildRadioOption(
          'Saya ingin perguruan tinggi menindak tegas terlapor',
          alasanMelapor,
          (value) {
            setState(() {
              alasanMelapor = value;
            });
          },
        ),
        _buildRadioOption('Lainnya', alasanMelapor, (value) {
          setState(() {
            alasanMelapor = value;
          });
        }),
        if (alasanMelapor == 'Lainnya') ...[
          const SizedBox(height: 12),
          TextField(
            controller: alasanLainController,
            decoration: InputDecoration(
              hintText: 'Tuliskan alasan lainnya',
              hintStyle: const TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: Color(0xFFBDBDBD),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0066FF),
                  width: 1.5,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0066FF),
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xFF0066FF),
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
            style: const TextStyle(fontSize: 14, fontFamily: 'Poppins'),
          ),
        ],
        const SizedBox(height: 24),

        // Pendampingan
        RichText(
          text: const TextSpan(
            text: 'Apakah Anda Ingin Mengajukan Pendampingan',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              color: Colors.black87,
            ),
            children: [
              TextSpan(
                text: '*',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _buildRadioOption('Ya', pendampingan, (value) {
          setState(() {
            pendampingan = value;
          });
        }),
        _buildRadioOption('Tidak', pendampingan, (value) {
          setState(() {
            pendampingan = value;
          });
        }),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildRadioOption(
    String title,
    String? groupValue,
    Function(String?) onChanged,
  ) {
    return InkWell(
      onTap: () => onChanged(title),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: groupValue == title
                      ? const Color(0xFF0066FF)
                      : const Color(0xFFBDBDBD),
                  width: 2,
                ),
              ),
              child: groupValue == title
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0066FF),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreviewForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Warning Box
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9E6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Color(0xFF2196F3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Tinjau Kembali',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Harap tinjau kembali laporan anda sebelum anda kirim, menghindari laporan tau penulisan kronologi yang tidak tepat',
            style: TextStyle(
              fontSize: 12,
              fontFamily: 'Poppins',
              color: Color(0xFF6D6D6D),
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 24),

        // Data Diri Section
        const Text(
          'Data Diri',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9E6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPreviewField('Nama Lengkap', namaController.text),
              const SizedBox(height: 16),
              _buildPreviewField('Nomer Telepon', teleponController.text),
              const SizedBox(height: 16),
              _buildPreviewField('Domisili', domisiliController.text),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Kronologi Section
        const Text(
          'Kronologi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9E6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPreviewField(
                'Jenis Kekerasan',
                jenisKekerasanController.text,
              ),
              const SizedBox(height: 16),
              _buildPreviewField(
                'Cerita Peristiwa',
                ceritaPeristiwaController.text,
                isMultiline: true,
              ),
              const SizedBox(height: 16),
              const Text(
                'Lampiran Bukti',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color(0xFF6D6D6D),
                ),
              ),
              const SizedBox(height: 8),
              if (buktiFileName.isNotEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2196F3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        buktiFileName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.close, color: Colors.white, size: 16),
                    ],
                  ),
                )
              else
                const Text(
                  'Tidak ada file',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Pertanyaan Lainnya Section
        const Text(
          'Pertanyaan Lainnya',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF9E6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPreviewField(
                'Apakah Korban Memiliki Disabilitas?',
                disabilitas ?? '-',
              ),
              const SizedBox(height: 16),
              _buildPreviewField(
                'Status Terlapor Dikampus?',
                statusTerlapor ?? '-',
              ),
              const SizedBox(height: 16),
              _buildPreviewField(
                'Alasan Anda Melapor?',
                alasanMelapor == 'Lainnya'
                    ? alasanLainController.text
                    : alasanMelapor ?? '-',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Permintaan Pendampingan
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Permintaan Pendampingan',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                  ),
                ),
              ),
              Icon(
                pendampingan == 'Ya' ? Icons.check_circle : Icons.cancel,
                color: pendampingan == 'Ya'
                    ? const Color(0xFF2196F3)
                    : const Color(0xFF6D6D6D),
                size: 24,
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Anda yakin untuk mengirim laporan tersebut ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF0066FF),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Color(0xFF0066FF),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigate to success page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LaporanSuccessPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0066FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Kirim',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPreviewField(
    String label,
    String value, {
    bool isMultiline = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: 'Poppins',
            color: Color(0xFF6D6D6D),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.isEmpty ? '-' : value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE0E0E0)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 5.0;
    const dashSpace = 5.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
