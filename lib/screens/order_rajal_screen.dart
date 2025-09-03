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
    // Data pasien sama seperti sebelumnya
    {
      'nama': 'HJ ROHANI',
      'noRM': '00729536',
      'noAntrian': 'RF1-005',
      'noResep': '20250820085234348360',
      'namaDPJP': 'dr. Misar Ersanto, Sp.B(K)Onk',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:52:25',
      'status': 'SELESAI',
      'statusColor': Colors.blue,
      'nomor': 1,
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
      'statusColor': Colors.blue,
      'nomor': 2,
    },
    // Tambahkan data lainnya sesuai kode sebelumnya...
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1, 
        // title: const Text(
        //   'Daftar Order
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

                // Filter Section menggunakan Wrap agar responsive
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    SizedBox(
                      width: screenWidth < 600 ? screenWidth : 300,
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
                                  hintText:
                                      'Cari Berdasarkan Nama, No RM, No Order',
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
                    ),
                    SizedBox(
                      width: screenWidth < 600 ? screenWidth / 2 - 16 : 120,
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
                              '20-08-2025',
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
                      width: screenWidth < 600 ? screenWidth / 2 - 16 : 140,
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
                            items:
                                ruanganOptions.map((e) {
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
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.add, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'Tambah Order',
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ],
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
                          color:
                              isCardView ? Colors.blue.shade600 : Colors.white,
                          border: Border.all(color: Colors.blue.shade600),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.grid_view,
                              size: 16,
                              color:
                                  isCardView
                                      ? Colors.white
                                      : Colors.blue.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Card',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    isCardView
                                        ? Colors.white
                                        : Colors.blue.shade600,
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
                          color:
                              !isCardView ? Colors.blue.shade600 : Colors.white,
                          border: Border.all(color: Colors.blue.shade600),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.table_rows,
                              size: 16,
                              color:
                                  !isCardView
                                      ? Colors.white
                                      : Colors.blue.shade600,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Table',
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    !isCardView
                                        ? Colors.white
                                        : Colors.blue.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Content Area
          Expanded(
            child: Container(
              color: Colors.grey.shade50,
              child:
                  isCardView ? _buildCardView(screenWidth) : _buildTableView(),
            ),
          ),
        ],
      ),
    );
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
    int crossAxisCount = 1;
    if (screenWidth >= 1200)
      crossAxisCount = 5;
    else if (screenWidth >= 992)
      crossAxisCount = 4;
    else if (screenWidth >= 768)
      crossAxisCount = 3;
    else if (screenWidth >= 576)
      crossAxisCount = 2;

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: patientData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        return _buildPatientCard(patientData[index]);
      },
    );
  }

  Widget _buildTableView() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
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
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(0.5),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1.5),
              3: FlexColumnWidth(1.5),
              4: FlexColumnWidth(1.5),
              5: FlexColumnWidth(2),
              6: FlexColumnWidth(1),
              7: FlexColumnWidth(1),
              8: FlexColumnWidth(1),
            },
            children: [
              // Header
              TableRow(
                decoration: BoxDecoration(color: Colors.grey.shade50),
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'No',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Nama Pasien',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'No RM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'No Antrian',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'No Resep',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Nama DPJP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Tanggal',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Waktu Order',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Status',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              ...patientData.map((patient) {
                return TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '${patient['nomor']}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        patient['nama'],
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        patient['noRM'],
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        patient['noAntrian'],
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        patient['noResep'],
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        patient['namaDPJP'],
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        patient['tanggal'],
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        patient['waktuOrder'],
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: patient['statusColor'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          patient['status'],
                          style: TextStyle(
                            fontSize: 10,
                            color: patient['statusColor'],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
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

  Widget _buildPatientCard(Map<String, dynamic> patient) {
    return Container(
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
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: patient['statusColor'],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              patient['status'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient['nama'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'No RM : ${patient['noRM']}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'No Antrian : ${patient['noAntrian']}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  if (patient['noAntrianAPM'] != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'No Antrian APM ${patient['noAntrianAPM']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                  const SizedBox(height: 2),
                  Text(
                    'No Resep : ${patient['noResep']}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Nama DPJP : ${patient['namaDPJP']}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Tanggal : ${patient['tanggal']}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Waktu Order : ${patient['waktuOrder']}',
                    style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                  ),
                  const Spacer(),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        '${patient['nomor']}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
