import 'package:flutter/material.dart';

class ManajemenBed extends StatefulWidget {
  const ManajemenBed({super.key});

  @override
  State<ManajemenBed> createState() => _ManajemenBedState();
}

class _ManajemenBedState extends State<ManajemenBed> {
  final List<Map<String, dynamic>> _allBeds = List.generate(
    40,
    (i) => {
      "no": i + 1,
      "gedung": "Instalasi Rawat Inap Bedah, Mata, THT",
      "ruangan":
          i % 3 == 0 ? "Ruang Bedah Lt 1" : "Ruang Bedah Lt 2 (Mata, THT)",
      "nama": ["I", "II", "III"][i % 3],
      "kategori": "Dewasa",
      "kelasKRIS": "Rawat Jalan Eksekutif - Pemeriksaan/Konsultasi",
      "kelasNonKRIS": "Biaya Rawat Inap - Konsultasi Dr. Spesialis",
      "gender": "Netral (dengan catatan)",
      "status":
          i == 4 ? "Terisi" : "Tersedia", // beberapa bed terisi untuk demo
    },
  );

  // Filter & search
  String _searchQuery = "";
  String? _selectedGedung;
  String? _selectedRuangan;

  // Pagination
  int _rowsPerPage = 5;
  int _currentPage = 0;

