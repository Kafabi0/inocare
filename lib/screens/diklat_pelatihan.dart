import 'package:flutter/material.dart';

class DiklatPelatihanPage extends StatelessWidget {
  const DiklatPelatihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data
    final List<Map<String, String>> kegiatan = [
      {
        "noSurat": "000.9.2/234/VII.01/II/2025ee",
        "perihal": "prakepineraan",
        "tgl": "2025-08-14",
      },
    ];

    final List<Map<String, String>> petugas = [
      {"nama": "Dr. Iskandar Muda, Sp.M"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Kegiatan"), centerTitle: true),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 800; // breakpoint responsif
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Detail Header
                Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        InfoRow(
                          label: "No. Registrasi",
                          value: "2508161224502890",
                        ),
                        InfoRow(label: "Tipe Pelatihan", value: "Kerjasama"),
                        InfoRow(
                          label: "Pihak Kerjasama",
                          value: "Universitas Indonesia",
                        ),
                        InfoRow(
                          label: "Tempat Pelatihan",
                          value: "Gedung Diklat",
                        ),
                      ],
                    ),
                  ),
                ),

                // 🔹 Judul
                Row(
                  children: const [
                    Icon(Icons.people, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      "Kegiatan Pelatihan",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // 🔹 Layout responsif
                isWide
                    ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildKegiatanCard(kegiatan)),
                        const SizedBox(width: 16),
                        Expanded(child: _buildPetugasCard(petugas)),
                      ],
                    )
                    : Column(
                      children: [
                        _buildKegiatanCard(kegiatan),
                        const SizedBox(height: 16),
                        _buildPetugasCard(petugas),
                      ],
                    ),
              ],
            ),
          );
        },
      ),
    );
  }

  // 🔹 Card Kegiatan
  // 🔹 Card Kegiatan
  static Widget _buildKegiatanCard(List<Map<String, String>> kegiatan) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildHeader("Kegiatan", onAdd: () {}, onRefresh: () {}),
          _buildSearchField(),

          // ✅ Scroll horizontal biar tabel responsif
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
              columns: const [
                DataColumn(label: Text("No")),
                DataColumn(label: Text("No. Surat")),
                DataColumn(label: Text("Perihal")),
                DataColumn(label: Text("Tgl. Pelaksanaan")),
                DataColumn(label: Text("Aksi")),
              ],
              rows:
                  kegiatan.map((item) {
                    return DataRow(
                      cells: [
                        const DataCell(Text("1")),
                        DataCell(Text(item["noSurat"]!)),
                        DataCell(Text(item["perihal"]!)),
                        DataCell(Text(item["tgl"]!)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.people,
                                  color: Colors.indigo,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Card Petugas
  static Widget _buildPetugasCard(List<Map<String, String>> petugas) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          _buildHeader("Daftar Petugas", onAdd: () {}, onRefresh: () {}),
          _buildSearchField(),

          // ✅ Scroll horizontal juga untuk tabel petugas
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
              columns: const [
                DataColumn(label: Text("No")),
                DataColumn(label: Text("Petugas")),
                DataColumn(label: Text("Aksi")),
              ],
              rows:
                  petugas.map((item) {
                    return DataRow(
                      cells: [
                        const DataCell(Text("1")),
                        DataCell(Text(item["nama"]!)),
                        DataCell(
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Hapus"),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Header Reusable
  static Widget _buildHeader(
    String title, {
    required VoidCallback onAdd,
    required VoidCallback onRefresh,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: onAdd,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("+"),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 Search Field Reusable
  static Widget _buildSearchField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: "Cari...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          isDense: true,
          contentPadding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}

// 🔹 Widget Reusable untuk header info
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 150, child: Text("$label :")),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
