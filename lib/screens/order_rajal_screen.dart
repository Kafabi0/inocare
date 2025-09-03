import 'package:flutter/material.dart';

class RajalScreen extends StatefulWidget {
  const RajalScreen({super.key});

  @override
  State<RajalScreen> createState() => _RajalScreenState();
}

class _RajalScreenState extends State<RajalScreen> {
  String selectedTab = "transaction";
  String? selectedRuangan;
  bool isCardView = true;
  final List<String> ruanganOptions = ["Pilih Ruangan", "Poli Umum", "Poli Gigi", "Poli Anak"];

  final List<Map<String, dynamic>> patientData = [
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
    {
      'nama': 'KELIN OWAIS',
      'noRM': '30031518',
      'noAntrian': 'O2B-002',
      'noResep': '20250820085534588978',
      'namaDPJP': 'dr. IRMI CITIRA SIMAH',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:43:10',
      'status': 'SELESAI',
      'statusColor': Colors.blue,
      'nomor': 3,
    },
    {
      'nama': 'MAHYUDIN',
      'noRM': '30040979',
      'noAntrian': 'KBG-006',
      'noAntrianAPM': '0050',
      'noResep': '20250820085473000998?',
      'namaDPJP': 'Pakar Saroph',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:47:32',
      'status': 'BUAT',
      'statusColor': Colors.blue,
      'nomor': 4,
    },
    {
      'nama': 'MURSANAH',
      'noRM': '30637425',
      'noAntrian': 'BY2-003',
      'noResep': '20250820085434405906',
      'namaDPJP': 'dr. Misar Ersanto, Sp.B(K)Onk',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:44:01',
      'status': 'Prioritas',
      'statusColor': Colors.orange,
      'nomor': 5,
    },
    {
      'nama': 'SULISTIANA',
      'noRM': '30676920',
      'noAntrian': 'GI7-037',
      'noAntrianAPM': '012',
      'noResep': '20250820086722877757',
      'namaDPJP': 'dr. Misar Ersanto, Sp.B(K)Onk',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:47:28',
      'status': 'BUAT',
      'statusColor': Colors.blue,
      'nomor': 6,
    },
    {
      'nama': 'MUHAMMAD AGUNG LESTARI',
      'noRM': '10502404',
      'noAntrian': 'GI5-009',
      'noAntrianAPM': '1034',
      'noResep': '20250820085376773891',
      'namaDPJP': 'Pakar Sargoh',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:31:56',
      'status': 'Tolak',
      'statusColor': Colors.red,
      'nomor': 7,
    },
    {
      'nama': 'DESI PUSPITA, SE',
      'noRM': '10681020',
      'noAntrian': 'SAR-002',
      'noResep': '20250820085530258505',
      'namaDPJP': 'Pakar Sargoh Piang',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:52:30',
      'status': 'SELESAI',
      'statusColor': Colors.blue,
      'nomor': 8,
    },
    {
      'nama': 'ANIK SUPARTI NINGSIH',
      'noRM': '00316570',
      'noAntrian': 'GI7-032',
      'noAntrianAPM': 'U301',
      'noResep': '20250820085542539920',
      'namaDPJP': 'dr. Misar Ersanto, Sp.B(K)Onk',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:59:42',
      'status': 'Belum',
      'statusColor': Colors.blue,
      'nomor': 9,
    },
    {
      'nama': 'SUDIRMAN',
      'noRM': '30542693',
      'noAntrian': 'GO5-008',
      'noAntrianAPM': 'U001',
      'noResep': '20250820085458475209',
      'namaDPJP': 'Pakar Sargoh',
      'tanggal': '2025-08-20',
      'waktuOrder': '08:59:42',
      'status': 'Belum',
      'statusColor': Colors.blue,
      'nomor': 10,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
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
            icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
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
                        child: Text('Home',
                            style: TextStyle(
                                color: Colors.blue.shade600, fontSize: 12)),
                      ),
                      const Icon(Icons.chevron_right,
                          size: 16, color: Colors.grey),
                      InkWell(
                        onTap: () {},
                        child: Text('Proses Order Obat',
                            style: TextStyle(
                                color: Colors.blue.shade600, fontSize: 12)),
                      ),
                      const Icon(Icons.chevron_right,
                          size: 16, color: Colors.grey),
                      Text('Rajal',
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 12)),
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
                Row(
                  children: [
                    // Search Field
                    Expanded(
                      flex: 3,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Icon(Icons.search, color: Colors.grey, size: 20),
                            ),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Cari Berdasarkan Nama, No RM, No Order',
                                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Date Picker
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade600),
                          const SizedBox(width: 8),
                          const Text('20-08-2025', style: TextStyle(fontSize: 13)),
                          const SizedBox(width: 8),
                          Icon(Icons.close, size: 16, color: Colors.red.shade400),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Room Dropdown
                    Container(
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
                              child: Text(e, style: const TextStyle(fontSize: 13)),
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
                    const SizedBox(width: 8),

                    // Search Button
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search, color: Colors.white, size: 20),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Add Button
                    Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade600,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.add, color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          const Text('Tambah Order', 
                            style: TextStyle(color: Colors.white, fontSize: 13)),
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isCardView ? Colors.blue.shade600 : Colors.white,
                          border: Border.all(color: Colors.blue.shade600),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.grid_view, 
                              size: 16, 
                              color: isCardView ? Colors.white : Colors.blue.shade600),
                            const SizedBox(width: 4),
                            Text('Card', 
                              style: TextStyle(
                                fontSize: 12,
                                color: isCardView ? Colors.white : Colors.blue.shade600)),
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
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: !isCardView ? Colors.blue.shade600 : Colors.white,
                          border: Border.all(color: Colors.blue.shade600),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.table_rows, 
                              size: 16, 
                              color: !isCardView ? Colors.white : Colors.blue.shade600),
                            const SizedBox(width: 4),
                            Text('Table', 
                              style: TextStyle(
                                fontSize: 12,
                                color: !isCardView ? Colors.white : Colors.blue.shade600)),
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
              child: isCardView ? _buildCardView() : _buildTableView(),
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

  Widget _buildCardView() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: patientData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
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
                  child: Text('No', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Nama Pasien', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No RM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No Antrian', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('No Resep', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Nama DPJP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Tanggal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Waktu Order', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            // Data rows
            ...patientData.map((patient) {
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text('${patient['nomor']}', style: const TextStyle(fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(patient['nama'], style: const TextStyle(fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(patient['noRM'], style: const TextStyle(fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(patient['noAntrian'], style: const TextStyle(fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(patient['noResep'], style: const TextStyle(fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(patient['namaDPJP'], style: const TextStyle(fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(patient['tanggal'], style: const TextStyle(fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(patient['waktuOrder'], style: const TextStyle(fontSize: 11)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
    );
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
          // Status Badge
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

          // Patient Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient Name
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

                  // No RM
                  Text(
                    'No RM : ${patient['noRM']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // No Antrian
                  Text(
                    'No Antrian : ${patient['noAntrian']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // No Antrian APM (if available)
                  if (patient['noAntrianAPM'] != null) ...[
                    Text(
                      'No Antrian APM ${patient['noAntrianAPM']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],

                  // No Resep
                  Text(
                    'No Resep : ${patient['noResep']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),

                  // Nama DPJP
                  Text(
                    'Nama DPJP : ${patient['namaDPJP']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),

                  // Tanggal
                  Text(
                    'Tanggal : ${patient['tanggal']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 2),

                  // Waktu Order
                  Text(
                    'Waktu Order : ${patient['waktuOrder']}',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),

                  const Spacer(),

                  // Number Badge
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