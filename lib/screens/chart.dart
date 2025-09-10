import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/pasien_transaksi.dart';
import '../widgets/pasien_service.dart';
import '../widgets/transaksi_service.dart';

class TransPage extends StatefulWidget {
  const TransPage({super.key});

  @override
  State<TransPage> createState() => _TransPageState();
}

class _TransPageState extends State<TransPage> with TickerProviderStateMixin {
  List<Pasien> pasienList = [];
  List<ChartData> barChartData = [];
  List<ChartData> pieChartData = [];
  List<ChartData> allBarChartData = [];
  bool loading = true;
  int? selectedPasienId;
  String? selectedMonth;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  // ===================== MONTH FORMAT =====================
  String formatMonth(String ym) {
    final parts = ym.split('-'); // contoh: ["2025", "08"]
    if (parts.length != 2) return ym;

    final year = parts[0];
    final month = parts[1];

    const monthNames = {
      "01": "Januari",
      "02": "Februari",
      "03": "Maret",
      "04": "April",
      "05": "Mei",
      "06": "Juni",
      "07": "Juli",
      "08": "Agustus",
      "09": "September",
      "10": "Oktober",
      "11": "November",
      "12": "Desember",
    };

    return "${monthNames[month] ?? ym} $year";
  }

  // ===================== MONTH LIST =====================
  final List<String> monthList = [
    'Semua',
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  // ===================== MONTH COLORS =====================
  final List<Color> monthColors = [
    Colors.blue.shade600,
    Colors.green.shade600,
    Colors.orange.shade600,
    Colors.purple.shade600,
    Colors.red.shade600,
    Colors.teal.shade600,
    Colors.amber.shade600,
    Colors.indigo.shade600,
    Colors.pink.shade600,
    Colors.cyan.shade600,
    Colors.lime.shade600,
    Colors.brown.shade600,
  ];

  @override
  void initState() {
    super.initState();
    selectedMonth = 'Semua';
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    fetchData();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    setState(() => loading = true);
    try {
      pasienList = await PasienService.getAllPasien();

      final firstValidPasien = pasienList.firstWhere(
        (p) => p.id > 0,
        orElse: () => pasienList.isNotEmpty ? pasienList.first : throw Exception("Tidak ada pasien valid"),
      );
      selectedPasienId = firstValidPasien.id;

      if (selectedPasienId != null && selectedPasienId! > 0) {
        await loadChart(selectedPasienId!);
      }
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
    setState(() => loading = false);
    _animationController.forward();
  }

  Future<void> loadChart(int pasienId) async {
    try {
      allBarChartData = await TransaksiService.getBarChart(pasienId);
      pieChartData = await TransaksiService.getPieChart(pasienId);
      filterBarChart();
    } catch (e) {
      debugPrint("Error fetching chart data: $e");
    }
  }

  // ===================== FILTER BAR CHART =====================
  void filterBarChart() {
    setState(() {
      if (selectedMonth == null || selectedMonth == 'Semua') {
        barChartData = allBarChartData;
      } else {
        barChartData = allBarChartData.where((data) {
          final formatted = formatMonth(data.bulan); // contoh: "Agustus 2025"
          return formatted.startsWith(selectedMonth!);
        }).toList();
      }
    });
  }

  Future<void> changePasien(int pasienId) async {
    setState(() {
      selectedPasienId = pasienId;
      barChartData = [];
      pieChartData = [];
      allBarChartData = [];
      loading = true;
    });
    await loadChart(pasienId);
    setState(() => loading = false);
    _animationController.reset();
    _animationController.forward();
  }

  void changeMonth(String? month) {
    if (month != null) {
      setState(() => selectedMonth = month);
      filterBarChart();
      _animationController.reset();
      _animationController.forward();
    }
  }

  // ===================== GET COLOR =====================
  Color getMonthColor(String ym) {
    final parts = ym.split('-');
    if (parts.length != 2) return Colors.blue.shade600;
    final month = parts[1];
    int index = int.tryParse(month) ?? 1;
    return monthColors[(index - 1) % monthColors.length];
  }

  // ===================== WIDGETS =====================
  Widget _buildStatsCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(0.8), color.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              Icon(Icons.trending_up, color: Colors.white.withOpacity(0.7), size: 16),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String month, Color color, int value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12, 
            height: 12, 
            decoration: BoxDecoration(
              color: color, 
              borderRadius: BorderRadius.circular(2)
            )
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              '${formatMonth(month)} ($value)',
              style: const TextStyle(
                fontSize: 12, 
                fontWeight: FontWeight.w500, 
                color: Colors.black87
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          "Dashboard Transaksi", 
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20)
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade100, 
              borderRadius: BorderRadius.circular(8)
            ),
            child: Icon(Icons.analytics_outlined, color: Colors.blue.shade700, size: 20),
          ),
        ],
      ),
      body: loading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Memuat data...",
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            )
          : pasienList.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.person_off_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Tidak ada data pasien",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Tambahkan pasien terlebih dahulu",
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                )
              : FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ==================== HEADER SECTION ====================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.blue.shade600, Colors.blue.shade400],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.dashboard_outlined,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    "Analytics Dashboard",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Dropdown Pasien
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    value: selectedPasienId,
                                    onChanged: (value) {
                                      if (value != null) changePasien(value);
                                    },
                                    dropdownColor: Colors.white,
                                    icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                                    isExpanded: true,
                                    hint: const Text(
                                      "Pilih Pasien",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    items: pasienList
                                        .where((p) => p.id > 0)
                                        .map((p) => DropdownMenuItem(
                                              value: p.id,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 8,
                                                    height: 8,
                                                    decoration: const BoxDecoration(
                                                      color: Colors.green,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Text(
                                                      p.name,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w500,
                                                        color: Colors.black87,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ))
                                        .toList(),
                                    selectedItemBuilder: (context) {
                                      return pasienList
                                          .where((p) => p.id > 0)
                                          .map((p) => Row(
                                                children: [
                                                  const Icon(Icons.person, color: Colors.white, size: 16),
                                                  const SizedBox(width: 8),
                                                  Expanded(
                                                    child: Text(
                                                      p.name,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ))
                                          .toList();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ==================== STATS CARDS ====================
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatsCard(
                                "Total Data",
                                barChartData.length.toString(),
                                Icons.bar_chart,
                                Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatsCard(
                                "Periode",
                                pieChartData.length.toString(),
                                Icons.pie_chart_outline,
                                Colors.green,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ==================== BAR CHART SECTION ====================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Bar Chart
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.bar_chart,
                                      color: Colors.blue.shade700,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    "Transaksi per Bulan",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Dropdown Filter Bulan
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade50,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: selectedMonth,
                                    onChanged: changeMonth,
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade600),
                                    hint: const Text("Pilih Bulan"),
                                    items: monthList.map((month) => DropdownMenuItem(
                                      value: month,
                                      child: Row(
                                        children: [
                                          Icon(
                                            month == 'Semua' ? Icons.calendar_view_month : Icons.calendar_today,
                                            size: 16,
                                            color: month == 'Semua' 
                                              ? Colors.blue.shade600 
                                              : monthColors[monthList.indexOf(month) - 1],
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            month,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Bar Chart
                              SizedBox(
                                height: 280,
                                child: barChartData.isEmpty
                                    ? Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.bar_chart_outlined,
                                              size: 48,
                                              color: Colors.grey.shade400,
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              selectedMonth == 'Semua' 
                                                ? "Tidak ada data transaksi"
                                                : "Tidak ada data untuk bulan $selectedMonth",
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : BarChart(
                                        BarChartData(
                                          alignment: BarChartAlignment.spaceAround,
                                          maxY: barChartData.isNotEmpty 
                                            ? (barChartData.map((e) => e.total).reduce((a, b) => a > b ? a : b)).toDouble() + 10
                                            : 10,
                                          barGroups: barChartData
                                              .asMap()
                                              .map((i, e) => MapEntry(
                                                    i,
                                                    BarChartGroupData(
                                                      x: i,
                                                      barRods: [
                                                        BarChartRodData(
                                                          toY: e.total.toDouble(),
                                                          gradient: LinearGradient(
                                                            colors: selectedMonth == 'Semua' 
                                                              ? [Colors.blue.shade400, Colors.blue.shade600]
                                                              : [
                                                                  getMonthColor(e.bulan).withOpacity(0.7), 
                                                                  getMonthColor(e.bulan)
                                                                ],
                                                            begin: Alignment.bottomCenter,
                                                            end: Alignment.topCenter,
                                                          ),
                                                          width: 24,
                                                          borderRadius: const BorderRadius.only(
                                                            topLeft: Radius.circular(6),
                                                            topRight: Radius.circular(6),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                              .values
                                              .toList(),
                                          titlesData: FlTitlesData(
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 40,
                                                getTitlesWidget: (value, meta) {
                                                  if (value.toInt() >= barChartData.length) return Container();
                                                  return Padding(
                                                    padding: const EdgeInsets.only(top: 8),
                                                    child: Text(
                                                      formatMonth(barChartData[value.toInt()].bulan),
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.grey.shade600,
                                                        fontWeight: FontWeight.w500,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 50,
                                                getTitlesWidget: (value, meta) {
                                                  return Text(
                                                    value.toInt().toString(),
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.grey.shade600,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                          ),
                                          borderData: FlBorderData(show: false),
                                          gridData: FlGridData(
                                            show: true,
                                            drawVerticalLine: false,
                                            horizontalInterval: 10,
                                            getDrawingHorizontalLine: (value) {
                                              return FlLine(
                                                color: Colors.grey.shade200,
                                                strokeWidth: 1,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ==================== PIE CHART SECTION ====================
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header Pie Chart
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.green.shade100,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.pie_chart_outline,
                                      color: Colors.green.shade700,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    "Distribusi Transaksi per Bulan",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              pieChartData.isEmpty
                                  ? SizedBox(
                                      height: 250,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.pie_chart_outline,
                                              size: 48,
                                              color: Colors.grey.shade400,
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              "Tidak ada data distribusi",
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        // Pie Chart
                                        SizedBox(
                                          height: 280,
                                          child: PieChart(
                                            PieChartData(
                                              sections: pieChartData
                                                  .asMap()
                                                  .map((i, e) => MapEntry(
                                                        i,
                                                        PieChartSectionData(
                                                          value: e.total.toDouble(),
                                                          title: "${e.total}",
                                                          color: getMonthColor(e.bulan),
                                                          radius: 65,
                                                          titleStyle: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                          titlePositionPercentageOffset: 0.6,
                                                        ),
                                                      ))
                                                  .values
                                                  .toList(),
                                              sectionsSpace: 3,
                                              centerSpaceRadius: 50,
                                              startDegreeOffset: -90,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        // Legend
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade50,
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Legend:",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                              const SizedBox(height: 12),
                                              Wrap(
                                                alignment: WrapAlignment.start,
                                                children: pieChartData
                                                    .map((data) => _buildLegendItem(
                                                          data.bulan,
                                                          getMonthColor(data.bulan),
                                                          data.total,
                                                        ))
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
    );
  }
}