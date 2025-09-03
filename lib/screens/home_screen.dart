import 'package:flutter/material.dart';
import 'package:inocare/screens/billingpayment_screen.dart';
import 'package:inocare/screens/dashboard.dart';
import 'package:inocare/screens/emergency_protocols_screen.dart';
import 'package:inocare/screens/ermperawat_screen.dart';
import 'package:inocare/screens/ermdoctor_screen.dart';
import 'package:inocare/screens/feedback_screen.dart';
import 'package:inocare/screens/healthanalytics_screen.dart';
import 'package:inocare/screens/healthfacilities_screen.dart';
import 'package:inocare/screens/manajemen_bed.dart';
import 'package:inocare/screens/medical_equipment.dart';
import 'package:inocare/screens/patient_records_screen.dart';
import 'package:inocare/screens/patientmonitoring_screen.dart';
import 'package:inocare/screens/pegawai_screen.dart';
import 'package:inocare/screens/rekam_medik_screen.dart';
import 'package:inocare/screens/shift_screen.dart';
import 'package:inocare/screens/staff_screen.dart';
import '../data/app_data.dart';
import '../widgets/top_header_section.dart';
import '../widgets/quick_access_card.dart';
import '../screens/doctor_list.dart';
import '../screens/appointment_screen.dart';
import '../screens/prescription_screen.dart';
import '../data/appointment_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _showAllQuickAccess = false;
  late ScrollController _scrollController;
  late AnimationController _fadeController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.offset >= 300) {
          if (!_fadeController.isAnimating && _fadeController.status != AnimationStatus.forward) {
            _fadeController.forward();
          }
        } else {
          if (!_fadeController.isAnimating && _fadeController.status != AnimationStatus.reverse) {
            _fadeController.reverse();
          }
        }
      });
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1E1E2C) : const Color(0xFFF3F4F6);
    final cardColor = isDark ? const Color(0xFF2D2D44) : Colors.white;
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            const MedicalTopHeaderSection(),
            Transform.translate(
              offset: const Offset(0, -50),
              child: _buildQuickAccessGrid(cardColor, primaryColor),
            ),
          ],
        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: _fadeController,
          curve: Curves.easeOutCubic,
        )),
        child: FadeTransition(
          opacity: _fadeController,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withOpacity(0.7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: FloatingActionButton(
              onPressed: _scrollToTop,
              backgroundColor: Colors.transparent,
              elevation: 0,
              highlightElevation: 0,
              shape: const CircleBorder(),
              splashColor: Colors.white.withOpacity(0.3),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccessGrid(Color cardColor, Color primaryColor) {
    final displayedItems = _showAllQuickAccess ? quickAccessItems : quickAccessItems.take(9).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        color: cardColor,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: displayedItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.85,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  final item = displayedItems[index];
                  return Align(
                    alignment: Alignment.topCenter,
                    child: QuickAccessCard(
                      icon: item['icon'],
                      color: item['color'],
                      label: item['label'],
                      onTap: () {
                        switch (item['label']) {
                          case 'Doctor':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DoctorListScreen(),
                              ),
                            );
                            break;
                          case 'Appointments':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AppointmentCalendarScreen(),
                              ),
                            );
                            break;
                          case 'Prescription Management':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PrescriptionManagementScreen(),
                              ),
                            );
                            break;
                          case 'Emergency Protocols':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const EmergencyProtocolsScreen(),
                              ),
                            );
                            break;
                          case 'Medical Equipment':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MedicalEquipmentScreen(),
                              ),
                            );
                            break;
                          case 'Health Facilities':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HealthFacilitiesScreen(),
                              ),
                            );
                            break;
                          case 'Patient Records':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PatientRecordsScreen(
                                  appointments: appointmentsData,
                                ),
                              ),
                            );
                            break;
                          case 'Billing & Payments':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const BillingPaymentsScreen(),
                              ),
                            );
                            break;
                          case 'Health Analytics':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HealthAnalyticsScreen(),
                              ),
                            );
                            break;
                          case 'Patient Monitoring':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PatientMonitoring(),
                              ),
                            );
                            break;
                          case 'Feedback & Reviews':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const FeedbackList(),
                              ),
                            );
                            break;
                          case 'Shift Schedule':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ShiftSchedule(),
                              ),
                            );
                            break;
                          case 'Staff Directory':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const StaffDirectory(),
                              ),
                            );
                            break;
                          case 'ERM Doctor':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ErmDoctorPage(),
                              ),
                            );
                            break;
                          case 'ERM Perawat':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ErmPerawatScreen(),
                              ),
                            );
                            break;
                          case 'Dashboard & Reporting':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const DashboardReporting(),
                              ),
                            );
                            break;
                            case 'Kepegawaian':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const PegawaiScreen(),
                              ),
                            );
                            break;
<<<<<<< Updated upstream
                            case 'Manajemen Bed':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ManajemenBed(),
                              ),
                            );
                            break;
=======
>>>>>>> Stashed changes
                            case 'Rekam Medik':
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const RekamMedisPage(),
                              ),
                            );
                            break;
                          default:
                            print('Clicked: ${item['label']}');
                        }
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  setState(() {
                    _showAllQuickAccess = !_showAllQuickAccess;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _showAllQuickAccess ? 'See Less' : 'See All',
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    AnimatedRotation(
                      duration: const Duration(milliseconds: 300),
                      turns: _showAllQuickAccess ? 0.5 : 0,
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
