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
  
  // Data statistik pegawai
  final Map<String, int> employeeStats = {
    'Dokter Spesialis': 177,
    'Dokter Umum': 54,
    'Perawat': 611,
    'Bidan': 129,
    'Apoteker': 20,
    'Staff': 688,
  };
  
  // Data jadwal petugas medis dengan detail dokter
  final Map<DateTime, List<DoctorSchedule>> medicalScheduleDetails = {
    DateTime(2025, 8, 1): [
      DoctorSchedule(name: 'dr. Yusmaldi, Sp.B-KBD', specialty: 'BEDAH DIGESTIF', startTime: '07:30', endTime: '14:00'),
      DoctorSchedule(name: 'dr. Alfita Hilranti, Sp.KJ, M.MR', specialty: 'JIWA', startTime: '07:30', endTime: '12:00'),
      DoctorSchedule(name: 'dr. M. TAUFIK PERWIRA W, Sp.A', specialty: 'ANAK', startTime: '07:30', endTime: '12:00'),
    ],
    DateTime(2025, 8, 2): [
      DoctorSchedule(name: 'dr. Yusmaldi, Sp.B-KBD', specialty: 'BEDAH DIGESTIF', startTime: '07:30', endTime: '14:00'),
      DoctorSchedule(name: 'dr. Alfita Hilranti, Sp.KJ, M.MR', specialty: 'JIWA', startTime: '07:30', endTime: '12:00'),
    ],
    DateTime(2025, 8, 3): [
      DoctorSchedule(name: 'dr. YULISMA, Sp.OVG, FINSDV, FAADV', specialty: 'KULIT KELAMIN', startTime: '07:30', endTime: '12:00'),
      DoctorSchedule(name: 'dr. Mizar Erlanto, Sp.B(K)Onk', specialty: 'BEDAH ONKOLOGI', startTime: '07:30', endTime: '15:00'),
      DoctorSchedule(name: 'dr. Irsan Kurniawan, drg, Sp.BM', specialty: 'GIGI BEDAH MULUT', startTime: '07:30', endTime: '12:00'),
    ],
    // Tambah data untuk tanggal lainnya...
  };
  
  // Data jadwal petugas medis
  final List<Meeting> medicalAppointments = [
    Meeting(
      eventName: '3 Jadwal',
      from: DateTime(2025, 8, 1),
      to: DateTime(2025, 8, 1),
      background: const Color(0xFF1E40AF),
    ),
    Meeting(
      eventName: '2 Jadwal',
      from: DateTime(2025, 8, 2),
      to: DateTime(2025, 8, 2),
      background: const Color(0xFF1E40AF),
    ),
    Meeting(
      eventName: '3 Jadwal',
      from: DateTime(2025, 8, 3),
      to: DateTime(2025, 8, 3),
      background: const Color(0xFF1E40AF),
    ),
    Meeting(
      eventName: '5 Jadwal',
      from: DateTime(2025, 8, 5),
      to: DateTime(2025, 8, 5),
      background: const Color(0xFF1E40AF),
    ),
    Meeting(
      eventName: '8 Jadwal',
      from: DateTime(2025, 8, 8),
      to: DateTime(2025, 8, 8),
      background: const Color(0xFF1E40AF),
    ),
    Meeting(
      eventName: '12 Jadwal',
      from: DateTime(2025, 8, 12),
      to: DateTime(2025, 8, 12),
      background: const Color(0xFF1E40AF),
    ),
    Meeting(
      eventName: '15 Jadwal',
      from: DateTime(2025, 8, 15),
      to: DateTime(2025, 8, 15),
      background: const Color(0xFF1E40AF),
    ),
    Meeting(
      eventName: '20 Jadwal',
      from: DateTime(2025, 8, 20),
      to: DateTime(2025, 8, 20),
      background: const Color(0xFF1E40AF),
    ),
  ];
  
  // Data jadwal petugas non medis dengan detail staff
  final Map<DateTime, List<StaffSchedule>> nonMedicalScheduleDetails = {
    DateTime(2025, 8, 31): [
      StaffSchedule(name: 'Ahmad Suryadi', position: 'Apoteker', startTime: '08:00', endTime: '16:00'),
      StaffSchedule(name: 'Siti Nurhaliza', position: 'Admin', startTime: '07:30', endTime: '15:30'),
      StaffSchedule(name: 'Budi Santoso', position: 'Teknisi', startTime: '08:00', endTime: '16:00'),
    ],
    DateTime(2025, 8, 1): [
      StaffSchedule(name: 'Maria Gonzales', position: 'Apoteker', startTime: '08:00', endTime: '16:00'),
      StaffSchedule(name: 'Indra Wijaya', position: 'Admin', startTime: '07:30', endTime: '15:30'),
    ],
  };
  
  // Data jadwal petugas non medis
  final List<Meeting> nonMedicalAppointments = [
    Meeting(
      eventName: '3 Jadwal',
      from: DateTime(2025, 8, 31),
      to: DateTime(2025, 8, 31),
      background: const Color(0xFF059669),
    ),
    Meeting(
      eventName: '2 Jadwal',
      from: DateTime(2025, 8, 1),
      to: DateTime(2025, 8, 1),
      background: const Color(0xFF059669),
    ),
    Meeting(
      eventName: '5 Jadwal',
      from: DateTime(2025, 8, 5),
      to: DateTime(2025, 8, 5),
      background: const Color(0xFF059669),
    ),
    Meeting(
      eventName: '8 Jadwal',
      from: DateTime(2025, 8, 10),
      to: DateTime(2025, 8, 10),
      background: const Color(0xFF059669),
    ),
    Meeting(
      eventName: '12 Jadwal',
      from: DateTime(2025, 8, 15),
      to: DateTime(2025, 8, 15),
      background: const Color(0xFF059669),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _medicalCalendarController = CalendarController();
    _nonMedicalCalendarController = CalendarController();
    _medicalCalendarController.displayDate = DateTime(2025, 8);
    _nonMedicalCalendarController.displayDate = DateTime(2025, 8);
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
            appointments: medicalAppointments,
            accentColor: const Color(0xFF1E40AF),
            staffTypes: const ['Dokter Spesialis', 'Dokter Umum', 'Perawat', 'Bidan'],
            controller: _medicalCalendarController,
            scheduleDetails: medicalScheduleDetails,
            isMedical: true,
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
            appointments: nonMedicalAppointments,
            accentColor: const Color(0xFF059669),
            staffTypes: const ['Apoteker', 'Staff'],
            controller: _nonMedicalCalendarController,
            scheduleDetails: nonMedicalScheduleDetails,
            isMedical: false,
          ),
        ],
      ),
    );
  }

  void _showScheduleDetail(DateTime date, List<dynamic> schedules, bool isMedical) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.7,
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
                              isMedical ? 'Daftar Jadwal Spesialis' : 'Daftar Jadwal Staff',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tanggal: ${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close, color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
                // Content
                Flexible(
                  child: Container(
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Table Header
                          Container(
                            color: Colors.grey[100],
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 30,
                                  child: Text(
                                    'No',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const SizedBox(
                                  width: 20,
                                  child: Text(
                                    '#',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    isMedical ? 'Nama Dokter' : 'Nama Staff',
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    isMedical ? 'Spesialis Unit Layanan' : 'Posisi',
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                  child: Text(
                                    'Mulai',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const SizedBox(
                                  width: 40,
                                  child: Text(
                                    'Selesai',
                                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Table Content
                          ...schedules.asMap().entries.map((entry) {
                            int index = entry.key;
                            dynamic schedule = entry.value;
                            
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                color: index % 2 == 0 ? Colors.white : Colors.grey[50],
                                border: Border(
                                  bottom: BorderSide(color: Colors.grey[200]!),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 30,
                                    child: Text(
                                      '${index + 1}',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const SizedBox(
                                    width: 20,
                                    child: Text(
                                      '',
                                      style: TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      schedule.name,
                                      style: const TextStyle(fontSize: 10),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      isMedical ? (schedule as DoctorSchedule).specialty : (schedule as StaffSchedule).position,
                                      style: const TextStyle(fontSize: 10),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: Text(
                                      schedule.startTime,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SizedBox(
                                    width: 40,
                                    child: Text(
                                      schedule.endTime,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
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
    Color cardColor;
    IconData icon;
    
    switch (role) {
      case 'Dokter Spesialis':
        cardColor = const Color(0xFF1E40AF);
        icon = Icons.medical_services;
        break;
      case 'Dokter Umum':
        cardColor = const Color(0xFF3B82F6);
        icon = Icons.person;
        break;
      case 'Perawat':
        cardColor = const Color(0xFF10B981);
        icon = Icons.health_and_safety;
        break;
      case 'Bidan':
        cardColor = const Color(0xFF8B5CF6);
        icon = Icons.pregnant_woman;
        break;
      case 'Apoteker':
        cardColor = const Color(0xFFF59E0B);
        icon = Icons.medication;
        break;
      default:
        cardColor = const Color(0xFF64748B);
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
          // Staff type chips
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: staffTypes.map((type) {
                Color chipColor;
                
                switch (type) {
                  case 'Dokter Spesialis':
                    chipColor = const Color(0xFF1E40AF);
                    break;
                  case 'Dokter Umum':
                    chipColor = const Color(0xFF3B82F6);
                    break;
                  case 'Perawat':
                    chipColor = const Color(0xFF10B981);
                    break;
                  case 'Bidan':
                    chipColor = const Color(0xFF8B5CF6);
                    break;
                  case 'Apoteker':
                    chipColor = const Color(0xFFF59E0B);
                    break;
                  default:
                    chipColor = const Color(0xFF059669);
                }
                
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: chipColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    type,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
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
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'Month',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Week',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
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
            height: 240,
            child: SfCalendar(
              controller: controller,
              view: CalendarView.month,
              initialDisplayDate: DateTime(2025, 8),
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
                appointmentDisplayCount: 1,
                monthCellStyle: MonthCellStyle(
                  backgroundColor: Colors.transparent,
                  todayBackgroundColor: Colors.transparent,
                  todayTextStyle: TextStyle(
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textStyle: const TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                  trailingDatesTextStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                  leadingDatesTextStyle: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ),
              headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: Colors.transparent,
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              viewHeaderStyle: ViewHeaderStyle(
                backgroundColor: Colors.grey[100],
                dayTextStyle: TextStyle(
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                ),
              ),
              appointmentBuilder: (context, calendarAppointmentDetails) {
                final Meeting meeting = calendarAppointmentDetails.appointments.first;
                return Container(
                  margin: const EdgeInsets.all(1),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                  decoration: BoxDecoration(
                    color: meeting.background,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    meeting.eventName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
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
  
  DoctorSchedule({
    required this.name,
    required this.specialty,
    required this.startTime,
    required this.endTime,
  });
}

// Staff Schedule class
class StaffSchedule {
  final String name;
  final String position;
  final String startTime;
  final String endTime;
  
  StaffSchedule({
    required this.name,
    required this.position,
    required this.startTime,
    required this.endTime,
  });
}

// Meeting class for appointments
class Meeting {
  Meeting({
    required this.eventName,
    required this.from,
    required this.to,
    required this.background,
  });
  
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
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