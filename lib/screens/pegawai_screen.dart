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
    'Dokter Spesialis': 177,
    'Dokter Umum': 54,
    'Perawat': 611,
    'Bidan': 129,
    'Apoteker': 20,
    'Staff': 688,
  };
  
  // Warna untuk setiap kategori
  final Map<String, Color> categoryColors = {
    'Dokter Spesialis': Color(0xFF1E40AF), // Biru tua
    'Dokter Umum': Color(0xFF3B82F6),      // Biru
    'Perawat': Color(0xFF10B981),          // Hijau
    'Bidan': Color(0xFF8B5CF6),           // Ungu
    'Apoteker': Color(0xFFF59E0B),        // Kuning/Orange
    'Staff': Color(0xFF64748B),           // Abu-abu
  };
  
  // Data lengkap jadwal petugas medis berdasarkan kategori
  final Map<String, Map<DateTime, List<DoctorSchedule>>> medicalScheduleByCategory = {
    'Dokter Spesialis': {
      DateTime(2025, 9, 1): [
        DoctorSchedule(name: 'dr. Yusmaldi, Sp.B-KBD', specialty: 'BEDAH DIGESTIF', startTime: '07:30', endTime: '14:00', photoAsset: 'assets/dokter/doctor1.png'),
        DoctorSchedule(name: 'dr. Alfita Hilranti, Sp.KJ, M.MR', specialty: 'JIWA', startTime: '07:30', endTime: '12:00'),
      ],
      DateTime(2025, 9, 3): [
        DoctorSchedule(name: 'dr. YULISMA, Sp.OVG, FINSDV, FAADV', specialty: 'KULIT KELAMIN', startTime: '07:30', endTime: '12:00'),
        DoctorSchedule(name: 'dr. Mizar Erlanto, Sp.B(K)Onk', specialty: 'BEDAH ONKOLOGI', startTime: '07:30', endTime: '15:00'),
      ],
      DateTime(2025, 9, 5): [
        DoctorSchedule(name: 'dr. Ahmad Rahman, Sp.JP', specialty: 'JANTUNG', startTime: '08:00', endTime: '15:00'),
        DoctorSchedule(name: 'dr. Siti Aminah, Sp.M', specialty: 'MATA', startTime: '08:00', endTime: '13:00'),
      ],
      DateTime(2025, 9, 9): [
        DoctorSchedule(name: 'dr. Fitri Handayani, Sp.Rad', specialty: 'RADIOLOGI', startTime: '08:00', endTime: '15:00'),
      ],
      DateTime(2025, 9, 15): [
        DoctorSchedule(name: 'dr. Hendra Wijaya, Sp.PD', specialty: 'DALAM', startTime: '07:30', endTime: '12:00'),
        DoctorSchedule(name: 'dr. Maya Indira, Sp.S', specialty: 'SARAF', startTime: '08:00', endTime: '14:00', photoAsset: 'assets/dokter/doctor1.png'),
      ],
    },
    'Dokter Umum': {
      DateTime(2025, 9, 2): [
        DoctorSchedule(name: 'dr. Budi Santoso', specialty: 'UMUM', startTime: '08:00', endTime: '16:00'),
        DoctorSchedule(name: 'dr. Lisa Permata', specialty: 'UMUM', startTime: '07:30', endTime: '15:30'),
      ],
      DateTime(2025, 9, 4): [
        DoctorSchedule(name: 'dr. Eko Purnomo', specialty: 'UMUM', startTime: '08:00', endTime: '16:00'),
      ],
      DateTime(2025, 9, 6): [
        DoctorSchedule(name: 'dr. Ratna Dewi', specialty: 'UMUM', startTime: '07:30', endTime: '15:30'),
        DoctorSchedule(name: 'dr. Agus Santoso', specialty: 'UMUM', startTime: '08:00', endTime: '16:00'),
      ],
      DateTime(2025, 9, 10): [
        DoctorSchedule(name: 'dr. Nanda Pratama', specialty: 'UMUM', startTime: '08:00', endTime: '16:00'),
      ],
      DateTime(2025, 9, 18): [
        DoctorSchedule(name: 'dr. Indah Sari', specialty: 'UMUM', startTime: '07:30', endTime: '15:30'),
        DoctorSchedule(name: 'dr. Yudi Pranata', specialty: 'UMUM', startTime: '08:00', endTime: '16:00'),
      ],
    },
    'Perawat': {
      DateTime(2025, 9, 1): [
        DoctorSchedule(name: 'Ns. Maria Gonzales', specialty: 'PERAWAT IGD', startTime: '07:00', endTime: '19:00'),
        DoctorSchedule(name: 'Ns. Siti Nurhaliza', specialty: 'PERAWAT RAWAT INAP', startTime: '19:00', endTime: '07:00'),
      ],
      DateTime(2025, 9, 7): [
        DoctorSchedule(name: 'Ns. Dewi Lestari', specialty: 'PERAWAT ICU', startTime: '07:00', endTime: '19:00'),
        DoctorSchedule(name: 'Ns. Rudi Hermawan', specialty: 'PERAWAT OK', startTime: '08:00', endTime: '16:00'),
      ],
      DateTime(2025, 9, 12): [
        DoctorSchedule(name: 'Ns. Fitri Handayani', specialty: 'PERAWAT ANAK', startTime: '07:00', endTime: '19:00'),
        DoctorSchedule(name: 'Ns. Bambang Susilo', specialty: 'PERAWAT JIWA', startTime: '19:00', endTime: '07:00'),
      ],
      DateTime(2025, 9, 20): [
        DoctorSchedule(name: 'Ns. Rina Marlina', specialty: 'PERAWAT BEDAH', startTime: '07:00', endTime: '19:00'),
        DoctorSchedule(name: 'Ns. Hendra Kusuma', specialty: 'PERAWAT POLI', startTime: '08:00', endTime: '16:00'),
      ],
    },
    'Bidan': {
      DateTime(2025, 9, 4): [
        DoctorSchedule(name: 'Bd. Lina Kartini', specialty: 'BIDAN VK', startTime: '07:00', endTime: '19:00'),
      ],
      DateTime(2025, 9, 6): [
        DoctorSchedule(name: 'Bd. Maya Sari', specialty: 'BIDAN POLI KIA', startTime: '08:00', endTime: '16:00'),
        DoctorSchedule(name: 'Bd. Dian Permata', specialty: 'BIDAN NIFAS', startTime: '19:00', endTime: '07:00'),
      ],
      DateTime(2025, 9, 10): [
        DoctorSchedule(name: 'Bd. Agung Nugroho', specialty: 'BIDAN KB', startTime: '08:00', endTime: '16:00'),
      ],
      DateTime(2025, 9, 15): [
        DoctorSchedule(name: 'Bd. Yanto Pratama', specialty: 'BIDAN PERSALINAN', startTime: '07:00', endTime: '19:00'),
      ],
    },
  };
  
  // Data jadwal petugas non medis berdasarkan kategori
  final Map<String, Map<DateTime, List<StaffSchedule>>> nonMedicalScheduleByCategory = {
    'Apoteker': {
      DateTime(2025, 9, 1): [
        StaffSchedule(name: 'Ahmad Suryadi', position: 'Apoteker', startTime: '08:00', endTime: '16:00'),
      ],
      DateTime(2025, 9, 3): [
        StaffSchedule(name: 'Maria Gonzales', position: 'Apoteker', startTime: '08:00', endTime: '16:00'),
        StaffSchedule(name: 'Dewi Lestari', position: 'Apoteker', startTime: '16:00', endTime: '24:00'),
      ],
      DateTime(2025, 9, 7): [
        StaffSchedule(name: 'Rina Marlina', position: 'Apoteker', startTime: '08:00', endTime: '16:00'),
      ],
      DateTime(2025, 9, 12): [
        StaffSchedule(name: 'Agung Nugroho', position: 'Apoteker', startTime: '08:00', endTime: '16:00'),
        StaffSchedule(name: 'Fitri Handayani', position: 'Apoteker', startTime: '16:00', endTime: '24:00'),
      ],
      DateTime(2025, 9, 18): [
        StaffSchedule(name: 'Hendra Kusuma', position: 'Apoteker', startTime: '08:00', endTime: '16:00'),
      ],
    },
    'Staff': {
      DateTime(2025, 9, 2): [
        StaffSchedule(name: 'Siti Nurhaliza', position: 'Admin', startTime: '07:30', endTime: '15:30'),
        StaffSchedule(name: 'Indra Wijaya', position: 'Teknisi', startTime: '08:00', endTime: '16:00'),
      ],
      DateTime(2025, 9, 5): [
        StaffSchedule(name: 'Budi Santoso', position: 'Security', startTime: '06:00', endTime: '18:00'),
        StaffSchedule(name: 'Anita Sari', position: 'Cleaning Service', startTime: '06:00', endTime: '14:00'),
      ],
      DateTime(2025, 9, 10): [
        StaffSchedule(name: 'Yanto Pratama', position: 'IT Support', startTime: '08:00', endTime: '17:00'),
        StaffSchedule(name: 'Lina Kartini', position: 'Admin', startTime: '07:30', endTime: '15:30'),
      ],
      DateTime(2025, 9, 15): [
        StaffSchedule(name: 'Maya Sari', position: 'Nutritionist', startTime: '08:00', endTime: '15:00'),
        StaffSchedule(name: 'Dian Permata', position: 'Admin', startTime: '07:30', endTime: '15:30'),
      ],
      DateTime(2025, 9, 20): [
        StaffSchedule(name: 'Bambang Susilo', position: 'Maintenance', startTime: '08:00', endTime: '16:00'),
        StaffSchedule(name: 'Rudi Hermawan', position: 'Driver', startTime: '07:00', endTime: '15:00'),
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
            accentColor: const Color(0xFF059669),
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
                photoAsset: schedule.photoAsset, // Tambahkan ini
              );
            } else if (schedule is StaffSchedule) {
              return CategorizedStaffSchedule(
                name: schedule.name,
                position: schedule.position,
                startTime: schedule.startTime,
                endTime: schedule.endTime,
                category: category,
                photoAsset: schedule.photoAsset, // Tambahkan ini
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
                photoAsset: schedule.photoAsset, // Tambahkan ini
              );
            } else if (schedule is StaffSchedule) {
              return CategorizedStaffSchedule(
                name: schedule.name,
                position: schedule.position,
                startTime: schedule.startTime,
                endTime: schedule.endTime,
                category: category,
                photoAsset: schedule.photoAsset, // Tambahkan ini
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
              photoAsset: schedule.photoAsset, // Tambahkan ini
            );
          } else if (schedule is StaffSchedule) {
            return CategorizedStaffSchedule(
              name: schedule.name,
              position: schedule.position,
              startTime: schedule.startTime,
              endTime: schedule.endTime,
              category: selectedFilter,
              photoAsset: schedule.photoAsset, // Tambahkan ini
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
                  scrollDirection: Axis.horizontal, // Horizontal scroll utama
                  child: Container(
                    width: 800, // Fixed width untuk table yang lebar
                    child: Column(
                      children: [
                        // Table Header
                        Container(
                          color: Colors.grey[100],
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          child: Row(
                            children: [
                              // No column
                              Container(
                                width: 50,
                                alignment: Alignment.center,
                                child: const Text(
                                  'No',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Category indicator
                              Container(
                                width: 40,
                                alignment: Alignment.center,
                                child: const Text(
                                  '#',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Photo column
                              Container(
                                width: 100,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Foto',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Name column - lebih lebar
                              Container(
                                width: 200,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  isMedical ? 'Nama Dokter' : 'Nama Staff',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Specialty/Position column - lebih lebar
                              Container(
                                width: 180,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  isMedical ? 'Spesialis/Unit Layanan' : 'Posisi',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                              // Start time
                              Container(
                                width: 80,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Jam Mulai',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                              // End time
                              Container(
                                width: 80,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Jam Selesai',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // Scrollable content area
                        Expanded(
                          child: Container(
                            color: Colors.white, // Ganti ke putih
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical, // Vertical scroll untuk rows
                              child: Column(
                              children: schedules.asMap().entries.map((entry) {
                                int index = entry.key;
                                dynamic schedule = entry.value;
                                
                                // Get category and color
                                String category = '';
                                Color categoryColor = Colors.grey;
                                
                                if (schedule is CategorizedDoctorSchedule) {
                                  category = schedule.category;
                                  categoryColor = categoryColors[category] ?? Colors.grey;
                                } else if (schedule is CategorizedStaffSchedule) {
                                  category = schedule.category;
                                  categoryColor = categoryColors[category] ?? Colors.grey;
                                }
                                
                                return Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                                  decoration: BoxDecoration(
                                    color: Colors.white, // Semua row putih
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey[300]!),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // No
                                      Container(
                                        width: 50,
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      // Category color indicator
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
                                      // Photo
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
                                            child: schedule.photoAsset.isNotEmpty
                                                ? Image.asset(
                                                    schedule.photoAsset,
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
                                      // Name
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
                                      // Specialty/Position
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
                                      // Start time
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
                                      // End time
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
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          ), // Tutup Container
                        ), // Tutup Expanded
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
                  color: Colors.white, // Ganti ke putih
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
    
    return Container(
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
          // Staff type filter chips
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                // All filter
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
                // Individual category filters
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
          
          // Calendar navigation header
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
          
          // Calendar view
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
              // Pengaturan untuk tampilan minggu
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
              // Pengaturan header untuk tampilan minggu
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