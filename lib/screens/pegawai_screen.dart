import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class PegawaiScreen extends StatefulWidget {
  const PegawaiScreen({super.key});
  
  @override
  State<PegawaiScreen> createState() => _PegawaiScreenState();
}

class _PegawaiScreenState extends State<PegawaiScreen> {
  late CalendarController _medicalCalendarController;
  late CalendarController _nonMedicalCalendarController;
  
  // Filter states
  String selectedMedicalFilter = 'All';
  String selectedNonMedicalFilter = 'All';
  
  // Calendar view states
  CalendarView _medicalCalendarView = CalendarView.month;
  CalendarView _nonMedicalCalendarView = CalendarView.month;
  
  // Data statistik pegawai
  final Map<String, int> employeeStats = {
    'Dokter Spesialis': 9,
    'Dokter Umum': 5,
    'Perawat': 5,
    'Bidan': 5,
    'Apoteker': 5,
    'Staff': 5,
  };
  
  // Warna untuk setiap kategori
  final Map<String, Color> categoryColors = {
    'Dokter Spesialis': Color(0xFF1E40AF), // Biru tua
    'Dokter Umum': Color(0xFF3B82F6),      // Biru
    'Perawat': Color(0xFF10B981),          // Hijau
    'Bidan': Color(0xFF8B5CF6),           // Ungu
    'Apoteker': Color(0xFFF59E0B),        // Orange
    'Staff': Color(0xFFEC4899),           // Pink
  };
  
