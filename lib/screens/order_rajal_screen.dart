import 'package:flutter/material.dart';
import 'package:inocare/screens/stok_barang.dart';
import '../screens/farmasi_screen.dart';

class RajalScreen extends StatefulWidget {
  const RajalScreen({super.key});

  @override
  State<RajalScreen> createState() => _RajalScreenState();
}

class _RajalScreenState extends State<RajalScreen> {
  String selectedTab = "transaction";
  String? selectedRuangan;
  bool isCardView = true;
  String? expandedMenu;
  String? selectedOrderType;
  
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
  final List<String> ruanganOptions = [
    "Pilih Ruangan",
    "Poli Umum",
    "Poli Gigi",
    "Poli Anak",
  ];
  final List<Map<String, dynamic>> patientData = [
    {
      'nama': 'HJ ROHANI',
      'noRM': '00729536',
      'noAntrian': 'RF1-005',
      'noAntrianAPM': null,
      'noResep': '20250820085234348360',
      'namaDPJP': 'dr. Misar Ersanto, Sp.B(K)Onk',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:52:25',
      'status': 'SELESAI',
      'statusColor': Color(0xFF2196F3), // Blue
      'nomor': 1,
      'prioritas': true,
      'keterangan': 'Pasien sudah datang',
      'isBPJS': true,
    },
    {
      'nama': 'DESY SYAFLITA',
      'noRM': '00616549',
      'noAntrian': 'GI7-012',
      'noAntrianAPM': '8055',
      'noResep': '20250820085612565520',
      'namaDPJP': 'dr. Misar Ersanto, Sp.B(K)Onk',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:47:32',
      'status': 'BUAT',
      'statusColor': Color(0xFF2196F3), // Blue
      'nomor': 2,
      'prioritas': false,
      'keterangan': 'Pasien belum datang',
      'isBPJS': true,
    },
    {
      'nama': 'SULISTIANA',
      'noRM': '00876890',
      'noAntrian': 'PU2-007',
      'noAntrianAPM': '1012',
      'noResep': '20250820084729277767',
      'namaDPJP': 'dr. Misar Ersanto, Sp.B(K)Onk',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:47:29',
      'status': 'BUAT',
      'statusColor': Color(0xFF2196F3), // Blue
      'nomor': 6,
      'prioritas': true,
      'keterangan': 'Pasien sudah datang',
      'isBPJS': true,
    },
    {
      'nama': 'BUDI SANTOSO',
      'noRM': '00543210',
      'noAntrian': 'PG3-015',
      'noAntrianAPM': null,
      'noResep': '20250820082345678901',
      'namaDPJP': 'drg. Wulan Sari, Sp.KG',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:30:15',
      'status': 'SELESAI',
      'statusColor': Color(0xFF2196F3), // Blue
      'nomor': 4,
      'prioritas': false,
      'keterangan': 'Pasien sudah datang',
      'isBPJS': false,
    },
    {
      'nama': 'RINA HANDAYANI',
      'noRM': '00987654',
      'noAntrian': 'PA1-008',
      'noAntrianAPM': null,
      'noResep': '20250820095432109876',
      'namaDPJP': 'dr. Indra Wijaya, Sp.A',
      'tanggal': '2025-08-20',
      'waktuOrder': '09:45:33',
      'status': 'BUAT',
      'statusColor': Color(0xFF2196F3), // Blue
      'nomor': 5,
      'prioritas': false,
      'keterangan': 'Pasien belum datang',
      'isBPJS': false,
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
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Daftar Order Obat Rajal',
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
            builder: (context) => IconButton(
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
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                  thickness: 0.5,
                  color: Color(0xFFE0E0E0),
                ),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  bool hasChildren = item.containsKey('children') && item['children'] != null;
                  bool isExpanded = expandedMenu == item['title'];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          item['title'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: selectedOrderType == item['title'] ? FontWeight.w600 : FontWeight.normal,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: hasChildren
                            ? Icon(
                                isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
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
                          children: (item['children'] as List<String>).map((sub) {
                            return ListTile(
                              contentPadding: const EdgeInsets.only(left: 48, right: 16),
                              title: Text(
                                sub,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: selectedOrderType == sub ? FontWeight.w600 : FontWeight.normal,
                                  color: Colors.black87,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  selectedOrderType = sub;
                                });
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
          // Header Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Breadcrumb
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: Colors.grey,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Proses Order Obat',
                          style: TextStyle(
                            color: Colors.blue.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        size: 16,
                        color: Colors.grey,
                      ),
                      Text(
                        'Rajal',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Tab Buttons
                Row(
                  children: [
                    _buildTabButton("transaction", "transaction"),
                    const SizedBox(width: 8),
                    _buildTabButton("history", "history"),
                    const SizedBox(width: 8),
                    _buildTabButton("pending", "pending transaction"),
                  ],
                ),
                const SizedBox(height: 16),
                // Filter Section
                _buildFilterSection(screenWidth),
                const SizedBox(height: 16),
                // Tombol Tambah Order
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 16),
                        SizedBox(width: 8),
                        Text('Tambah Order', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content Area
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              child: isCardView ? _buildCardView(screenWidth) : _buildTableView(),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildFilterSection(double screenWidth) {
    if (screenWidth < 600) {
      // Mobile layout
      return Column(
        children: [
          // Search field
          Container(
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Berdasarkan Nama, No RM, No Order',
                      hintStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Date and Room filter
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          '20 - 08 - 2025',
                          style: TextStyle(fontSize: 13),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.red.shade400,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedRuangan ?? 'Pilih Ruangan',
                      items: ruanganOptions.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedRuangan = val;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Search button and View Toggle
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // View Toggle
              Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue.shade600),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isCardView = true;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isCardView ? Colors.blue.shade600 : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(6),
                            bottomLeft: Radius.circular(6),
                          ),
                        ),
                        child: Icon(
                          Icons.grid_view,
                          size: 16,
                          color: isCardView ? Colors.white : Colors.blue.shade600,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isCardView = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: !isCardView ? Colors.blue.shade600 : Colors.white,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(6),
                            bottomRight: Radius.circular(6),
                          ),
                        ),
                        child: Icon(
                          Icons.table_rows,
                          size: 16,
                          color: !isCardView ? Colors.white : Colors.blue.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      // Desktop layout - same as before
      return Column(
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SizedBox(
                width: 300,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(
                          Icons.search,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Cari Berdasarkan Nama, No RM, No Order',
                            hintStyle: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 120,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '20 - 08 - 2025',
                        style: TextStyle(fontSize: 13),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.red.shade400,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 140,
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedRuangan ?? 'Pilih Ruangan',
                      items: ruanganOptions.map((e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(fontSize: 13),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedRuangan = val;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.blue.shade600,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // View Toggle
          Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isCardView = true;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isCardView ? Colors.blue.shade600 : Colors.white,
                    border: Border.all(color: Colors.blue.shade600),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.grid_view,
                        size: 16,
                        color: isCardView ? Colors.white : Colors.blue.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Card',
                        style: TextStyle(
                          fontSize: 12,
                          color: isCardView ? Colors.white : Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  setState(() {
                    isCardView = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: !isCardView ? Colors.blue.shade600 : Colors.white,
                    border: Border.all(color: Colors.blue.shade600),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.table_rows,
                        size: 16,
                        color: !isCardView ? Colors.white : Colors.blue.shade600,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Table',
                        style: TextStyle(
                          fontSize: 12,
                          color: !isCardView ? Colors.white : Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }
  Widget _buildTabButton(String key, String label) {
    bool active = selectedTab == key;
    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = key);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? Colors.blue.shade600 : Colors.white,
          border: Border.all(color: Colors.blue.shade600),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: active ? Colors.white : Colors.blue.shade600,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
  Widget _buildCardView(double screenWidth) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: patientData.length,
      itemBuilder: (context, index) {
        return _buildPatientCard(patientData[index], screenWidth);
      },
    );
  }
  Widget _buildTableView() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(
                label: Text(
                  'No',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Nama Pasien',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'No RM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'No Antrian',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'No Antrian APM',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'No Resep',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Nama DPJP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Tanggal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Waktu Order',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
            rows: patientData.map((patient) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      '${patient['nomor']}',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          patient['nama'],
                          style: const TextStyle(
                            fontSize: 11, 
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        if (patient['prioritas'] ?? false)
                          Container(
                            margin: const EdgeInsets.only(top: 2),
                            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Prioritas',
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  DataCell(
                    Text(
                      patient['noRM'],
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  DataCell(
                    Text(
                      patient['noAntrian'],
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  DataCell(
                    Text(
                      patient['noAntrianAPM'] ?? '-',
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  DataCell(
                    Text(
                      patient['noResep'],
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  DataCell(
                    Text(
                      patient['namaDPJP'],
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  DataCell(
                    Text(
                      patient['tanggal'],
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                  DataCell(
                    Text(
                      patient['waktuOrder'],
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
  void navigateToPage(String pageTitle) {
    if (pageMap.containsKey(pageTitle)) {
      if (ModalRoute.of(context)?.settings.name == pageTitle) {
        return;
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => pageMap[pageTitle]!),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Halaman "$pageTitle" belum tersedia'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
  
  // Metode untuk membuat avatar pasien dengan ukuran yang bisa diatur
  Widget _buildPatientAvatar(int patientNumber) {
    // Atur ukuran avatar di sini
    double avatarSize = 70.0; // Ubah nilai ini untuk mengatur ukuran avatar
    
    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        Icons.person,
        color: Colors.grey,
        // Atur ukuran icon proporsional dengan ukuran container
        size: avatarSize * 0.6, // 60% dari ukuran container
      ),
    );
  }
  
  Widget _buildPatientCard(Map<String, dynamic> patient, double screenWidth) {
    bool isPrioritas = patient['prioritas'] ?? false;
    bool isBPJS = patient['isBPJS'] ?? false;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar pasien dengan ukuran yang bisa diatur
            _buildPatientAvatar(patient['nomor']),
            const SizedBox(width: 16),
            // Informasi pasien
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nama pasien
                  Text(
                    patient['nama'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Informasi detail
                  Text(
                    'No. RM: ${patient['noRM']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'No. Antrian: ${patient['noAntrian']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  if (patient['noAntrianAPM'] != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'No. Antrian APM: ${patient['noAntrianAPM']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    'No. Resep: ${patient['noResep']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'DPJP: ${patient['namaDPJP']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tanggal: ${patient['tanggal']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Waktu: ${patient['waktuOrder']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  // Keterangan pasien sudah dihapus
                ],
              ),
            ),
            // Nomor antrian dan badge BPJS/Prioritas
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Badge BPJS/Prioritas di atas nomor antrian
                if (isBPJS)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isPrioritas ? Colors.orange : Colors.blue,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isPrioritas ? 'BPJS Prioritas' : 'BPJS',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                // Nomor antrian besar
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: patient['statusColor'],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Text(
                      '${patient['nomor']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
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
  }
}