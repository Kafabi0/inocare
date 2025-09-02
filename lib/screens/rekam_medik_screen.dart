import 'package:flutter/material.dart';
import '../screens/rekam_medik_detail_screen.dart';

class RekamMedisPage extends StatefulWidget {
  const RekamMedisPage({super.key});

  @override
  _RekamMedisPageState createState() => _RekamMedisPageState();
}

class _RekamMedisPageState extends State<RekamMedisPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List<Map<String, dynamic>> rekamMedisData = [
    {
      'no': 1,
      'foto': 'assets/images/pasien1.jpg',
      'noRM': '00000000',
      'namaLengkap': 'M NUR HARUN TEST',
      'jenisKelamin': 'Laki-laki',
      'tanggalLahir': '1992-06-04',
      'umur': '33 Tahun / 2 Bulan / 9 Hari',
      'noIdentitas': '3201023456540970 (KTP)',
      'noKartuBPJS': '0002456789001',
      'noTelpHP': '082145678901',
      'tglTerbitRM': '21-10-2008',
      'hasPhoto': true,
    },
    {
      'no': 2,
      'foto': null,
      'noRM': '00000001',
      'namaLengkap': 'SLAMET PRIYANTO ORI',
      'jenisKelamin': 'Laki-laki',
      'tanggalLahir': '1967-07-20',
      'umur': '72 Tahun / 9 Bulan / 18 Hari',
      'noIdentitas': '8902843487963935 (KTP)',
      'noKartuBPJS': '0002293022100',
      'noTelpHP': '',
      'tglTerbitRM': '2009-10-24',
      'hasPhoto': true,
    },
    {
      'no': 3,
      'foto': null,
      'noRM': '00000002',
      'namaLengkap': 'RITRISIA NUR PHARESTAWATI',
      'jenisKelamin': 'Perempuan',
      'tanggalLahir': '1984-07-01',
      'umur': '41 Tahun / 1 Bulan / 24 Hari',
      'noIdentitas': '4543880 (KTP)',
      'noKartuBPJS': '0002000393',
      'noTelpHP': '',
      'tglTerbitRM': '2009-10-24',
      'hasPhoto': true,
    },
    {
      'no': 4,
      'foto': null,
      'noRM': '00000003',
      'namaLengkap': 'YUSUF SYARAWANESE',
      'jenisKelamin': 'Laki-laki',
      'tanggalLahir': '1960-06-24',
      'umur': '75 Tahun / 4 Bulan / 1 Hari',
      'noIdentitas': 'tidak ada',
      'noKartuBPJS': '300002466200805',
      'noTelpHP': '08953020245',
      'tglTerbitRM': '2009-10-24',
      'hasPhoto': true,
    },
    {
      'no': 5,
      'foto': null,
      'noRM': '00000004',
      'namaLengkap': 'M ISNU',
      'jenisKelamin': 'Laki-laki',
      'tanggalLahir': '1965-05-27',
      'umur': '59 Tahun / 9 Bulan / 29 Hari',
      'noIdentitas': 'tidak ada',
      'noKartuBPJS': '08006600000',
      'noTelpHP': '',
      'tglTerbitRM': '2009-10-24',
      'hasPhoto': true,
    },
    {
      'no': 6,
      'foto': null,
      'noRM': '00000005',
      'namaLengkap': 'MEGAWANI PUSIL S SOS',
      'jenisKelamin': 'Perempuan',
      'tanggalLahir': '1950-06-06',
      'umur': '75 Tahun / 2 Bulan / 18 Hari',
      'noIdentitas': '0800514668500017',
      'noKartuBPJS': '',
      'noTelpHP': '',
      'tglTerbitRM': '2009-10-24',
      'hasPhoto': true,
    },
  ];

  List<Map<String, dynamic>> filteredData = [];

  @override
  void initState() {
    super.initState();
    filteredData = List.from(rekamMedisData);
  }

  void _filterData() {
    setState(() {
      filteredData = rekamMedisData.where((item) {
        bool matchesSearch = _searchController.text.isEmpty ||
            item['namaLengkap']
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            item['noRM'].contains(_searchController.text);
        return matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        title: Row(
          children: [
            Icon(Icons.medical_services, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'RM Pasien',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Info Card
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.teal[100]!),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.people, color: Colors.white),
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '6',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                    Text('Total RM',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),

          // Search
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari No. RM / Nama Pasien',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) => _filterData(),
                  ),
                ),
                SizedBox(width: 12),
                Container(
                  width: 140,
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Tanggal lahir',
                      suffixIcon: Icon(Icons.calendar_today, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    readOnly: true,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          // DataTable with scroll both axis
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: Offset(0, 2))
                ],
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 32,
                    horizontalMargin: 24,
                    dataRowHeight: 140,
                    headingRowHeight: 56,
                    columns: [
                      DataColumn(label: Center(child: Text('No'))),
                      DataColumn(label: Center(child: Text('Foto'))),
                      DataColumn(label: Center(child: Text('No. RM'))),
                      DataColumn(label: Center(child: Text('Nama Lengkap'))),
                      DataColumn(label: Center(child: Text('Jenis Kelamin'))),
                      DataColumn(label: Center(child: Text('Tanggal Lahir'))),
                      DataColumn(label: Center(child: Text('No. Identitas'))),
                      DataColumn(label: Center(child: Text('No. Kartu BPJS'))),
                      DataColumn(label: Center(child: Text('No. Telp/HP'))),
                      DataColumn(label: Center(child: Text('Tgl. Terbit RM'))),
                      DataColumn(label: Center(child: Text('Aksi'))),
                    ],
                    rows: filteredData.map((item) {
                      return DataRow(cells: [
                        DataCell(Center(child: Text(item['no'].toString()))),
                        DataCell(
                          Center(
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey[400]!),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: item['foto'] != null
                                  ? Image.asset(
                                      item['foto'],
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(Icons.person,
                                      size: 50, color: Colors.grey[400]),
                            ),
                          ),
                        ),
                        DataCell(Center(
                          child: Text(item['noRM'],
                              style: TextStyle(
                                  color: Colors.blue[600],
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center),
                        )),
                        DataCell(Center(
                          child: Container(
                              width: 180,
                              child: Text(item['namaLengkap'],
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center)),
                        )),
                        DataCell(Center(
                            child: Text(item['jenisKelamin'],
                                textAlign: TextAlign.center))),
                        DataCell(Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(item['tanggalLahir'],
                                  textAlign: TextAlign.center),
                              Text(item['umur'],
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.blue[600]),
                                  textAlign: TextAlign.center),
                            ],
                          ),
                        )),
                        DataCell(Center(
                          child: Container(
                              width: 140,
                              child: Text(item['noIdentitas'],
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center)),
                        )),
                        DataCell(Center(
                          child: Container(
                              width: 120,
                              child: Text(item['noKartuBPJS'],
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.center)),
                        )),
                        DataCell(Center(
                          child: Container(
                              width: 120,
                              child: Text(item['noTelpHP'],
                                  textAlign: TextAlign.center)),
                        )),
                        DataCell(Center(
                            child: Text(item['tglTerbitRM'],
                                textAlign: TextAlign.center))),
                        DataCell(
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RekamDetailPage(pasienData: item)),
                                );
                              },
                              child: Text('Detail'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue[600],
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8)),
                            ),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