  // Data lengkap jadwal petugas medis berdasarkan kategori
  final Map<String, Map<DateTime, List<DoctorSchedule>>> medicalScheduleByCategory = {
    'Dokter Spesialis': {
      DateTime(2025, 9, 1): [
        DoctorSchedule(name: 'dr. MUHAMMAD SATRIA, Sp.B', specialty: 'BEDAH DIGESTIF', startTime: '07:30', endTime: '14:00', photoAsset: 'assets/dokter/doctor1.png'),
        DoctorSchedule(name: 'dr. Alfita Hilranti, Sp.KJ, M.MR', specialty: 'JIWA', startTime: '07:30', endTime: '12:00', photoAsset: 'assets/dokter/doctor7.jpg'),
      ],
      DateTime(2025, 9, 3): [
        DoctorSchedule(name: 'dr. YULISMA, Sp.OVG, FINSDV, FAADV', specialty: 'KULIT KELAMIN', startTime: '07:30', endTime: '12:00', photoAsset: 'assets/dokter/doctor3.png'),
        DoctorSchedule(name: 'dr. Mizar Erlanto, Sp.B(K)Onk', specialty: 'BEDAH ONKOLOGI', startTime: '07:30', endTime: '15:00', photoAsset: 'assets/dokter/dokterlaki.png'),
      ],
      DateTime(2025, 9, 5): [
        DoctorSchedule(name: 'dr. Ahmad Rahman, Sp.JP', specialty: 'JANTUNG', startTime: '08:00', endTime: '15:00', photoAsset: 'assets/dokter/dokterlaki1.jpg'),
        DoctorSchedule(name: 'dr. Siti Aminah, Sp.M', specialty: 'MATA', startTime: '08:00', endTime: '13:00', photoAsset: 'assets/dokter/dokterwanita.jpg'),
      ],
      DateTime(2025, 9, 9): [
        DoctorSchedule(name: 'dr. Fitri Handayani, Sp.Rad', specialty: 'RADIOLOGI', startTime: '08:00', endTime: '15:00', photoAsset: 'assets/dokter/doctor4.png'),
      ],
      DateTime(2025, 9, 15): [
        DoctorSchedule(name: 'dr. Hendra Wijaya, Sp.PD', specialty: 'DALAM', startTime: '07:30', endTime: '12:00', photoAsset: 'assets/dokter/doctor6.jpg'),
        DoctorSchedule(name: 'dr. Maya Indira, Sp.S', specialty: 'SARAF', startTime: '08:00', endTime: '14:00', photoAsset: 'assets/dokter/doctor5.png'),
      ],
    },
    'Dokter Umum': {
      DateTime(2025, 9, 2): [
        DoctorSchedule(name: 'dr. Budi Santoso', specialty: 'UMUM', startTime: '08:00', endTime: '16:00', photoAsset: ''),
        DoctorSchedule(name: 'dr. Lisa Permata', specialty: 'UMUM', startTime: '07:30', endTime: '15:30', photoAsset: ''),
      ],
      DateTime(2025, 9, 4): [
        DoctorSchedule(name: 'dr. Eko Purnomo', specialty: 'UMUM', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 6): [
        DoctorSchedule(name: 'dr. Ratna Dewi', specialty: 'UMUM', startTime: '07:30', endTime: '15:30', photoAsset: ''),
        DoctorSchedule(name: 'dr. Agus Santoso', specialty: 'UMUM', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 10): [
        DoctorSchedule(name: 'dr. Nanda Pratama', specialty: 'UMUM', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 18): [
        DoctorSchedule(name: 'dr. Indah Sari', specialty: 'UMUM', startTime: '07:30', endTime: '15:30', photoAsset: ''),
        DoctorSchedule(name: 'dr. Yudi Pranata', specialty: 'UMUM', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
    },
    'Perawat': {
      DateTime(2025, 9, 1): [
        DoctorSchedule(name: 'Ns. Maria Gonzales', specialty: 'PERAWAT IGD', startTime: '07:00', endTime: '19:00', photoAsset: ''),
        DoctorSchedule(name: 'Ns. Siti Nurhaliza', specialty: 'PERAWAT RAWAT INAP', startTime: '19:00', endTime: '07:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 7): [
        DoctorSchedule(name: 'Ns. Dewi Lestari', specialty: 'PERAWAT ICU', startTime: '07:00', endTime: '19:00', photoAsset: ''),
        DoctorSchedule(name: 'Ns. Rudi Hermawan', specialty: 'PERAWAT OK', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 12): [
        DoctorSchedule(name: 'Ns. Fitri Handayani', specialty: 'PERAWAT ANAK', startTime: '07:00', endTime: '19:00', photoAsset: ''),
        DoctorSchedule(name: 'Ns. Bambang Susilo', specialty: 'PERAWAT JIWA', startTime: '19:00', endTime: '07:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 20): [
        DoctorSchedule(name: 'Ns. Rina Marlina', specialty: 'PERAWAT BEDAH', startTime: '07:00', endTime: '19:00', photoAsset: ''),
        DoctorSchedule(name: 'Ns. Hendra Kusuma', specialty: 'PERAWAT POLI', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
    },
    'Bidan': {
      DateTime(2025, 9, 4): [
        DoctorSchedule(name: 'Bd. Lina Kartini', specialty: 'BIDAN VK', startTime: '07:00', endTime: '19:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 6): [
        DoctorSchedule(name: 'Bd. Maya Sari', specialty: 'BIDAN POLI KIA', startTime: '08:00', endTime: '16:00', photoAsset: ''),
        DoctorSchedule(name: 'Bd. Dian Permata', specialty: 'BIDAN NIFAS', startTime: '19:00', endTime: '07:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 10): [
        DoctorSchedule(name: 'Bd. Agung Nugroho', specialty: 'BIDAN KB', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 15): [
        DoctorSchedule(name: 'Bd. Yanto Pratama', specialty: 'BIDAN PERSALINAN', startTime: '07:00', endTime: '19:00', photoAsset: ''),
      ],
    },
  };
  
  // Data jadwal petugas non medis berdasarkan kategori
  final Map<String, Map<DateTime, List<StaffSchedule>>> nonMedicalScheduleByCategory = {
    'Apoteker': {
      DateTime(2025, 9, 1): [
        StaffSchedule(name: 'Ahmad Suryadi', position: 'Apoteker', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 3): [
        StaffSchedule(name: 'Maria Gonzales', position: 'Apoteker', startTime: '08:00', endTime: '16:00', photoAsset: ''),
        StaffSchedule(name: 'Dewi Lestari', position: 'Apoteker', startTime: '16:00', endTime: '24:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 7): [
        StaffSchedule(name: 'Rina Marlina', position: 'Apoteker', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 12): [
        StaffSchedule(name: 'Agung Nugroho', position: 'Apoteker', startTime: '08:00', endTime: '16:00', photoAsset: ''),
        StaffSchedule(name: 'Fitri Handayani', position: 'Apoteker', startTime: '16:00', endTime: '24:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 18): [
        StaffSchedule(name: 'Hendra Kusuma', position: 'Apoteker', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
    },
    'Staff': {
      DateTime(2025, 9, 2): [
        StaffSchedule(name: 'Siti Nurhaliza', position: 'Admin', startTime: '07:30', endTime: '15:30', photoAsset: ''),
        StaffSchedule(name: 'Indra Wijaya', position: 'Teknisi', startTime: '08:00', endTime: '16:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 5): [
        StaffSchedule(name: 'Budi Santoso', position: 'Security', startTime: '06:00', endTime: '18:00', photoAsset: ''),
        StaffSchedule(name: 'Anita Sari', position: 'Cleaning Service', startTime: '06:00', endTime: '14:00', photoAsset: ''),
      ],
      DateTime(2025, 9, 10): [
        StaffSchedule(name: 'Yanto Pratama', position: 'IT Support', startTime: '08:00', endTime: '17:00', photoAsset: ''),
        StaffSchedule(name: 'Lina Kartini', position: 'Admin', startTime: '07:30', endTime: '15:30', photoAsset: ''),
      ],
      DateTime(2025, 9, 15): [
        StaffSchedule(name: 'Maya Sari', position: 'Nutritionist', startTime: '08:00', endTime: '15:00', photoAsset: ''),
        StaffSchedule(name: 'Dian Permata', position: 'Admin', startTime: '07:30', endTime: '15:30', photoAsset: ''),
      ],
      DateTime(2025, 9, 20): [
        StaffSchedule(name: 'Bambang Susilo', position: 'Maintenance', startTime: '08:00', endTime: '16:00', photoAsset: ''),
        StaffSchedule(name: 'Rudi Hermawan', position: 'Driver', startTime: '07:00', endTime: '15:00', photoAsset: ''),
      ],
    },
  };
  
  @override
  void initState() {
    super.initState();
    _medicalCalendarController = CalendarController();
    _nonMedicalCalendarController = CalendarController();
    _medicalCalendarController.displayDate = DateTime(2025, 9);
    _nonMedicalCalendarController.displayDate = DateTime(2025, 9);
  }
  
  // Generate appointments berdasarkan filter
  List<Meeting> _generateFilteredAppointments(Map<String, Map<DateTime, List<dynamic>>> scheduleByCategory, String selectedFilter) {
    List<Meeting> appointments = [];
    
    if (selectedFilter == 'All') {
      // Gabungkan semua kategori
      scheduleByCategory.forEach((category, scheduleMap) {
        scheduleMap.forEach((date, schedules) {
          appointments.add(Meeting(
            eventName: '${schedules.length} Jadwal',
            from: date,
            to: date,
            background: categoryColors[category]!,
            category: category,
          ));
        });
      });
    } else {
      // Hanya kategori yang dipilih
      if (scheduleByCategory.containsKey(selectedFilter)) {
        scheduleByCategory[selectedFilter]!.forEach((date, schedules) {
          appointments.add(Meeting(
            eventName: '${schedules.length} Jadwal',
            from: date,
            to: date,
            background: categoryColors[selectedFilter]!,
            category: selectedFilter,
          ));
        });
      }
    }
    
    return appointments;
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: const Text(
            'Kepegawaian Homepage',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          backgroundColor: const Color(0xFF1E40AF),
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            onPressed: () => Navigator.pop(context),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kepegawaian Homepage'),
              Tab(text: 'Rekap Absensi'),
            ],
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontSize: 12),
          ),
        ),
        body: TabBarView(
          children: [
            _buildKepegawaianTab(),
            _buildRekapAbsensiTab(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildKepegawaianTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Employee Stats Grid
          const Text(
            'Statistik Pegawai',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1.1,
            ),
            itemCount: employeeStats.length,
            itemBuilder: (context, index) {
              final role = employeeStats.keys.elementAt(index);
              final count = employeeStats.values.elementAt(index);
              return _buildEmployeeCard(role, count);
            },
          ),
          
          const SizedBox(height: 16),
          
          // Medical Staff Schedule
          const Text(
            'Jadwal Petugas Medis',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          
          _buildScheduleCard(
            title: 'Jadwal Petugas Medis',
            appointments: _generateFilteredAppointments(medicalScheduleByCategory, selectedMedicalFilter),
            accentColor: const Color(0xFF1E40AF),
            staffTypes: const ['Dokter Spesialis', 'Dokter Umum', 'Perawat', 'Bidan'],
            controller: _medicalCalendarController,
            scheduleDetails: _getFilteredScheduleDetails(medicalScheduleByCategory, selectedMedicalFilter),
            isMedical: true,
            selectedFilter: selectedMedicalFilter,
            onFilterChanged: (filter) {
              setState(() {
                selectedMedicalFilter = filter;
              });
            },
            calendarView: _medicalCalendarView,
            onViewChanged: (view) {
              setState(() {
                _medicalCalendarView = view;
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          // Non-Medical Staff Schedule
          const Text(
            'Jadwal Petugas Non Medis',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 8),
          
          _buildScheduleCard(
            title: 'Jadwal Petugas Non Medis',
            appointments: _generateFilteredAppointments(nonMedicalScheduleByCategory, selectedNonMedicalFilter),
            accentColor: const Color(0xFF059669), // Tetap hijau untuk non-medis secara umum
            staffTypes: const ['Apoteker', 'Staff'],
            controller: _nonMedicalCalendarController,
            scheduleDetails: _getFilteredScheduleDetails(nonMedicalScheduleByCategory, selectedNonMedicalFilter),
            isMedical: false,
            selectedFilter: selectedNonMedicalFilter,
            onFilterChanged: (filter) {
              setState(() {
                selectedNonMedicalFilter = filter;
              });
            },
            calendarView: _nonMedicalCalendarView,
            onViewChanged: (view) {
              setState(() {
                _nonMedicalCalendarView = view;
              });
            },
          ),
        ],
      ),
    );
  }
  
  Map<DateTime, List<dynamic>> _getFilteredScheduleDetails(Map<String, Map<DateTime, List<dynamic>>> scheduleByCategory, String selectedFilter) {
    Map<DateTime, List<dynamic>> filteredDetails = {};
    
    if (selectedFilter == 'All') {
      scheduleByCategory.forEach((category, scheduleMap) {
        scheduleMap.forEach((date, schedules) {
          if (filteredDetails.containsKey(date)) {
            // Tambahkan informasi kategori ke setiap item jadwal
            List<dynamic> categorizedSchedules = schedules.map((schedule) {
              if (schedule is DoctorSchedule) {
                return CategorizedDoctorSchedule(
                  name: schedule.name,
                  specialty: schedule.specialty,
                  startTime: schedule.startTime,
                  endTime: schedule.endTime,
                  category: category,
                  photoAsset: schedule.photoAsset,
                );
              } else if (schedule is StaffSchedule) {
                return CategorizedStaffSchedule(
                  name: schedule.name,
                  position: schedule.position,
                  startTime: schedule.startTime,
                  endTime: schedule.endTime,
                  category: category,
                  photoAsset: schedule.photoAsset,
                );
              }
              return schedule;
            }).toList();
            
            filteredDetails[date]!.addAll(categorizedSchedules);
          } else {
            // Tambahkan informasi kategori ke setiap item jadwal
            List<dynamic> categorizedSchedules = schedules.map((schedule) {
              if (schedule is DoctorSchedule) {
                return CategorizedDoctorSchedule(
                  name: schedule.name,
                  specialty: schedule.specialty,
                  startTime: schedule.startTime,
                  endTime: schedule.endTime,
                  category: category,
                  photoAsset: schedule.photoAsset,
                );
              } else if (schedule is StaffSchedule) {
                return CategorizedStaffSchedule(
                  name: schedule.name,
                  position: schedule.position,
                  startTime: schedule.startTime,
                  endTime: schedule.endTime,
                  category: category,
                  photoAsset: schedule.photoAsset,
                );
              }
              return schedule;
            }).toList();
            
            filteredDetails[date] = categorizedSchedules;
          }
        });
      });
    } else {
      if (scheduleByCategory.containsKey(selectedFilter)) {
        // Tambahkan informasi kategori ke setiap item jadwal
        Map<DateTime, List<dynamic>> categorizedMap = {};
        scheduleByCategory[selectedFilter]!.forEach((date, schedules) {
          List<dynamic> categorizedSchedules = schedules.map((schedule) {
            if (schedule is DoctorSchedule) {
              return CategorizedDoctorSchedule(
                name: schedule.name,
                specialty: schedule.specialty,
                startTime: schedule.startTime,
                endTime: schedule.endTime,
                category: selectedFilter,
                photoAsset: schedule.photoAsset,
              );
            } else if (schedule is StaffSchedule) {
              return CategorizedStaffSchedule(
                name: schedule.name,
                position: schedule.position,
                startTime: schedule.startTime,
                endTime: schedule.endTime,
                category: selectedFilter,
                photoAsset: schedule.photoAsset,
              );
            }
            return schedule;
          }).toList();
          
          categorizedMap[date] = categorizedSchedules;
        });
        
        filteredDetails = categorizedMap;
      }
    }
    
    return filteredDetails;
  }
  
  void _showScheduleDetail(DateTime date, List<dynamic> schedules, bool isMedical) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isMedical ? const Color(0xFF1E40AF) : const Color(0xFF059669),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isMedical ? 'Daftar Jadwal Medis' : 'Daftar Jadwal Non Medis',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tanggal: ${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: Colors.white, size: 22),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                
                // Content dengan horizontal scroll
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      width: 800,
                      child: Column(
                        children: [
                          // Table Header
                          Container(
                            color: Colors.grey[100],
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'No',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 40,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '#',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Foto',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 200,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    isMedical ? 'Nama Dokter' : 'Nama Staff',
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 180,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    isMedical ? 'Spesialis/Unit Layanan' : 'Posisi',
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Jam Mulai',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Jam Selesai',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Aksi',
                                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: schedules.asMap().entries.map((entry) {
                                    int index = entry.key;
                                    dynamic schedule = entry.value;
                                    
                                    // Get category and color
                                    String category = '';
                                    Color categoryColor = Colors.grey;
                                    String photoAsset = '';
                                    
                                    if (schedule is CategorizedDoctorSchedule) {
                                      category = schedule.category;
                                      categoryColor = categoryColors[category] ?? Colors.grey;
                                      photoAsset = schedule.photoAsset;
                                    } else if (schedule is CategorizedStaffSchedule) {
                                      category = schedule.category;
                                      categoryColor = categoryColors[category] ?? Colors.grey;
                                      photoAsset = schedule.photoAsset;
                                    }
                                    
                                    return Container(
                                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                          bottom: BorderSide(color: Colors.grey[300]!),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 50,
                                            alignment: Alignment.center,
                                            child: Text(
                                              '${index + 1}',
                                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Container(
                                            width: 40,
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                color: categoryColor,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            alignment: Alignment.center,
                                            child: Container(
                                              width: 70,
                                              height: 70,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                border: Border.all(color: categoryColor, width: 2),
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(6),
                                                child: photoAsset.isNotEmpty
                                                    ? Image.asset(
                                                        photoAsset,
                                                        fit: BoxFit.cover,
                                                        errorBuilder: (context, error, stackTrace) {
                                                          return Container(
                                                            color: categoryColor.withOpacity(0.1),
                                                            child: Center(
                                                              child: Text(
                                                                schedule.name.isNotEmpty ? schedule.name[0].toUpperCase() : '?',
                                                                style: TextStyle(
                                                                  color: categoryColor,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 28,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                    : Container(
                                                        color: categoryColor.withOpacity(0.1),
                                                        child: Center(
                                                          child: Text(
                                                            schedule.name.isNotEmpty ? schedule.name[0].toUpperCase() : '?',
                                                            style: TextStyle(
                                                              color: categoryColor,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 28,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 200,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              schedule.name,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            width: 180,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              isMedical ? (schedule as CategorizedDoctorSchedule).specialty : (schedule as CategorizedStaffSchedule).position,
                                              style: const TextStyle(fontSize: 12),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              schedule.startTime,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF059669),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: Text(
                                              schedule.endTime,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFFDC2626),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => DoctorDetailScreen(
                                                      name: schedule.name,
                                                      specialty: isMedical ? (schedule as CategorizedDoctorSchedule).specialty : (schedule as CategorizedStaffSchedule).position,
                                                      category: category,
                                                      isMedical: isMedical,
                                                      photoAsset: photoAsset,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: categoryColor,
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: const Text(
                                                  'Detail',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Footer hint
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.swap_horiz,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Geser ke samping untuk melihat semua kolom',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
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
  }
  
  Widget _buildEmployeeCard(String role, int count) {
    Color cardColor = categoryColors[role] ?? const Color(0xFF64748B);
    IconData icon;
    
    switch (role) {
      case 'Dokter Spesialis':
        icon = Icons.medical_services;
        break;
      case 'Dokter Umum':
        icon = Icons.person;
        break;
      case 'Perawat':
        icon = Icons.health_and_safety;
        break;
      case 'Bidan':
        icon = Icons.pregnant_woman;
        break;
      case 'Apoteker':
        icon = Icons.medication;
        break;
      default:
        icon = Icons.groups;
    }
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PegawaiDoctorScreen(
              category: role,
              color: cardColor,
              icon: icon,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: cardColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: cardColor,
                size: 20,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              role,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1E293B),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              '$count Orang',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: cardColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildScheduleCard({
    required String title,
    required List<Meeting> appointments,
    required Color accentColor,
    required List<String> staffTypes,
    required CalendarController controller,
    required Map<DateTime, List<dynamic>> scheduleDetails,
    required bool isMedical,
    required String selectedFilter,
    required Function(String) onFilterChanged,
    required CalendarView calendarView,
    required Function(CalendarView) onViewChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                GestureDetector(
                  onTap: () => onFilterChanged('All'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: selectedFilter == 'All' ? accentColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'All',
                      style: TextStyle(
                        color: selectedFilter == 'All' ? Colors.white : Colors.grey[700],
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                ...staffTypes.map((type) {
                  Color chipColor = categoryColors[type]!;
                  bool isSelected = selectedFilter == type;
                  
                  return GestureDetector(
                    onTap: () => onFilterChanged(type),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: isSelected ? chipColor : chipColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: isSelected ? null : Border.all(color: chipColor, width: 1),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: isSelected ? Colors.white : chipColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ].toList(),
            ),
          ),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.backward!();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      color: accentColor,
                      size: 18,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.displayDate = DateTime.now();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: accentColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => onViewChanged(CalendarView.month),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: calendarView == CalendarView.month ? accentColor : Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Month',
                          style: TextStyle(
                            color: calendarView == CalendarView.month ? Colors.white : Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () => onViewChanged(CalendarView.week),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: calendarView == CalendarView.week ? accentColor : Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'Week',
                          style: TextStyle(
                            color: calendarView == CalendarView.week ? Colors.white : Colors.grey[600],
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      controller.forward!();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      color: accentColor,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          SizedBox(
            height: 550,
            child: SfCalendar(
              controller: controller,
              view: calendarView,
              initialDisplayDate: DateTime(2025, 9),
              dataSource: MeetingDataSource(appointments),
              showNavigationArrow: false,
              showDatePickerButton: false,
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.calendarCell) {
                  final DateTime selectedDate = details.date!;
                  
                  if (scheduleDetails.containsKey(selectedDate)) {
                    _showScheduleDetail(selectedDate, scheduleDetails[selectedDate]!, isMedical);
                  }
                }
              },
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
                showAgenda: false,
                dayFormat: 'EEE',
                appointmentDisplayCount: 4,
                monthCellStyle: MonthCellStyle(
                  backgroundColor: Colors.transparent,
                  todayBackgroundColor: Colors.transparent,
                  todayTextStyle: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                  trailingDatesTextStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                  leadingDatesTextStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 16,
                  ),
                ),
              ),
              timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 6,
                endHour: 20,
                timeInterval: Duration(minutes: 30),
                timeFormat: 'HH:mm',
                timeTextStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[700],
                ),
              ),
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Colors.transparent,
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              viewHeaderStyle: ViewHeaderStyle(
                backgroundColor: Colors.grey[100],
                dayTextStyle: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
                dateTextStyle: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              appointmentBuilder: (context, calendarAppointmentDetails) {
                final Meeting meeting = calendarAppointmentDetails.appointments.first;
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: meeting.background,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Text(
                    meeting.eventName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                );
              },
              cellBorderColor: Colors.grey[300],
              todayHighlightColor: accentColor.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
  
  Widget _buildRekapAbsensiTab() {
    return const Center(
      child: Text(
        'Rekap Absensi',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// Doctor List Screen
class PegawaiDoctorScreen extends StatelessWidget {
  final String category;
  final Color color;
  final IconData icon;
  
  const PegawaiDoctorScreen({
    Key? key,
    required this.category,
    required this.color,
    required this.icon,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // Sample doctor data based on category
    List<Map<String, dynamic>> doctorList = [];
    if (category == 'Dokter Spesialis') {
      doctorList = [
        {'name': 'dr. MUHAMMAD SATRIA, Sp.B', 'specialty': 'BEDAH DIGESTIF', 'nik': '1234567890', 'gender': 'Laki-laki', 'title': 'Sp.B', 'email': 'satria@hospital.com', 'phone': '081234567890', 'photoAsset': 'assets/dokter/doctor1.png'},
        {'name': 'dr. Alfita Hilranti, Sp.KJ, M.MR', 'specialty': 'JIWA', 'nik': '1234567891', 'gender': 'Laki-laki', 'title': 'Sp.KJ', 'email': 'alfita@hospital.com', 'phone': '081234567891', 'photoAsset': 'assets/dokter/doctor7.jpg'},
        {'name': 'dr. YULISMA, Sp.OVG, FINSDV, FAADV', 'specialty': 'KULIT KELAMIN', 'nik': '1234567892', 'gender': 'Laki-laki', 'title': 'Sp.OVG', 'email': 'yulisma@hospital.com', 'phone': '081234567892', 'photoAsset': 'assets/dokter/doctor3.png'},
        {'name': 'dr. Mizar Erlanto, Sp.B(K)Onk', 'specialty': 'BEDAH ONKOLOGI', 'nik': '1234567893', 'gender': 'Laki-laki', 'title': 'Sp.B(K)Onk', 'email': 'mizar@hospital.com', 'phone': '081234567893', 'photoAsset': 'assets/dokter/dokterlaki.png'},
        {'name': 'dr. Ahmad Rahman, Sp.JP', 'specialty': 'JANTUNG', 'nik': '1234567894', 'gender': 'Laki-laki', 'title': 'Sp.JP', 'email': 'ahmad@hospital.com', 'phone': '081234567894', 'photoAsset': 'assets/dokter/dokterlaki1.jpg'},
        {'name': 'dr. Siti Aminah, Sp.M', 'specialty': 'MATA', 'nik': '1234567895', 'gender': 'Perempuan', 'title': 'Sp.M', 'email': 'siti@hospital.com', 'phone': '081234567895', 'photoAsset': 'assets/dokter/dokterwanita.jpg'},
        {'name': 'dr. Fitri Handayani, Sp.Rad', 'specialty': 'RADIOLOGI', 'nik': '1234567896', 'gender': 'Perempuan', 'title': 'Sp.Rad', 'email': 'fitri@hospital.com', 'phone': '081234567896', 'photoAsset': 'assets/dokter/doctor4.png'},
        {'name': 'dr. Hendra Wijaya, Sp.PD', 'specialty': 'DALAM', 'nik': '1234567897', 'gender': 'Laki-laki', 'title': 'Sp.PD', 'email': 'hendra@hospital.com', 'phone': '081234567897', 'photoAsset': 'assets/dokter/doctor6.jpg'},
        {'name': 'dr. Maya Indira, Sp.S', 'specialty': 'SARAF', 'nik': '1234567898', 'gender': 'Perempuan', 'title': 'Sp.S', 'email': 'maya@hospital.com', 'phone': '081234567898', 'photoAsset': 'assets/dokter/doctor5.png'},
      ];
    } else if (category == 'Dokter Umum') {
      doctorList = [
        {'name': 'dr. Budi Santoso', 'specialty': 'UMUM', 'nik': '2234567890', 'gender': 'Laki-laki', 'title': 'dr.', 'email': 'budi@hospital.com', 'phone': '082234567890', 'photoAsset': ''},
        {'name': 'dr. Lisa Permata', 'specialty': 'UMUM', 'nik': '2234567891', 'gender': 'Perempuan', 'title': 'dr.', 'email': 'lisa@hospital.com', 'phone': '082234567891', 'photoAsset': ''},
        {'name': 'dr. Eko Purnomo', 'specialty': 'UMUM', 'nik': '2234567892', 'gender': 'Laki-laki', 'title': 'dr.', 'email': 'eko@hospital.com', 'phone': '082234567892', 'photoAsset': ''},
        {'name': 'dr. Ratna Dewi', 'specialty': 'UMUM', 'nik': '2234567893', 'gender': 'Perempuan', 'title': 'dr.', 'email': 'ratna@hospital.com', 'phone': '082234567893', 'photoAsset': ''},
        {'name': 'dr. Agus Santoso', 'specialty': 'UMUM', 'nik': '2234567894', 'gender': 'Laki-laki', 'title': 'dr.', 'email': 'agus@hospital.com', 'phone': '082234567894', 'photoAsset': ''},
      ];
    } else if (category == 'Perawat') {
      doctorList = [
        {'name': 'Ns. Maria Gonzales', 'specialty': 'PERAWAT IGD', 'nik': '3234567890', 'gender': 'Perempuan', 'title': 'Ns.', 'email': 'maria@hospital.com', 'phone': '083234567890', 'photoAsset': ''},
        {'name': 'Ns. Siti Nurhaliza', 'specialty': 'PERAWAT RAWAT INAP', 'nik': '3234567891', 'gender': 'Perempuan', 'title': 'Ns.', 'email': 'siti@hospital.com', 'phone': '083234567891', 'photoAsset': ''},
        {'name': 'Ns. Dewi Lestari', 'specialty': 'PERAWAT ICU', 'nik': '3234567892', 'gender': 'Perempuan', 'title': 'Ns.', 'email': 'dewi@hospital.com', 'phone': '083234567892', 'photoAsset': ''},
        {'name': 'Ns. Rudi Hermawan', 'specialty': 'PERAWAT OK', 'nik': '3234567893', 'gender': 'Laki-laki', 'title': 'Ns.', 'email': 'rudi@hospital.com', 'phone': '083234567893', 'photoAsset': ''},
        {'name': 'Ns. Fitri Handayani', 'specialty': 'PERAWAT ANAK', 'nik': '3234567894', 'gender': 'Perempuan', 'title': 'Ns.', 'email': 'fitri@hospital.com', 'phone': '083234567894', 'photoAsset': ''},
      ];
    } else if (category == 'Bidan') {
      doctorList = [
        {'name': 'Bd. Lina Kartini', 'specialty': 'BIDAN VK', 'nik': '4234567890', 'gender': 'Perempuan', 'title': 'Bd.', 'email': 'lina@hospital.com', 'phone': '084234567890', 'photoAsset': ''},
        {'name': 'Bd. Maya Sari', 'specialty': 'BIDAN POLI KIA', 'nik': '4234567891', 'gender': 'Perempuan', 'title': 'Bd.', 'email': 'maya@hospital.com', 'phone': '084234567891', 'photoAsset': ''},
        {'name': 'Bd. Dian Permata', 'specialty': 'BIDAN NIFAS', 'nik': '4234567892', 'gender': 'Perempuan', 'title': 'Bd.', 'email': 'dian@hospital.com', 'phone': '084234567892', 'photoAsset': ''},
        {'name': 'Bd. Agung Nugroho', 'specialty': 'BIDAN KB', 'nik': '4234567893', 'gender': 'Laki-laki', 'title': 'Bd.', 'email': 'agung@hospital.com', 'phone': '084234567893', 'photoAsset': ''},
        {'name': 'Bd. Yanto Pratama', 'specialty': 'BIDAN PERSALINAN', 'nik': '4234567894', 'gender': 'Laki-laki', 'title': 'Bd.', 'email': 'yanto@hospital.com', 'phone': '084234567894', 'photoAsset': ''},
      ];
    } else if (category == 'Apoteker') {
      doctorList = [
        {'name': 'Ahmad Suryadi', 'specialty': 'Apoteker', 'nik': '5234567890', 'gender': 'Laki-laki', 'title': 'Apt.', 'email': 'ahmad@hospital.com', 'phone': '085234567890', 'photoAsset': ''},
        {'name': 'Maria Gonzales', 'specialty': 'Apoteker', 'nik': '5234567891', 'gender': 'Perempuan', 'title': 'Apt.', 'email': 'maria@hospital.com', 'phone': '085234567891', 'photoAsset': ''},
        {'name': 'Dewi Lestari', 'specialty': 'Apoteker', 'nik': '5234567892', 'gender': 'Perempuan', 'title': 'Apt.', 'email': 'dewi@hospital.com', 'phone': '085234567892', 'photoAsset': ''},
        {'name': 'Agung Nugroho', 'specialty': 'Apoteker', 'nik': '5234567893', 'gender': 'Laki-laki', 'title': 'Apt.', 'email': 'agung@hospital.com', 'phone': '085234567893', 'photoAsset': ''},
        {'name': 'Hendra Kusuma', 'specialty': 'Apoteker', 'nik': '5234567894', 'gender': 'Laki-laki', 'title': 'Apt.', 'email': 'hendra@hospital.com', 'phone': '085234567894', 'photoAsset': ''},
      ];
    } else if (category == 'Staff') {
      doctorList = [
        {'name': 'Siti Nurhaliza', 'specialty': 'Admin', 'nik': '6234567890', 'gender': 'Perempuan', 'title': '', 'email': 'siti@hospital.com', 'phone': '086234567890', 'photoAsset': ''},
        {'name': 'Indra Wijaya', 'specialty': 'Teknisi', 'nik': '6234567891', 'gender': 'Laki-laki', 'title': '', 'email': 'indra@hospital.com', 'phone': '086234567891', 'photoAsset': ''},
        {'name': 'Budi Santoso', 'specialty': 'Security', 'nik': '6234567892', 'gender': 'Laki-laki', 'title': '', 'email': 'budi@hospital.com', 'phone': '086234567892', 'photoAsset': ''},
        {'name': 'Anita Sari', 'specialty': 'Cleaning Service', 'nik': '6234567893', 'gender': 'Perempuan', 'title': '', 'email': 'anita@hospital.com', 'phone': '086234567893', 'photoAsset': ''},
        {'name': 'Yanto Pratama', 'specialty': 'IT Support', 'nik': '6234567894', 'gender': 'Laki-laki', 'title': '', 'email': 'yanto@hospital.com', 'phone': '086234567894', 'photoAsset': ''},
      ];
    }
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Daftar $category',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: color,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color,
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: ${doctorList.length} orang',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Klik pada nama untuk melihat detail',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: doctorList.length,
              itemBuilder: (context, index) {
                final doctor = doctorList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetailScreen(
                            name: doctor['name'],
                            specialty: doctor['specialty'],
                            category: category,
                            isMedical: category != 'Staff' && category != 'Apoteker',
                            nik: doctor['nik'],
                            gender: doctor['gender'],
                            title: doctor['title'],
                            email: doctor['email'],
                            phone: doctor['phone'],
                            photoAsset: doctor['photoAsset'] ?? '',
                          ),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: color, width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: doctor['photoAsset'] != null && doctor['photoAsset'].isNotEmpty
                                  ? Image.asset(
                                      doctor['photoAsset'],
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: color.withOpacity(0.1),
                                          child: Center(
                                            child: Text(
                                              doctor['name'].toString().isNotEmpty 
                                                  ? doctor['name'].toString()[0].toUpperCase() 
                                                  : '?',
                                              style: TextStyle(
                                                color: color,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      color: color.withOpacity(0.1),
                                      child: Center(
                                        child: Text(
                                          doctor['name'].toString().isNotEmpty 
                                              ? doctor['name'].toString()[0].toUpperCase() 
                                              : '?',
                                          style: TextStyle(
                                            color: color,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  doctor['name'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  doctor['specialty'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.grey[400],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Doctor Detail Screen
class DoctorDetailScreen extends StatefulWidget {
  final String name;
  final String specialty;
  final String category;
  final bool isMedical;
  final String? nik;
  final String? gender;
  final String? title;
  final String? email;
  final String? phone;
  final String? photoAsset;
  
  const DoctorDetailScreen({
    Key? key,
    required this.name,
    required this.specialty,
    required this.category,
    required this.isMedical,
    this.nik,
    this.gender,
    this.title,
    this.email,
    this.phone,
    this.photoAsset,
  }) : super(key: key);
  
  @override
  State<DoctorDetailScreen> createState() => _DoctorDetailScreenState();
}

class _DoctorDetailScreenState extends State<DoctorDetailScreen> {
  late TextEditingController _nameController;
  late TextEditingController _specialtyController;
  late TextEditingController _nikController;
  late TextEditingController _genderController;
  late TextEditingController _titleController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _isEditing = false;
  
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _specialtyController = TextEditingController(text: widget.specialty);
    _nikController = TextEditingController(text: widget.nik ?? '');
    _genderController = TextEditingController(text: widget.gender ?? '');
    _titleController = TextEditingController(text: widget.title ?? '');
    _emailController = TextEditingController(text: widget.email ?? '');
    _phoneController = TextEditingController(text: widget.phone ?? '');
  }
  
  @override
  void dispose() {
    _nameController.dispose();
    _specialtyController.dispose();
    _nikController.dispose();
    _genderController.dispose();
    _titleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    Color categoryColor = const {
      'Dokter Spesialis': Color(0xFF2563EB),
      'Dokter Umum': Color(0xFF3B82F6),
      'Perawat': Color(0xFF10B981),
      'Bidan': Color(0xFF8B5CF6),
      'Apoteker': Color(0xFFF59E0B),
      'Staff': Color(0xFFEC4899),
    }[widget.category] ?? const Color(0xFF64748B);
    
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text(
          'Detail ${widget.category}',
          style: const TextStyle(
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF6B7280), size: 22),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: Material(
              color: _isEditing ? categoryColor : Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                  
                  if (!_isEditing) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Data berhasil disimpan'),
                        backgroundColor: Colors.green[600],
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _isEditing ? Icons.check : Icons.edit_outlined,
                        color: _isEditing ? Colors.white : Color(0xFF6B7280),
                        size: 18,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _isEditing ? 'Simpan' : 'Edit',
                        style: TextStyle(
                          color: _isEditing ? Colors.white : Color(0xFF6B7280),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    // Profile Picture with Status
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: categoryColor.withOpacity(0.2),
                              width: 4,
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[50],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: widget.photoAsset != null && widget.photoAsset!.isNotEmpty
                                  ? Image.asset(
                                      widget.photoAsset!,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return _buildInitialsAvatar(categoryColor);
                                      },
                                    )
                                  : _buildInitialsAvatar(categoryColor),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green[500],
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.green.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Text(
                              'Aktif',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Name Field
                    _isEditing
                        ? _buildEditableField(
                            controller: _nameController,
                            hint: 'Nama Lengkap',
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          )
                        : Text(
                            _nameController.text,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF111827),
                              letterSpacing: -0.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                    
                    const SizedBox(height: 8),
                    
                    // Specialty/Position Field
                    _isEditing
                        ? _buildEditableField(
                            controller: _specialtyController,
                            hint: widget.isMedical ? 'Spesialisasi' : 'Posisi',
                            fontSize: 14,
                          )
                        : Text(
                            _specialtyController.text,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6B7280),
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                    
                    const SizedBox(height: 20),
                    
                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: categoryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: categoryColor.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _getCategoryIcon(widget.category),
                            color: categoryColor,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.category,
                            style: TextStyle(
                              color: categoryColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Personal Information Card
            _buildInfoCard(
              title: 'Informasi Personal',
              icon: Icons.person_outline,
              categoryColor: categoryColor,
              child: Column(
                children: [
                  _buildInfoRow(
                    label: 'NIK',
                    controller: _nikController,
                    icon: Icons.badge_outlined,
                    isEditing: _isEditing,
                  ),
                  _buildInfoRow(
                    label: 'Jenis Kelamin',
                    controller: _genderController,
                    icon: Icons.wc_outlined,
                    isEditing: _isEditing,
                  ),
                  _buildInfoRow(
                    label: 'Gelar',
                    controller: _titleController,
                    icon: Icons.school_outlined,
                    isEditing: _isEditing,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Contact Information Card
            _buildInfoCard(
              title: 'Informasi Kontak',
              icon: Icons.contact_phone_outlined,
              categoryColor: categoryColor,
              child: Column(
                children: [
                  _buildInfoRow(
                    label: 'Email',
                    controller: _emailController,
                    icon: Icons.email_outlined,
                    isEditing: _isEditing,
                    isEmail: true,
                  ),
                  _buildInfoRow(
                    label: 'Telp/No.HP',
                    controller: _phoneController,
                    icon: Icons.phone_outlined,
                    isEditing: _isEditing,
                    isPhone: true,
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Schedule Card
            _buildScheduleCard(categoryColor),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildInitialsAvatar(Color categoryColor) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            categoryColor.withOpacity(0.1),
            categoryColor.withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Text(
          widget.name.isNotEmpty ? widget.name[0].toUpperCase() : '?',
          style: TextStyle(
            color: categoryColor,
            fontWeight: FontWeight.w600,
            fontSize: 36,
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required TextEditingController controller,
    required String hint,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: const Color(0xFF111827),
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    required IconData icon,
    required Color categoryColor,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: categoryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required bool isEditing,
    bool isEmail = false,
    bool isPhone = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: Colors.grey[600],
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                isEditing
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: TextField(
                          controller: controller,
                          keyboardType: isEmail
                              ? TextInputType.emailAddress
                              : isPhone
                                  ? TextInputType.phone
                                  : TextInputType.text,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFF111827),
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                        ),
                      )
                    : Text(
                        controller.text.isEmpty ? '-' : controller.text,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF111827),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleCard(Color categoryColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: categoryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.schedule_outlined,
                    color: categoryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                const Text(
                  'Jadwal Praktek',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF111827),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Schedule List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: categoryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.today_outlined,
                          color: categoryColor,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Senin, ${index + 10} September 2025',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF111827),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '08:00 - 16:00 WIB',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey[400],
                        size: 16,
                      ),
                    ],
                  ),
                );
              },
            ),
            
            const SizedBox(height: 20),
            
            // Add Schedule Button
            SizedBox(
              width: double.infinity,
              child: Material(
                color: categoryColor,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    // Add schedule logic
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Tambah Jadwal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method untuk mendapatkan icon kategori
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Dokter Spesialis':
        return Icons.local_hospital;
      case 'Dokter Umum':
        return Icons.medical_services;
      case 'Perawat':
        return Icons.favorite;
      case 'Bidan':
        return Icons.child_care;
      case 'Apoteker':
        return Icons.medication;
      case 'Staff':
        return Icons.work;
      default:
        return Icons.person;
    }
  }
  
  Widget _buildInfoField({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    bool isEmail = false,
    bool isPhone = false,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.grey[600],
                size: 16,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        isEditing
            ? TextField(
                controller: controller,
                keyboardType: isEmail
                    ? TextInputType.emailAddress
                    : isPhone
                        ? TextInputType.phone
                        : TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                style: const TextStyle(fontSize: 14),
              )
            : Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  controller.text.isNotEmpty ? controller.text : '-',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ),
      ],
    );
  }
}

// Doctor Schedule class
class DoctorSchedule {
  final String name;
  final String specialty;
  final String startTime;
  final String endTime;
  final String photoAsset;
  
  DoctorSchedule({
    required this.name,
    required this.specialty,
    required this.startTime,
    required this.endTime,
    this.photoAsset = '',
  });
}

// Staff Schedule class
class StaffSchedule {
  final String name;
  final String position;
  final String startTime;
  final String endTime;
  final String photoAsset;
  
  StaffSchedule({
    required this.name,
    required this.position,
    required this.startTime,
    required this.endTime,
    this.photoAsset = '',
  });
}

// Categorized Doctor Schedule class
class CategorizedDoctorSchedule extends DoctorSchedule {
  final String category;
  
  CategorizedDoctorSchedule({
    required String name,
    required String specialty,
    required String startTime,
    required String endTime,
    required this.category,
    String photoAsset = '',
  }) : super(
    name: name,
    specialty: specialty,
    startTime: startTime,
    endTime: endTime,
    photoAsset: photoAsset,
  );
}

// Categorized Staff Schedule class
class CategorizedStaffSchedule extends StaffSchedule {
  final String category;
  
  CategorizedStaffSchedule({
    required String name,
    required String position,
    required String startTime,
    required String endTime,
    required this.category,
    String photoAsset = ''
  }) : super(
    name: name,
    position: position,
    startTime: startTime,
    endTime: endTime,
    photoAsset: photoAsset,
  );
}

// Meeting class for appointments
class Meeting {
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
    this.category = '',
  });
  
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  String category;
}

// Data source for Syncfusion Calendar
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> meetings) {
    appointments = meetings;
  }
  
  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }
  
  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }
  
  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }
  
  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}