import 'package:flutter/material.dart';
import '../screens/farmasi_screen.dart';
import '../screens/order_rajal_screen.dart';
class StokBarangScreen extends StatefulWidget {
  const StokBarangScreen({super.key});

  @override
  State<StokBarangScreen> createState() => _StokBarangScreenState();
}

class _StokBarangScreenState extends State<StokBarangScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? expandedMenu;
  String? selectedOrderType;
  int _rowsPerPage = 10;
  int _currentPage = 1;

  final Map<String, Widget> pageMap = {
    "Proses Order": const FarmasiScreen(),
    "Proses Amprah": const FarmasiScreen(),
    "Proses Order Obat": const RajalScreen(),
    "Master Barang": const FarmasiScreen(),
    "Stok Barang Farmasi": const StokBarangScreen(),
    "Penerimaan Barang": const FarmasiScreen(),
    "Pengeluaran Barang": const FarmasiScreen(),
    "Stok Opname": const FarmasiScreen(),
    "Laporan": const FarmasiScreen(),
    "Barang Produksi": const FarmasiScreen(),
  };

  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "Proses Order",
      "icon": Icons.shopping_cart,
      "color": Colors.orange,
      "children": ["Proses Amprah", "Proses Order Obat"],
    },
    {"title": "Master Barang", "icon": Icons.inventory_2, "color": Colors.teal},
    {
      "title": "Stok Barang Farmasi",
      "icon": Icons.medical_services,
      "color": Colors.purple,
    },
    {
      "title": "Penerimaan Barang",
      "icon": Icons.download,
      "color": Colors.blue,
    },
    {"title": "Pengeluaran Barang", "icon": Icons.upload, "color": Colors.red},
    {"title": "Stok Opname", "icon": Icons.fact_check, "color": Colors.brown},
    {"title": "Laporan", "icon": Icons.bar_chart, "color": Colors.deepOrange},
    {
      "title": "Barang Produksi",
      "icon": Icons.production_quantity_limits,
      "color": Colors.cyan,
    },
  ];

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
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Daftar Stok Barang',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),

        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.black87,
            ),
            onPressed: () {},
          ),
          Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu, color: Colors.black87),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                ),
          ),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.white),
              child: Center(
                child: Text(
                  'Menu Farmasi',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: menuItems.length,
                separatorBuilder:
                    (_, __) => const Divider(
                      height: 1,
                      thickness: 0.5,
                      color: Color(0xFFE0E0E0),
                    ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  bool hasChildren =
                      item.containsKey('children') && item['children'] != null;
                  bool isExpanded = expandedMenu == item['title'];

                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                selectedOrderType == item['title']
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                        trailing:
                            hasChildren
                                ? Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                )
                                : null,
                        onTap: () {
                          setState(() {
                            if (hasChildren) {
                              expandedMenu = isExpanded ? null : item['title'];
                            } else {
                              navigateToPage(item['title']);
                            }
                          });
                        },
                      ),
                      // Submenu
                      if (hasChildren && isExpanded)
                        Column(
                          children:
                              (item['children'] as List<String>).map((sub) {
                                return ListTile(
                                  contentPadding: const EdgeInsets.only(
                                    left: 48,
                                    right: 16,
                                  ),
                                  title: Text(
                                    sub,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                          selectedOrderType == sub
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedOrderType = sub;
                                    });
                                    // Navigasi ke halaman submenu
                                    navigateToPage(sub);
                                  },
                                );
                              }).toList(),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
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
          // Tabel responsif
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(
                          Colors.grey[200],
                        ),
                        columnSpacing: 12,
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
                        rows:
                            data.map((item) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(item["no"].toString())),
                                  DataCell(Text(item["kode"])),
                                  DataCell(
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        item["nama"],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  DataCell(
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        item["kelompok"],
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
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
                                      child: const Text(
                                        "Data Awal HPP dan Stok",
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                );
              },
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
          ),
        ],
      ),
    );
  }

  void navigateToPage(String pageTitle) {
    // Cek apakah halaman ada dalam map
    if (pageMap.containsKey(pageTitle)) {
      // Jika sedang di halaman yang sama, tidak perlu navigasi
      if (ModalRoute.of(context)?.settings.name == pageTitle) {
        return;
      }

      // Navigasi ke halaman baru
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => pageMap[pageTitle]!),
      );
    } else {
      // Jika halaman tidak ditemukan, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Halaman "$pageTitle" belum tersedia'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