  // Fungsi helper untuk detail info
  Widget _buildInfo(
    String label,
    String value, {
    bool highlight = false,
    bool boldAll = false,
  }) {
    if (boldAll) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          "$label : $value",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14, color: Colors.black),
          children: [
            TextSpan(
              text: "$label : ",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: highlight ? FontWeight.bold : FontWeight.normal,
                color: highlight ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk mendapatkan warna status
  Color _getStatusColor(String status) {
    switch (status) {
      case "Terisi":
        return Colors.red;
      case "Rusak":
        return Colors.orange;
      case "Dibersihkan":
        return Colors.yellow;
      default:
        return Colors.green;
    }
  }

  // Fungsi untuk buka detail dialog dengan grid semua bed
  void _showDetailDialog(Map<String, dynamic> selectedBed) {
    String selectedStatus = selectedBed["status"];
    int selectedBedNo = selectedBed["no"];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            "${selectedBed["gedung"]} => ${selectedBed["ruangan"]}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Reset semua bed
                                setStateDialog(() {
                                  for (var bed in _allBeds) {
                                    bed["status"] = "Tersedia";
                                  }
                                });
                                setState(() {}); // Update main state
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text("Reset min Bed"),
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    Expanded(
                      flex: 3,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, 
                              childAspectRatio: 0.8,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                            ),
                        itemCount: _allBeds.length,
                        itemBuilder: (context, index) {
                          final bed = _allBeds[index];
                          final isSelected = bed["no"] == selectedBedNo;

                          return GestureDetector(
                            onTap: () {
                              setStateDialog(() {
                                selectedBedNo = bed["no"];
                                selectedStatus = bed["status"];
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? Colors.blue
                                          : _getStatusColor(bed["status"]),
                                  width: isSelected ? 3 : 2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    isSelected
                                        ? Colors.blue.shade50
                                        : Colors.white,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.bed,
                                    size: 24,
                                    color:
                                        bed["status"] == "Terisi"
                                            ? Colors.red
                                            : Colors.grey.shade600,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Bed ${bed["no"]}",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    bed["status"] == "Terisi"
                                        ? "Terisi"
                                        : "Siap Digunakan/Kosong",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          bed["status"] == "Terisi"
                                              ? Colors.red
                                              : Colors.green,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: const Text(
                                          "Status",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: const Text(
                                          "Riwayat",
                                          style: TextStyle(fontSize: 8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 16),
                    const Divider(),
                    const SizedBox(height: 8),

                    // Form update status untuk bed yang dipilih
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Judul di atas
                          Text(
                            "Update Status Bed $selectedBedNo",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Row untuk Dropdown + Tombol
                          Row(
                            children: [
                              // Dropdown melebar
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: selectedStatus,
                                  items:
                                      [
                                        "Tersedia",
                                        "Terisi",
                                        "Rusak",
                                        "Dibersihkan",
                                      ].map((status) {
                                        return DropdownMenuItem(
                                          value: status,
                                          child: Text(status),
                                        );
                                      }).toList(),
                                  onChanged: (value) {
                                    if (value != null) {
                                      setStateDialog(() {
                                        selectedStatus = value;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),

                              // Tombol update di kanan
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    final bedToUpdate = _allBeds.firstWhere(
                                      (bed) => bed["no"] == selectedBedNo,
                                    );
                                    bedToUpdate["status"] = selectedStatus;
                                  });
                                  Navigator.pop(context);
                                },
                                child: const Text("Update"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Apply filter
    List<Map<String, dynamic>> filteredBeds =
        _allBeds.where((bed) {
          final matchSearch = bed["nama"].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
          final matchGedung =
              _selectedGedung == null || bed["gedung"] == _selectedGedung;
          final matchRuangan =
              _selectedRuangan == null || bed["ruangan"] == _selectedRuangan;
          return matchSearch && matchGedung && matchRuangan;
        }).toList();

    // 2. Pagination
    final totalPages = (filteredBeds.length / _rowsPerPage).ceil();
    if (_currentPage >= totalPages && totalPages > 0) {
      _currentPage = totalPages - 1; // reset jika page > total
    }
    final startIndex = _currentPage * _rowsPerPage;
    final endIndex =
        (_currentPage + 1) * _rowsPerPage > filteredBeds.length
            ? filteredBeds.length
            : (_currentPage + 1) * _rowsPerPage;
    final pageItems = filteredBeds.sublist(startIndex, endIndex);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Manajemen Bed"),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search + Filter
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width:
                          constraints.maxWidth < 600
                              ? constraints.maxWidth
                              : 250,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search by nama kamar",
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          isDense: true,
                        ),
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val;
                            _currentPage = 0;
                          });
                        },
                      ),
                    ),
                    DropdownButton<String>(
                      hint: const Text("-- Pilih Gedung --"),
                      value: _selectedGedung,
                      items: const [
                        DropdownMenuItem(
                          value: "Instalasi Rawat Inap Bedah, Mata, THT",
                          child: Text("Instalasi Rawat Inap Bedah, Mata, THT"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedGedung = value;
                          _currentPage = 0;
                        });
                      },
                    ),
                    DropdownButton<String>(
                      hint: const Text("-- Pilih Ruangan --"),
                      value: _selectedRuangan,
                      items: const [
                        DropdownMenuItem(
                          value: "Ruang Bedah Lt 1",
                          child: Text("Ruang Bedah Lt 1"),
                        ),
                        DropdownMenuItem(
                          value: "Ruang Bedah Lt 2 (Mata, THT)",
                          child: Text("Ruang Bedah Lt 2 (Mata, THT)"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedRuangan = value;
                          _currentPage = 0;
                        });
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedGedung = null;
                          _selectedRuangan = null;
                          _searchQuery = "";
                          _currentPage = 0;
                        });
                      },
                      child: const Text("Reset Filters"),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tabel data
                Table(
                  border: TableBorder.all(color: Colors.grey.shade300),
                  columnWidths: const {
                    0: FixedColumnWidth(40),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(2),
                    4: FixedColumnWidth(80),
                  },
                  children: [
                    const TableRow(
                      decoration: BoxDecoration(color: Color(0xFFEAF3FF)),
                      children: [
                        Padding(padding: EdgeInsets.all(8), child: Text("No")),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Gedung"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Ruangan"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Kamar"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text("Aksi"),
                        ),
                      ],
                    ),
                    ...pageItems.map(
                      (bed) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(bed["no"].toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(bed["gedung"]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(bed["ruangan"]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildInfo(
                                    "Nama",
                                    bed["nama"],
                                    highlight: true,
                                  ),
                                  _buildInfo("Kategori", bed["kategori"]),
                                  _buildInfo(
                                    "Kelas KRIS",
                                    bed["kelasKRIS"],
                                    boldAll: true,
                                  ),
                                  _buildInfo(
                                    "Kelas NON-KRIS",
                                    bed["kelasNonKRIS"],
                                  ),
                                  _buildInfo("Gender", bed["gender"]),
                                  // _buildInfo("Status", bed["status"],
                                  //     highlight: true),
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _showDetailDialog(bed);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text("Detail"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Pagination + Dropdown rows per page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed:
                          _currentPage > 0
                              ? () {
                                setState(() {
                                  _currentPage--;
                                });
                              }
                              : null,
                    ),
                    Text("Page ${_currentPage + 1} of $totalPages"),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed:
                          _currentPage < totalPages - 1
                              ? () {
                                setState(() {
                                  _currentPage++;
                                });
                              }
                              : null,
                    ),
                    const SizedBox(width: 20),
                    const Text("Rows per page: "),
                    DropdownButton<int>(
                      value: _rowsPerPage,
                      items: const [
                        DropdownMenuItem(value: 5, child: Text("5")),
                        DropdownMenuItem(value: 10, child: Text("10")),
                        DropdownMenuItem(value: 20, child: Text("20")),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _rowsPerPage = value;
                            _currentPage = 0;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
