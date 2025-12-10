// Model untuk data laporan
class Report {
  final String id;
  final String title;
  final String time;
  final DateTime date;
  final ReportStatus status;

  Report({
    required this.id,
    required this.title,
    required this.time,
    required this.date,
    required this.status,
  });
}

enum ReportStatus { 
  dalamProses, 
  verifikasi, 
  prosesLanjutan, 
  selesai, 
  ditolak 
}