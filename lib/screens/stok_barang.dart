import 'package:flutter/material.dart';

class StokBarangScreen extends StatefulWidget {
  const StokBarangScreen({super.key});

  @override
  State<StokBarangScreen> createState() => _StokBarangScreenState();
}

class _StokBarangScreenState extends State<StokBarangScreen> {
  final TextEditingController _searchController = TextEditingController();

  int _rowsPerPage = 10;
  int _currentPage = 1;

  final List<Map<String, dynamic>> data = [
    {
      "no": 1,
      "kode": "1.FR.BRG.5992",
      "nama": "Test Programmer Barang Farmasi",
      "kelompok": "BHP",
      "golongan": "BHP",
      "satuan": "BOX",
      "hpp": "Rp 10.000",
      "ppn": "0.11",
      "faktor": "0.28",
      "hargaSebelum": "Rp 14.208",
      "hargaJual": "Rp 14.208",
      "hargaUmum": "Rp 14.208",
      "stok": "7",
      "kadaluarsa": "16-05-2025",
    },
    {
      "no": 2,
      "kode": "1.AH.15.462",
      "nama": "LC DISTAL HUMERUS PLATE 05H (LEFT)",
      "kelompok": "AMHP Orthopedi Non E-Katalog",
      "golongan": "AMHP",
      "satuan": "PCS",
      "hpp": "Rp 5.378.351",
      "ppn": "0.11",
      "faktor": "0.1",
      "hargaSebelum": "Rp 6.566.966,571",
      "hargaJual": "Rp 6.566.967",
      "hargaUmum": "Rp 6.566.967",
      "stok": "200",
      "kadaluarsa": "-",
    },
    // Tambah data sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Stok Obat"),
        backgroundColor: Colors.blue,
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.update, color: Colors.white),
            label: const Text(
              "Perbaharui Harga dan Stock",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Cari",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Fungsi cari
                  },
                  child: const Icon(Icons.search),
                ),
              ],
            ),
          ),
          // Tabel
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: const [
                  DataColumn(label: Text("No")),
                  DataColumn(label: Text("Kode")),
                  DataColumn(label: Text("Nama")),
                  DataColumn(label: Text("Kelompok")),
                  DataColumn(label: Text("Golongan")),
                  DataColumn(label: Text("Satuan")),
                  DataColumn(label: Text("HPP")),
                  DataColumn(label: Text("PPN")),
                  DataColumn(label: Text("Faktor Pelayanan")),
                  DataColumn(label: Text("Harga Sebelum")),
                  DataColumn(label: Text("Harga Jual")),
                  DataColumn(label: Text("Harga Umum")),
                  DataColumn(label: Text("Jumlah Stok")),
                  DataColumn(label: Text("Tanggal Kadaluwarsa")),
                  DataColumn(label: Text("Aksi")),
                ],
                rows: data.map((item) {
                  return DataRow(cells: [
                    DataCell(Text(item["no"].toString())),
                    DataCell(Text(item["kode"])),
                    DataCell(Text(item["nama"])),
                    DataCell(Text(item["kelompok"])),
                    DataCell(Text(item["golongan"])),
                    DataCell(Text(item["satuan"])),
                    DataCell(Text(item["hpp"])),
                    DataCell(Text(item["ppn"])),
                    DataCell(Text(item["faktor"])),
                    DataCell(Text(item["hargaSebelum"])),
                    DataCell(Text(item["hargaJual"])),
                    DataCell(Text(item["hargaUmum"])),
                    DataCell(Text(item["stok"])),
                    DataCell(Text(item["kadaluarsa"])),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text("Data Awal HPP dan Stok"),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ),
          // Pagination
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Halaman $_currentPage Dari 502"),
                const SizedBox(width: 16),
                IconButton(
                  onPressed: () {
                    if (_currentPage > 1) {
                      setState(() {
                        _currentPage--;
                      });
                    }
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _currentPage++;
                    });
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
