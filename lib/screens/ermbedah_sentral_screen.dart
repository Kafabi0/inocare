import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ErmBedahSentralPage extends StatefulWidget {
  const ErmBedahSentralPage({super.key});

  @override
  State<ErmBedahSentralPage> createState() => _ErmBedahSentralPageState();
}

class _ErmBedahSentralPageState extends State<ErmBedahSentralPage> {
  // Tab selection
  String selectedTab = "Rawat Inap";
  
  // Search controller
  TextEditingController searchController = TextEditingController(text: "");
  
  // Date filter
  DateTime? startDate;
  DateTime? endDate;
  
  // Room filter
  String selectedRoom = "Semua Ruangan";
  
  // Pagination state
  int currentPage = 1;
  int itemsPerPage = 10;
  
  // Statistics data
  final Map<String, int> statistics = {
    "Pasien Selesai": 181,
    "Proses": 484,
    "Baru": 32,
    "Batal": 15,
    "Total": 712,
  };
  
  final List<Map<String, dynamic>> patients = [
    // Data untuk tab Rawat Inap
    {
      "id": "280725020030004105081",
      "name": "M NUR HARUN",
      "reg": "00040000",
      "dob": "1992-06-04",
      "age": 33,
      "queue": 1,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-28",
      "registrationTime": "14:15:21",
      "diagnosis": "Penyakit Dalam Non Infeksius",
      "ccp1": "CCP1",
      "room": "Lab",
      "bed": "Bed 1",
      "category": "Rawat Inap",
      "completedMenus": ["CPPT", "Lab"],
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105082",
      "name": "ABDUL GAFAR",
      "reg": "00040006",
      "dob": "1963-11-22",
      "age": 61,
      "queue": 2,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-28",
      "registrationTime": "10:30:45",
      "diagnosis": "Gastritis Akut",
      "ccp1": "CCP1",
      "room": "Konsul",
      "bed": "Bed 2",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105083",
      "name": "Budi Santoso",
      "reg": "00040007",
      "dob": "1980-08-08",
      "age": 45,
      "queue": 3,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-07-27",
      "registrationTime": "09:15:22",
      "diagnosis": "Tukak Lambung",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 3",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105084",
      "name": "SEBASTIAN SEWA",
      "reg": "00040008",
      "dob": "1965-02-25",
      "age": 59,
      "queue": 4,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-26",
      "registrationTime": "13:45:10",
      "diagnosis": "Hernia Inguinalis",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 4",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105085",
      "name": "dimas pratama",
      "reg": "00040009",
      "dob": "1990-10-10",
      "age": 35,
      "queue": 5,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-25",
      "registrationTime": "11:20:33",
      "diagnosis": "Apendisitis Akut",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 5",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    // Tambahan data Rawat Inap
    {
      "id": "280725020030004105086",
      "name": "SITI RAHMAH",
      "reg": "00040010",
      "dob": "1975-03-15",
      "age": 50,
      "queue": 6,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-24",
      "registrationTime": "08:30:45",
      "diagnosis": "Kolesistitis Akut",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 6",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105087",
      "name": "AHMAD YANI",
      "reg": "00040011",
      "dob": "1982-07-22",
      "age": 43,
      "queue": 7,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-23",
      "registrationTime": "10:15:30",
      "diagnosis": "Tumor Hati",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "Bed 7",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105088",
      "name": "DEWI LESTARI",
      "reg": "00040012",
      "dob": "1978-11-05",
      "age": 47,
      "queue": 8,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-22",
      "registrationTime": "09:45:20",
      "diagnosis": "Sirosis Hati",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 8",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105089",
      "name": "BAMBANG SUDIYONO",
      "reg": "00040013",
      "dob": "1985-04-18",
      "age": 40,
      "queue": 9,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-21",
      "registrationTime": "11:30:15",
      "diagnosis": "Kanker Usus Besar",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "Bed 9",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105090",
      "name": "RINA WULANDARI",
      "reg": "00040014",
      "dob": "1970-09-30",
      "age": 55,
      "queue": 10,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-07-20",
      "registrationTime": "13:20:10",
      "diagnosis": "Gagal Ginjal Kronis",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 10",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105091",
      "name": "AGUS WIJAYA",
      "reg": "00040015",
      "dob": "1988-12-25",
      "age": 37,
      "queue": 11,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-19",
      "registrationTime": "14:45:30",
      "diagnosis": "Hernia Umbilikalis",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 11",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105092",
      "name": "SRI RAHAYU",
      "reg": "00040016",
      "dob": "1973-06-14",
      "age": 52,
      "queue": 12,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-18",
      "registrationTime": "10:30:45",
      "diagnosis": "Pankreatitis Akut",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "Bed 12",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    
    // Data untuk tab Rawat Jalan
    {
      "id": "280725020030004105093",
      "name": "AHMAD FAUZI",
      "reg": "00040017",
      "dob": "1985-03-15",
      "age": 40,
      "queue": 1,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-28",
      "registrationTime": "08:30:45",
      "diagnosis": "Maag Akut",
      "ccp1": "CCP1",
      "room": "Poliklinik",
      "bed": "-",
      "category": "Rawat Jalan",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105094",
      "name": "SITI NURHALIZAH",
      "reg": "00040018",
      "dob": "1990-07-22",
      "age": 35,
      "queue": 2,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-27",
      "registrationTime": "10:15:30",
      "diagnosis": "Dispepsia",
      "ccp1": "CCP1",
      "room": "Poliklinik",
      "bed": "-",
      "category": "Rawat Jalan",
      "action": "Lihat Detail",
    },
    // Tambahan data Rawat Jalan
    {
      "id": "280725020030004105095",
      "name": "BUDI SUSANTO",
      "reg": "00040019",
      "dob": "1978-05-10",
      "age": 47,
      "queue": 3,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-26",
      "registrationTime": "09:20:15",
      "diagnosis": "Gastritis Kronis",
      "ccp1": "CCP1",
      "room": "Poliklinik",
      "bed": "-",
      "category": "Rawat Jalan",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105096",
      "name": "INDAH PERMATASARI",
      "reg": "00040020",
      "dob": "1983-08-15",
      "age": 42,
      "queue": 4,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-25",
      "registrationTime": "11:45:30",
      "diagnosis": "Refluks Esofagitis",
      "ccp1": "CCP1",
      "room": "Poliklinik",
      "bed": "-",
      "category": "Rawat Jalan",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105097",
      "name": "RUDI PRASETYO",
      "reg": "00040021",
      "dob": "1975-11-20",
      "age": 50,
      "queue": 5,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-07-24",
      "registrationTime": "08:10:45",
      "diagnosis": "Tukak Duodenum",
      "ccp1": "CCP1",
      "room": "Poliklinik",
      "bed": "-",
      "category": "Rawat Jalan",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105098",
      "name": "DEWI SARTIKA",
      "reg": "00040022",
      "dob": "1980-02-28",
      "age": 45,
      "queue": 6,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-23",
      "registrationTime": "10:30:20",
      "diagnosis": "Gastroenteritis",
      "ccp1": "CCP1",
      "room": "Poliklinik",
      "bed": "-",
      "category": "Rawat Jalan",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105099",
      "name": "AGUS SALIM",
      "reg": "00040023",
      "dob": "1972-09-15",
      "age": 53,
      "queue": 7,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-22",
      "registrationTime": "13:15:10",
      "diagnosis": "Sindrom Irritable Bowel",
      "ccp1": "CCP1",
      "room": "Poliklinik",
      "bed": "-",
      "category": "Rawat Jalan",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105100",
      "name": "SRI REJEKI",
      "reg": "00040024",
      "dob": "1987-04-10",
      "age": 38,
      "queue": 8,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-21",
      "registrationTime": "09:45:35",
      "diagnosis": "Divertikulitis",
      "ccp1": "CCP1",
      "room": "Poliklinik",
      "bed": "-",
      "category": "Rawat Jalan",
      "action": "Lihat Detail",
    },
    
    // Data untuk tab Unit Penunjang
    {
      "id": "280725020030004105101",
      "name": "RUDI HANDOKO",
      "reg": "00040025",
      "dob": "1978-11-05",
      "age": 47,
      "queue": 1,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-28",
      "registrationTime": "09:45:20",
      "diagnosis": "Kolesistitis Akut",
      "ccp1": "CCP1",
      "room": "Lab",
      "bed": "-",
      "category": "Unit Penunjang",
      "action": "Lihat Detail",
    },
    // Tambahan data Unit Penunjang
    {
      "id": "280725020030004105102",
      "name": "SUSILO BAMBANG",
      "reg": "00040026",
      "dob": "1982-03-18",
      "age": 43,
      "queue": 2,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-27",
      "registrationTime": "11:20:15",
      "diagnosis": "Hepatitis Akut",
      "ccp1": "CCP1",
      "room": "Lab",
      "bed": "-",
      "category": "Unit Penunjang",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105103",
      "name": "DEWI LESTARI",
      "reg": "00040027",
      "dob": "1975-07-25",
      "age": 50,
      "queue": 3,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-07-26",
      "registrationTime": "08:35:40",
      "diagnosis": "Pankreatitis Kronis",
      "ccp1": "CCP1",
      "room": "Lab",
      "bed": "-",
      "category": "Unit Penunjang",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105104",
      "name": "BUDI SANTOSO",
      "reg": "00040028",
      "dob": "1980-12-10",
      "age": 45,
      "queue": 4,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-25",
      "registrationTime": "10:15:25",
      "diagnosis": "Sirosis Hati",
      "ccp1": "CCP1",
      "room": "Lab",
      "bed": "-",
      "category": "Unit Penunjang",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105105",
      "name": "SITI RAHMAH",
      "reg": "00040029",
      "dob": "1973-05-20",
      "age": 52,
      "queue": 5,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-24",
      "registrationTime": "13:40:30",
      "diagnosis": "Tumor Hati",
      "ccp1": "CCP1",
      "room": "Lab",
      "bed": "-",
      "category": "Unit Penunjang",
      "action": "Lihat Detail",
    },
    
    // Data untuk tab Konsul
    {
      "id": "280725020030004105106",
      "name": "DEWI SARTIKA",
      "reg": "00040030",
      "dob": "1982-04-18",
      "age": 43,
      "queue": 1,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-28",
      "registrationTime": "11:30:15",
      "diagnosis": "Gagal Ginjal Kronis",
      "ccp1": "CCP1",
      "room": "Konsul",
      "bed": "-",
      "category": "Konsul",
      "action": "Lihat Detail",
    },
    // Tambahan data Konsul
    {
      "id": "280725020030004105107",
      "name": "AHMAD DAHLAN",
      "reg": "00040031",
      "dob": "1970-05-20",
      "age": 55,
      "queue": 2,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-27",
      "registrationTime": "09:15:21",
      "diagnosis": "Kolesistektomi",
      "ccp1": "CCP1",
      "room": "Konsul",
      "bed": "-",
      "category": "Konsul",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105108",
      "name": "SUSILO BAMBANG",
      "reg": "00040032",
      "dob": "1965-11-12",
      "age": 60,
      "queue": 3,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-26",
      "registrationTime": "10:30:45",
      "diagnosis": "Apendiktomi",
      "ccp1": "CCP1",
      "room": "Konsul",
      "bed": "-",
      "category": "Konsul",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105109",
      "name": "RINA WATI",
      "reg": "00040033",
      "dob": "1980-03-08",
      "age": 45,
      "queue": 4,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-07-25",
      "registrationTime": "09:15:22",
      "diagnosis": "Herniorafi",
      "ccp1": "CCP1",
      "room": "Konsul",
      "bed": "-",
      "category": "Konsul",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105110",
      "name": "JOKO SANTOSO",
      "reg": "00040034",
      "dob": "1975-07-25",
      "age": 50,
      "queue": 5,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-24",
      "registrationTime": "13:45:10",
      "diagnosis": "Gastrektomi",
      "ccp1": "CCP1",
      "room": "Konsul",
      "bed": "-",
      "category": "Konsul",
      "action": "Lihat Detail",
    },
    
    // Data untuk tab Rawat Bersama
    {
      "id": "280725020030004105111",
      "name": "AGUS SALIM",
      "reg": "00040035",
      "dob": "1975-09-30",
      "age": 50,
      "queue": 1,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-07-28",
      "registrationTime": "13:20:10",
      "diagnosis": "Sirosis Hati",
      "ccp1": "CCP1",
      "room": "Rawat Bersama",
      "bed": "-",
      "category": "Rawat Bersama",
      "action": "Lihat Detail",
    },
    // Tambahan data Rawat Bersama
    {
      "id": "280725020030004105112",
      "name": "INDAH PERMATASARI",
      "reg": "00040036",
      "dob": "1985-10-10",
      "age": 40,
      "queue": 2,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-27",
      "registrationTime": "11:20:33",
      "diagnosis": "Kolesistektomi",
      "ccp1": "CCP1",
      "room": "Rawat Bersama",
      "bed": "-",
      "category": "Rawat Bersama",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105113",
      "name": "BUDI SUSANTO",
      "reg": "00040037",
      "dob": "1978-05-15",
      "age": 47,
      "queue": 3,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-26",
      "registrationTime": "09:30:45",
      "diagnosis": "Hernia Inguinalis",
      "ccp1": "CCP1",
      "room": "Rawat Bersama",
      "bed": "-",
      "category": "Rawat Bersama",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105114",
      "name": "SITI RAHMAH",
      "reg": "00040038",
      "dob": "1982-08-20",
      "age": 43,
      "queue": 4,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-25",
      "registrationTime": "14:15:20",
      "diagnosis": "Apendisitis Akut",
      "ccp1": "CCP1",
      "room": "Rawat Bersama",
      "bed": "-",
      "category": "Rawat Bersama",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105115",
      "name": "AHMAD YANI",
      "reg": "00040039",
      "dob": "1970-12-05",
      "age": 55,
      "queue": 5,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-07-24",
      "registrationTime": "10:45:30",
      "diagnosis": "Tukak Lambung",
      "ccp1": "CCP1",
      "room": "Rawat Bersama",
      "bed": "-",
      "category": "Rawat Bersama",
      "action": "Lihat Detail",
    },
    
    // Data untuk tab Operasi
    {
      "id": "280725020030004105116",
      "name": "BAMBANG SUTRISNO",
      "reg": "00040040",
      "dob": "1980-12-25",
      "age": 45,
      "queue": 1,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-28",
      "registrationTime": "14:45:30",
      "diagnosis": "Tumor Hati",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "-",
      "category": "Operasi",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105117",
      "name": "SRI REJEKI",
      "reg": "00040041",
      "dob": "1973-06-14",
      "age": 52,
      "queue": 2,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-27",
      "registrationTime": "10:30:45",
      "diagnosis": "Kanker Usus Besar",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "-",
      "category": "Operasi",
      "action": "Lihat Detail",
    },
    // Tambahan data Operasi
    {
      "id": "280725020030004105118",
      "name": "DEWI LESTARI",
      "reg": "00040042",
      "dob": "1975-03-18",
      "age": 50,
      "queue": 3,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-26",
      "registrationTime": "09:20:15",
      "diagnosis": "Kolesistitis Akut",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "-",
      "category": "Operasi",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105119",
      "name": "RUDI HANDOKO",
      "reg": "00040043",
      "dob": "1982-07-22",
      "age": 43,
      "queue": 4,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-25",
      "registrationTime": "11:45:30",
      "diagnosis": "Hernia Umbilikalis",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "-",
      "category": "Operasi",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105120",
      "name": "SITI NURHALIZAH",
      "reg": "00040044",
      "dob": "1978-11-05",
      "age": 47,
      "queue": 5,
      "status": "umum",
      "operation": "Proses Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-07-24",
      "registrationTime": "08:10:45",
      "diagnosis": "Pankreatitis Akut",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "-",
      "category": "Operasi",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105121",
      "name": "AGUS WIJAYA",
      "reg": "00040045",
      "dob": "1980-02-28",
      "age": 45,
      "queue": 6,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-23",
      "registrationTime": "10:30:20",
      "diagnosis": "Gastroenteritis",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "-",
      "category": "Operasi",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105122",
      "name": "SRI RAHAYU",
      "reg": "00040046",
      "dob": "1972-09-15",
      "age": 53,
      "queue": 7,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-22",
      "registrationTime": "13:15:10",
      "diagnosis": "Sindrom Irritable Bowel",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "-",
      "category": "Operasi",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105123",
      "name": "BAMBANG SUDIYONO",
      "reg": "00040047",
      "dob": "1987-04-10",
      "age": 38,
      "queue": 8,
      "status": "bpjs",
      "operation": "Proses Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-21",
      "registrationTime": "09:45:35",
      "diagnosis": "Divertikulitis",
      "ccp1": "CCP1",
      "room": "Kamar Khusus",
      "bed": "-",
      "category": "Operasi",
      "action": "Lihat Detail",
    },
  ];
  
  // Data untuk riwayat pasien
  final List<Map<String, dynamic>> historyPatients = [
    {
      "id": "280725020030004101",
      "name": "AHMAD DAHLAN",
      "reg": "00040020",
      "dob": "1970-05-20",
      "age": 55,
      "queue": 1,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-20",
      "registrationTime": "14:15:21",
      "diagnosis": "Kolesistektomi",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 1",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004102",
      "name": "SUSILO BAMBANG",
      "reg": "00040021",
      "dob": "1965-11-12",
      "age": 60,
      "queue": 2,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-18",
      "registrationTime": "10:30:45",
      "diagnosis": "Apendiktomi",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 2",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004103",
      "name": "RINA WATI",
      "reg": "00040022",
      "dob": "1980-03-08",
      "age": 45,
      "queue": 3,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-07-15",
      "registrationTime": "09:15:22",
      "diagnosis": "Herniorafi",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 3",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004104",
      "name": "JOKO SANTOSO",
      "reg": "00040023",
      "dob": "1975-07-25",
      "age": 50,
      "queue": 4,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-10",
      "registrationTime": "13:45:10",
      "diagnosis": "Gastrektomi",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 4",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004105",
      "name": "INDAH PERMATASARI",
      "reg": "00040024",
      "dob": "1985-10-10",
      "age": 40,
      "queue": 5,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-07-05",
      "registrationTime": "11:20:33",
      "diagnosis": "Kolesistektomi",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 5",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    // Tambahan data riwayat pasien
    {
      "id": "280725020030004106",
      "name": "BUDI SUSANTO",
      "reg": "00040025",
      "dob": "1978-05-10",
      "age": 47,
      "queue": 6,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-07-03",
      "registrationTime": "09:20:15",
      "diagnosis": "Gastritis Kronis",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 6",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004107",
      "name": "SITI RAHMAH",
      "reg": "00040026",
      "dob": "1983-08-15",
      "age": 42,
      "queue": 7,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-07-01",
      "registrationTime": "11:45:30",
      "diagnosis": "Refluks Esofagitis",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 7",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004108",
      "name": "AGUS SALIM",
      "reg": "00040027",
      "dob": "1975-11-20",
      "age": 50,
      "queue": 8,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-06-28",
      "registrationTime": "08:10:45",
      "diagnosis": "Tukak Duodenum",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 8",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004109",
      "name": "DEWI SARTIKA",
      "reg": "00040028",
      "dob": "1980-02-28",
      "age": 45,
      "queue": 9,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-06-25",
      "registrationTime": "10:30:20",
      "diagnosis": "Gastroenteritis",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 9",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004110",
      "name": "RUDI PRASETYO",
      "reg": "00040029",
      "dob": "1972-09-15",
      "age": 53,
      "queue": 10,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-06-22",
      "registrationTime": "13:15:10",
      "diagnosis": "Sindrom Irritable Bowel",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 10",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004111",
      "name": "SRI REJEKI",
      "reg": "00040030",
      "dob": "1987-04-10",
      "age": 38,
      "queue": 11,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-06-20",
      "registrationTime": "09:45:35",
      "diagnosis": "Divertikulitis",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 11",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004112",
      "name": "BAMBANG SUDIYONO",
      "reg": "00040031",
      "dob": "1980-12-05",
      "age": 45,
      "queue": 12,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Nurul Yulianti",
      "registrationDate": "2025-06-18",
      "registrationTime": "14:15:20",
      "diagnosis": "Apendisitis Akut",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 12",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004113",
      "name": "INDAH PERMATASARI",
      "reg": "00040032",
      "dob": "1985-10-10",
      "age": 40,
      "queue": 13,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. FITRI SUHARNA",
      "registrationDate": "2025-06-15",
      "registrationTime": "11:20:33",
      "diagnosis": "Kolesistektomi",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 13",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004114",
      "name": "AHMAD YANI",
      "reg": "00040033",
      "dob": "1970-05-20",
      "age": 55,
      "queue": 14,
      "status": "umum",
      "operation": "Selesai Operasi",
      "doctor": "dr. Canggih Dian Hidayah",
      "registrationDate": "2025-06-12",
      "registrationTime": "09:15:21",
      "diagnosis": "Kolesistektomi",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 14",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
    {
      "id": "280725020030004115",
      "name": "SUSILO BAMBANG",
      "reg": "00040034",
      "dob": "1965-11-12",
      "age": 60,
      "queue": 15,
      "status": "bpjs",
      "operation": "Selesai Operasi",
      "doctor": "dr. Yusmoldi, Sp.B-KBD",
      "registrationDate": "2025-06-10",
      "registrationTime": "10:30:45",
      "diagnosis": "Apendiktomi",
      "ccp1": "CCP1",
      "room": "Ruangan",
      "bed": "Bed 15",
      "category": "Rawat Inap",
      "action": "Lihat Detail",
    },
  ];
  
  // Filter patients based on selected tab
  List<Map<String, dynamic>> get filteredPatients {
  List<Map<String, dynamic>> tabFiltered = patients.where((patient) {
    return patient["category"] == selectedTab;
  }).toList();
  
  return _applyFilters(tabFiltered);
}
  
  // Get paginated patients
  List<Map<String, dynamic>> get paginatedPatients {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    
    if (startIndex >= filteredPatients.length) {
      return [];
    }
    
    return filteredPatients.sublist(
      startIndex,
      endIndex.clamp(0, filteredPatients.length),
    );
  }
  
  // Get total pages
  int get totalPages {
    return (filteredPatients.length / itemsPerPage).ceil();
  }
  
  // Handle page change
  void _changePage(int newPage) {
    if (newPage >= 1 && newPage <= totalPages) {
      setState(() {
        currentPage = newPage;
      });
    }
  }
  
  // Handle items per page change
  void _changeItemsPerPage(int newValue) {
    setState(() {
      itemsPerPage = newValue;
      currentPage = 1; // Reset to first page when changing items per page
    });
  }

  List<Map<String, dynamic>> _applyFilters(List<Map<String, dynamic>> patients) {
  List<Map<String, dynamic>> filtered = patients;
  
  // Filter berdasarkan search text
  if (searchController.text.isNotEmpty) {
    String searchText = searchController.text.toLowerCase();
    filtered = filtered.where((patient) {
      return patient["name"].toString().toLowerCase().contains(searchText) ||
             patient["id"].toString().toLowerCase().contains(searchText) ||
             patient["reg"].toString().toLowerCase().contains(searchText);
    }).toList();
  }
  
  // Filter berdasarkan tanggal mulai
  if (startDate != null) {
    filtered = filtered.where((patient) {
      DateTime registrationDate = DateTime.parse(patient["registrationDate"]);
      return registrationDate.isAfter(startDate!) || 
             registrationDate.isAtSameMomentAs(startDate!);
    }).toList();
  }
  
  // Filter berdasarkan tanggal akhir
  if (endDate != null) {
    filtered = filtered.where((patient) {
      DateTime registrationDate = DateTime.parse(patient["registrationDate"]);
      return registrationDate.isBefore(endDate!.add(Duration(days: 1))) || 
             registrationDate.isAtSameMomentAs(endDate!);
    }).toList();
  }
  
  // Filter berdasarkan ruangan
  if (selectedRoom != "Semua Ruangan") {
    filtered = filtered.where((patient) {
      return patient["room"].toString().toLowerCase().contains(selectedRoom.toLowerCase()) ||
             patient["bed"].toString().toLowerCase().contains(selectedRoom.toLowerCase());
    }).toList();
  }
  
  return filtered;
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "ERM Bedah Sentral",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        centerTitle: true,
        actions: [
          // History button
          IconButton(
            onPressed: () {
              // Navigate to history page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryPage(
                    historyPatients: historyPatients,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.history, color: Colors.white),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and patient count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Pasien Aktif",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${filteredPatients.length} Pasien",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Tabs - Scrollable horizontally
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildTab("Rawat Jalan", selectedTab == "Rawat Jalan"),
                      _buildTab("Rawat Inap", selectedTab == "Rawat Inap"),
                      _buildTab("Unit Penunjang", selectedTab == "Unit Penunjang"),
                      _buildTab("Konsul", selectedTab == "Konsul"),
                      _buildTab("Rawat Bersama", selectedTab == "Rawat Bersama"),
                      _buildTab("Operasi", selectedTab == "Operasi"),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Statistics cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard("Pasien Selesai", statistics["Pasien Selesai"]!, Colors.green),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard("Proses", statistics["Proses"]!, Colors.orange),
                  ),
                ],
              ),
              
              const SizedBox(height: 8),
              
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard("Baru", statistics["Baru"]!, Colors.blue),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildStatCard("Batal", statistics["Batal"]!, Colors.red),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Search and filter box
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Search box
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Cari Nama/No RM/No Reg Pasien",
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey[600],
                          ),
                          suffixIcon: searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      searchController.clear();
                                    });
                                  },
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF1E40AF),
                              width: 2,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            currentPage = 1; // Reset to first page when searching
                          });
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // Date and room filters
                      Row(
                        children: [
                          // Start date
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectStartDate(context),
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16, color: Color(0xFF64748B)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        startDate != null 
                                            ? "${startDate!.day.toString().padLeft(2, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.year}"
                                            : "Start Date",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: startDate != null ? const Color(0xFF1E293B) : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(width: 8),
                          
                          // End date
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectEndDate(context),
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[300]!),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today, size: 16, color: Color(0xFF64748B)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        endDate != null 
                                            ? "${endDate!.day.toString().padLeft(2, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.year}"
                                            : "End Date",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: endDate != null ? const Color(0xFF1E293B) : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 8),
                      
                      // Room filter
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white, // Background putih untuk dropdown
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedRoom,
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF64748B)),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF1E293B),
                            ),
                            dropdownColor: Colors.white, // Background putih untuk dropdown menu
                            items: [
                              "Semua Ruangan",
                              "Ruangan",
                              "Kamar Khusus", 
                              "Poliklinik",
                              "Lab",
                              "Konsul",
                              "Rawat Bersama",
                            ]
                                .map(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        color: Color(0xFF1E293B), // Warna teks hitam
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedRoom = value!;
                                currentPage = 1; // Reset to first page when changing room filter
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: _clearAllFilters,
                            icon: const Icon(
                              Icons.clear_all,
                              size: 16,
                              color: Color(0xFF64748B),
                            ),
                            label: const Text(
                              "Clear All Filters",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Patient list
              if (paginatedPatients.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.search_off,
                          size: 48,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Tidak ada data pasien",
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Coba pilih tab lain",
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              
              if (paginatedPatients.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paginatedPatients.length,
                  itemBuilder: (context, index) {
                    final patient = paginatedPatients[index];
                    return PatientCard(patient: patient);
                  },
                ),
              
              if (paginatedPatients.isNotEmpty)
                const SizedBox(height: 16),
              
              // Pagination
              if (paginatedPatients.isNotEmpty)
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Responsive pagination
                    if (constraints.maxWidth < 600) {
                      // Small screen - vertical layout
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Items per row
                            Row(
                              children: [
                                const Text(
                                  "Tampilkan ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFE2E8F0),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        value: itemsPerPage,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF1E293B),
                                        ),
                                        items: [5, 10, 20, 50]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e.toString(),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            _changeItemsPerPage(value);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  " data",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Page navigation
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: currentPage > 1 ? () => _changePage(currentPage - 1) : null,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Color(0xFF64748B),
                                  ),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFFF8FAFC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  disabledColor: Colors.grey.shade300,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Hal. $currentPage dari $totalPages",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: currentPage < totalPages ? () => _changePage(currentPage + 1) : null,
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF64748B),
                                  ),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFFF8FAFC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  disabledColor: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Large screen - horizontal layout
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Tampilkan ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int>(
                                      value: itemsPerPage,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF1E293B),
                                      ),
                                      items: [5, 10, 20, 50]
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.toString(),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          _changeItemsPerPage(value);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const Text(
                                  " data",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: currentPage > 1 ? () => _changePage(currentPage - 1) : null,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Color(0xFF64748B),
                                  ),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFFF8FAFC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  disabledColor: Colors.grey.shade300,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Hal. $currentPage dari $totalPages",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: currentPage < totalPages ? () => _changePage(currentPage + 1) : null,
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF64748B),
                                  ),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFFF8FAFC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  disabledColor: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _selectStartDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: startDate ?? DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF1E40AF), // Header background color
            onPrimary: Colors.white, // Header text color
            onSurface: Colors.black, // Body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1E40AF), // Button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    setState(() {
      startDate = picked;
      currentPage = 1; // Reset to first page when changing date filter
    });
  }
}
  
  Future<void> _selectEndDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: startDate ?? DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: const Color(0xFF1E40AF), // Header background color
            onPrimary: Colors.white, // Header text color
            onSurface: Colors.black, // Body text color
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1E40AF), // Button text color
            ),
          ),
        ),
        child: child!,
      );
    },
  );
  if (picked != null) {
    setState(() {
      startDate = picked;
      currentPage = 1; // Reset to first page when changing date filter
    });
  }
}

  void _clearAllFilters() {
  setState(() {
    searchController.clear();
    startDate = null;
    endDate = null;
    selectedRoom = "Semua Ruangan";
    currentPage = 1;
  });
}
  
  Widget _buildStatCard(String title, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTab(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = title;
          currentPage = 1; // Reset to first page when changing tab
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1E40AF) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}

