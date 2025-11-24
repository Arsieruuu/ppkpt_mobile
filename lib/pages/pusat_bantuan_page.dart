import 'package:flutter/material.dart';

class PusatBantuanPage extends StatefulWidget {
  const PusatBantuanPage({super.key});

  @override
  State<PusatBantuanPage> createState() => _PusatBantuanPageState();
}

class _PusatBantuanPageState extends State<PusatBantuanPage> {
  int? expandedIndex;

  final List<Map<String, dynamic>> faqData = [
    {
      'question': 'Apa itu PPKPT Polinela ?',
      'answer': '',
    },
    {
      'question': 'Siapa saja yang dapat menggunakan aplikasi ini ?',
      'answer': '',
    },
    {
      'question': 'Bagaimana cara melaporkan kekerasan melalui aplikasi ?',
      'answer': 'Buka aplikasi\n\nPilih menu Laporan, atau dapat langsung diakses melalui tombol pada beranda untuk langsung masuk ke menu pelaporan\n\nLalu isi form sesuai keterangan yang diminta',
      'isExpanded': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png',
            width: 39,
            height: 39,
            fit: BoxFit.contain,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Pusat Bantuan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/background_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Pertanyaan atau Topik.......',
                    hintStyle: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/icons/search.png',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                ),
              ),
            ),
            
            // FAQ Section
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    
                    // Section Title
                    const Text(
                      'Pertanyaan Umum',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                        color: Color(0xFF1E90FF),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // FAQ Items
                    ...faqData.asMap().entries.map((entry) {
                      int index = entry.key;
                      Map<String, dynamic> faq = entry.value;
                      bool isExpanded = expandedIndex == index;
                      
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              spreadRadius: 0,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  expandedIndex = isExpanded ? null : index;
                                });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        faq['question'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Poppins',
                                          color: isExpanded 
                                              ? const Color(0xFF0068FF)
                                              : Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      isExpanded 
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: isExpanded 
                                          ? const Color(0xFF0068FF)
                                          : Colors.grey,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            if (isExpanded && faq['answer'].isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(
                                      color: Colors.grey,
                                      thickness: 0.5,
                                      height: 1,
                                    ),
                                    const SizedBox(height: 16),
                                    ...faq['answer'].split('\n\n').map<Widget>((line) {
                                      if (line.startsWith('●')) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 8),
                                              Container(
                                                width: 6,
                                                height: 6,
                                                margin: const EdgeInsets.only(top: 6),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF0068FF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  line.substring(2),
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black87,
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(width: 8),
                                              Container(
                                                width: 6,
                                                height: 6,
                                                margin: const EdgeInsets.only(top: 6),
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFF0068FF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Expanded(
                                                child: Text(
                                                  line,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Poppins',
                                                    color: Colors.black87,
                                                    height: 1.4,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    }).toList(),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