class PatientCard extends StatelessWidget {
  final Map<String, dynamic> patient;
  const PatientCard({
    super.key,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // MAIN ROW
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Left side - Avatar
                Container(
                  width: 74,
                  height: 74,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF1E40AF), width: 2),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Color(0xFF64748B),
                    size: 34,
                  ),
                ),
                const SizedBox(width: 16),

                // Center - Patient Info + Blue Tags
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        patient["name"],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        patient["id"],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        patient["reg"],
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${patient["dob"]} / ${patient["age"]}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Blue tags section (responsive)
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: [
                          if (patient["diagnosis"] != "-")
                            _buildTag(patient["diagnosis"]),
                          if (patient["room"] != "-")
                            _buildTag(patient["room"]),
                          if (patient["bed"] != "-")
                            _buildTag(patient["bed"]),
                        ],
                      ),
                    ],
                  ),
                ),

                // Right side - Status (BPJS/UMUM) + Queue number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Status badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: patient["status"] == "bpjs"
                            ? Colors.green
                            : const Color(0xFF3B82F6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        patient["status"] == "bpjs" ? "BPJS" : "UMUM",
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    
                    // Queue number - auto-resize container
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8, 
                        vertical: 6
                      ),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          "${patient["queue"]}",
                          style: TextStyle(
                            fontSize: _getQueueFontSize(patient["queue"]),
                            color: Color(0xFF1E40AF),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 26),

            // Menu buttons with checkmark ALL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMenuButton("CPPT", Colors.green, true),
                _buildMenuButton("Diagnosed", Colors.pink, true),
                _buildMenuButton("Lab", Colors.blue, true),
                _buildMenuButton("Radiology", Colors.indigo, true),
                _buildMenuButton("Obat", Colors.orange, true),
              ],
            ),

            const SizedBox(height: 16),

            // Doctor info and date
            Row(
              children: [
                const Icon(Icons.person, size: 16, color: Color(0xFF64748B)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    patient["doctor"],
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1E293B),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  "${patient["registrationDate"]} - ${patient["registrationTime"]}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Function to determine font size based on queue number  
  double _getQueueFontSize(int queueNumber) {
    if (queueNumber < 10) {
      return 40.0; // 1 digit - bigger font
    } else if (queueNumber < 100) {
      return 35.0; // 2 digits
    } else {
      return 28.0; // 3+ digits
    }
  }

  // Blue Tag Builder
  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF3B82F6),
        borderRadius: BorderRadius.circular(4),
      ),
      constraints: const BoxConstraints(maxWidth: 200), // biar ga kepanjangan
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(MdiIcons.bedEmpty, size: 14, color: Colors.white),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              text,
              softWrap: true,
              overflow: TextOverflow.visible,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Menu Button Builder
  Widget _buildMenuButton(String text, Color color, bool hasCheckmark) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: hasCheckmark ? color : Colors.transparent,
            border: Border.all(color: color, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: hasCheckmark
              ? const Icon(Icons.check, size: 12, color: Colors.white)
              : null,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}


// Halaman Riwayat Pasien
class HistoryPage extends StatefulWidget {
  final List<Map<String, dynamic>> historyPatients;
  const HistoryPage({
    super.key,
    required this.historyPatients,
  });

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // Pagination state
  int currentPage = 1;
  int itemsPerPage = 10;
  
  // Get paginated patients
  List<Map<String, dynamic>> get paginatedPatients {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    
    if (startIndex >= widget.historyPatients.length) {
      return [];
    }
    
    return widget.historyPatients.sublist(
      startIndex,
      endIndex.clamp(0, widget.historyPatients.length),
    );
  }
  
  // Get total pages
  int get totalPages {
    return (widget.historyPatients.length / itemsPerPage).ceil();
  }
  
  // Handle page change
  void _changePage(int newPage) {
    if (newPage >= 1 && newPage <= totalPages) {
      setState(() {
        currentPage = newPage;
      });
    }
  }
  
  // Handle items per page change
  void _changeItemsPerPage(int newValue) {
    setState(() {
      itemsPerPage = newValue;
      currentPage = 1; // Reset to first page when changing items per page
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          "Riwayat Pasien",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1E40AF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and patient count
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Riwayat Pasien",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.historyPatients.length} Pasien",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Search box
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari Nama/No RM/No Reg Pasien",
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Colors.grey[300]!,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF1E40AF),
                        width: 2,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      currentPage = 1; // Reset to first page when searching
                    });
                  },
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Patient list
              if (paginatedPatients.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(48),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Icon(
                          Icons.search_off,
                          size: 48,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Tidak ada data pasien",
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Coba pilih tab lain",
                        style: TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              
              if (paginatedPatients.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paginatedPatients.length,
                  itemBuilder: (context, index) {
                    final patient = paginatedPatients[index];
                    return PatientCard(patient: patient);
                  },
                ),
              
              if (paginatedPatients.isNotEmpty)
                const SizedBox(height: 16),
              
              // Pagination
              if (paginatedPatients.isNotEmpty)
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Responsive pagination
                    if (constraints.maxWidth < 600) {
                      // Small screen - vertical layout
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Items per row
                            Row(
                              children: [
                                const Text(
                                  "Tampilkan ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color(0xFFE2E8F0),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<int>(
                                        value: itemsPerPage,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF1E293B),
                                        ),
                                        items: [5, 10, 20, 50]
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(
                                                  e.toString(),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            _changeItemsPerPage(value);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  " data",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            
                            const SizedBox(height: 12),
                            
                            // Page navigation
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: currentPage > 1 ? () => _changePage(currentPage - 1) : null,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Color(0xFF64748B),
                                  ),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFFF8FAFC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  disabledColor: Colors.grey.shade300,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Hal. $currentPage dari $totalPages",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: currentPage < totalPages ? () => _changePage(currentPage + 1) : null,
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF64748B),
                                  ),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFFF8FAFC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  disabledColor: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Large screen - horizontal layout
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Tampilkan ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFFE2E8F0),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<int>(
                                      value: itemsPerPage,
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Color(0xFF1E293B),
                                      ),
                                      items: [5, 10, 20, 50]
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(
                                                e.toString(),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          _changeItemsPerPage(value);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                                const Text(
                                  " data",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: currentPage > 1 ? () => _changePage(currentPage - 1) : null,
                                  icon: const Icon(
                                    Icons.chevron_left,
                                    color: Color(0xFF64748B),
                                  ),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFFF8FAFC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  disabledColor: Colors.grey.shade300,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Hal. $currentPage dari $totalPages",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  onPressed: currentPage < totalPages ? () => _changePage(currentPage + 1) : null,
                                  icon: const Icon(
                                    Icons.chevron_right,
                                    color: Color(0xFF64748B),
                                  ),
                                  iconSize: 20,
                                  style: IconButton.styleFrom(
                                    backgroundColor: const Color(0xFFF8FAFC),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  disabledColor: Colors.grey.shade300,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}