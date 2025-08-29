import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillingPaymentsScreen extends StatefulWidget {
  const BillingPaymentsScreen({super.key});

  @override
  State<BillingPaymentsScreen> createState() => _BillingPaymentsScreenState();
}

class _BillingPaymentsScreenState extends State<BillingPaymentsScreen> with TickerProviderStateMixin {
  final Color primaryColor = const Color(0xFF1565C0);
  final Color accentColor = const Color(0xFF42A5F5);
  final Color warningColor = const Color(0xFFFF8F00);
  final Color dangerColor = const Color(0xFFD32F2F);

  late AnimationController _animationController;
  String selectedFilter = 'Semua';

  final List<Map<String, dynamic>> bills = [
    {
      'id': 'INV-2025-001',
      'patient': 'Budi Santoso',
      'patientId': 'P001234',
      'service': 'Konsultasi Dokter Spesialis Penyakit Dalam',
      'doctor': 'Dr. Sarah Wijaya, Sp.PD',
      'amount': 350000,
      'status': 'Pending',
      'date': '27-08-2025',
      'time': '09:30',
      'paymentMethod': null,
      'category': 'Konsultasi',
    },
    {
      'id': 'INV-2025-002',
      'patient': 'Siti Aminah',
      'patientId': 'P001235',
      'service': 'Pemeriksaan & Scaling Gigi',
      'doctor': 'Dr. Ahmad Dental, Sp.KG',
      'amount': 450000,
      'status': 'Paid',
      'date': '25-08-2025',
      'time': '14:15',
      'paymentMethod': 'Transfer Bank',
      'category': 'Dental',
    },
    {
      'id': 'INV-2025-003',
      'patient': 'Rizky Maulana',
      'patientId': 'P001236',
      'service': 'Imunisasi Hepatitis B + Konsultasi',
      'doctor': 'Dr. Lisa Pediatri, Sp.A',
      'amount': 280000,
      'status': 'Pending',
      'date': '26-08-2025',
      'time': '11:00',
      'paymentMethod': null,
      'category': 'Vaksinasi',
    },
    {
      'id': 'INV-2025-004',
      'patient': 'Maria Santos',
      'patientId': 'P001237',
      'service': 'USG 4D + Konsultasi Kandungan',
      'doctor': 'Dr. Nina ObGyn, Sp.OG',
      'amount': 650000,
      'status': 'Overdue',
      'date': '20-08-2025',
      'time': '10:30',
      'paymentMethod': null,
      'category': 'Pemeriksaan',
    },
  ];

  // Controllers for the add bill form
  final _formKey = GlobalKey<FormState>();
  final _patientController = TextEditingController();
  final _patientIdController = TextEditingController();
  final _serviceController = TextEditingController();
  final _doctorController = TextEditingController();
  final _amountController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  
  String _selectedCategory = 'Konsultasi';
  String _selectedStatus = 'Pending';
  
  final List<String> _categories = [
    'Konsultasi',
    'Dental', 
    'Vaksinasi',
    'Pemeriksaan',
    'Lab Test',
    'Radiologi',
    'Operasi',
    'Rawat Inap'
  ];
  
  final List<String> _statuses = ['Pending', 'Paid', 'Overdue'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _patientController.dispose();
    _patientIdController.dispose();
    _serviceController.dispose();
    _doctorController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  String _generateInvoiceId() {
    final now = DateTime.now();
    final year = now.year;
    final nextNumber = bills.length + 1;
    return 'INV-$year-${nextNumber.toString().padLeft(3, '0')}';
  }

  void _showAddBillDialog() {
    // Reset form
    _formKey.currentState?.reset();
    _patientController.clear();
    _patientIdController.clear();
    _serviceController.clear();
    _doctorController.clear();
    _amountController.clear();
    _dateController.clear();
    _timeController.clear();
    _selectedCategory = 'Konsultasi';
    _selectedStatus = 'Pending';
    
    // Set default date and time
    final now = DateTime.now();
    _dateController.text = '${now.day.toString().padLeft(2, '0')}-${now.month.toString().padLeft(2, '0')}-${now.year}';
    _timeController.text = '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        final dialogBgColor = isDark ? const Color(0xFF2D3748) : Colors.white;
        final textColor = isDark ? Colors.white : const Color(0xFF1E293B);
        final subTextColor = isDark ? Colors.grey[400] : const Color(0xFF64748B);

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: dialogBgColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Row(
                children: [
                  Icon(Icons.add_circle_outline, color: primaryColor),
                  const SizedBox(width: 8),
                  Text(
                    'Tambah Tagihan Baru',
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Patient Name
                        TextFormField(
                          controller: _patientController,
                          style: GoogleFonts.inter(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Nama Pasien *',
                            labelStyle: GoogleFonts.inter(color: subTextColor),
                            prefixIcon: Icon(Icons.person, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama pasien harus diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Patient ID
                        TextFormField(
                          controller: _patientIdController,
                          style: GoogleFonts.inter(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'ID Pasien *',
                            labelStyle: GoogleFonts.inter(color: subTextColor),
                            prefixIcon: Icon(Icons.badge, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'ID pasien harus diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Service
                        TextFormField(
                          controller: _serviceController,
                          style: GoogleFonts.inter(color: textColor),
                          maxLines: 2,
                          decoration: InputDecoration(
                            labelText: 'Layanan Medis *',
                            labelStyle: GoogleFonts.inter(color: subTextColor),
                            prefixIcon: Icon(Icons.medical_services, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Layanan medis harus diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Doctor
                        TextFormField(
                          controller: _doctorController,
                          style: GoogleFonts.inter(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Nama Dokter *',
                            labelStyle: GoogleFonts.inter(color: subTextColor),
                            prefixIcon: Icon(Icons.person_pin, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama dokter harus diisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Category Dropdown
                        DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          style: GoogleFonts.inter(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Kategori',
                            labelStyle: GoogleFonts.inter(color: subTextColor),
                            prefixIcon: Icon(Icons.category, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          dropdownColor: dialogBgColor,
                          items: _categories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category, style: GoogleFonts.inter(color: textColor)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setDialogState(() {
                              _selectedCategory = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 16),

                        // Amount
                        TextFormField(
                          controller: _amountController,
                          style: GoogleFonts.inter(color: textColor),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Jumlah Tagihan (Rp) *',
                            labelStyle: GoogleFonts.inter(color: subTextColor),
                            prefixIcon: Icon(Icons.attach_money, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Jumlah tagihan harus diisi';
                            }
                            if (int.tryParse(value.replaceAll('.', '')) == null) {
                              return 'Jumlah harus berupa angka';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),

                        // Date and Time Row
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _dateController,
                                style: GoogleFonts.inter(color: textColor),
                                decoration: InputDecoration(
                                  labelText: 'Tanggal *',
                                  labelStyle: GoogleFonts.inter(color: subTextColor),
                                  prefixIcon: Icon(Icons.calendar_today, color: primaryColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: primaryColor, width: 2),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2030),
                                  );
                                  if (date != null) {
                                    _dateController.text = '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tanggal harus diisi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextFormField(
                                controller: _timeController,
                                style: GoogleFonts.inter(color: textColor),
                                decoration: InputDecoration(
                                  labelText: 'Waktu *',
                                  labelStyle: GoogleFonts.inter(color: subTextColor),
                                  prefixIcon: Icon(Icons.schedule, color: primaryColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: primaryColor, width: 2),
                                  ),
                                ),
                                readOnly: true,
                                onTap: () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null) {
                                    _timeController.text = '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Waktu harus diisi';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Status Dropdown
                        DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          style: GoogleFonts.inter(color: textColor),
                          decoration: InputDecoration(
                            labelText: 'Status',
                            labelStyle: GoogleFonts.inter(color: subTextColor),
                            prefixIcon: Icon(Icons.info, color: primaryColor),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          dropdownColor: dialogBgColor,
                          items: _statuses.map((String status) {
                            String displayStatus = status == 'Paid' ? 'Lunas' : 
                                                  status == 'Pending' ? 'Menunggu' : 'Terlambat';
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(displayStatus, style: GoogleFonts.inter(color: textColor)),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setDialogState(() {
                              _selectedStatus = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: subTextColor,
                  ),
                  child: Text('Batal', style: GoogleFonts.inter()),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addNewBill();
                      Navigator.of(context).pop();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text('Simpan', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _addNewBill() {
    final newBill = {
      'id': _generateInvoiceId(),
      'patient': _patientController.text,
      'patientId': _patientIdController.text,
      'service': _serviceController.text,
      'doctor': _doctorController.text,
      'amount': int.parse(_amountController.text.replaceAll('.', '')),
      'status': _selectedStatus,
      'date': _dateController.text,
      'time': _timeController.text,
      'paymentMethod': _selectedStatus == 'Paid' ? 'Cash' : null,
      'category': _selectedCategory,
    };

    setState(() {
      bills.insert(0, newBill); // Add to beginning of list
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Tagihan baru berhasil ditambahkan',
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void markAsPaid(int index) {
    setState(() {
      bills[index]['status'] = 'Paid';
      bills[index]['paymentMethod'] = 'Cash'; // Default to Cash for demonstration
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Pembayaran ${bills[index]['id']} berhasil dicatat',
              style: GoogleFonts.inter(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: accentColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  List<Map<String, dynamic>> get filteredBills {
    if (selectedFilter == 'Semua') return bills;
    return bills.where((bill) => bill['status'] == selectedFilter).toList();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Paid':
        return const Color(0xFF4CAF50); // Green for Paid
      case 'Pending':
        return warningColor;
      case 'Overdue':
        return dangerColor;
      default:
        return Colors.grey;
    }
  }

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'Paid':
        return Icons.check_circle;
      case 'Pending':
        return Icons.schedule;
      case 'Overdue':
        return Icons.warning;
      default:
        return Icons.help;
    }
  }

  String getStatusText(String status) {
    switch (status) {
      case 'Paid':
        return 'Lunas';
      case 'Pending':
        return 'Menunggu';
      case 'Overdue':
        return 'Terlambat';
      default:
        return status;
    }
  }

  Widget _buildSummaryCard(BuildContext context, bool isDark) {
    final cardBgColor = isDark ? const Color(0xFF1E2738) : Colors.white;
    final totalAmount = bills.fold<int>(0, (sum, bill) => sum + (bill['amount'] as int));
    final paidAmount = bills.where((bill) => bill['status'] == 'Paid')
        .fold<int>(0, (sum, bill) => sum + (bill['amount'] as int));
    final pendingCount = bills.where((bill) => bill['status'] == 'Pending').length;
    final overdueCount = bills.where((bill) => bill['status'] == 'Overdue').length;

    return Card(
      color: cardBgColor, // Use a themed card background color
      elevation: 8,
      shadowColor: isDark ? Colors.black.withOpacity(0.4) : primaryColor.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [primaryColor, accentColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.analytics, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  'Ringkasan Keuangan',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Total Pendapatan',
                    'Rp ${_formatCurrency(totalAmount)}',
                    Icons.account_balance_wallet,
                    Colors.white,
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    'Sudah Dibayar',
                    'Rp ${_formatCurrency(paidAmount)}',
                    Icons.check_circle,
                    Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    'Menunggu',
                    '$pendingCount tagihan',
                    Icons.schedule,
                    Colors.white,
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  color: Colors.white.withOpacity(0.3),
                ),
                Expanded(
                  child: _buildSummaryItem(
                    'Terlambat',
                    '$overdueCount tagihan',
                    Icons.warning,
                    Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0), // Added horizontal padding
      child: Column(
        children: [
          Icon(icon, color: color.withOpacity(0.8), size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.inter(
              color: color.withOpacity(0.9),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.inter(
              color: color,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(bool isDark) {
    final filters = ['Semua', 'Paid', 'Pending', 'Overdue'];
    final chipBgColor = isDark ? const Color(0xFF2D3748) : Colors.white;
    final chipSelectedColor = primaryColor;
    final chipTextColor = isDark ? Colors.white70 : primaryColor;
    final chipSelectedTextColor = Colors.white;

    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(
                filter == 'Paid' ? 'Lunas' :
                filter == 'Pending' ? 'Menunggu' :
                filter == 'Overdue' ? 'Terlambat' : filter,
                style: GoogleFonts.inter(
                  color: isSelected ? chipSelectedTextColor : chipTextColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedFilter = filter;
                });
              },
              selectedColor: chipSelectedColor,
              backgroundColor: chipBgColor,
              side: BorderSide(color: isSelected ? chipSelectedColor : (isDark ? Colors.grey.shade700 : primaryColor)),
              elevation: isSelected ? 4 : 1,
              shadowColor: isSelected ? primaryColor.withOpacity(0.3) : (isDark ? Colors.transparent : Colors.black.withOpacity(0.1)),
            ),
          );
        },
      ),
    );
  }

  String _formatCurrency(int amount) {
    return amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9); // Dark blue-gray for dark mode
    final cardColor = isDark ? const Color(0xFF2D3748) : Colors.white; // Slightly lighter card for dark mode
    final textColor = isDark ? Colors.white : const Color(0xFF1E293B);
    final subTextColor = isDark ? Colors.grey[400] : const Color(0xFF64748B);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Billing & Payments',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1565C0), Color(0xFF42A5F5)], // Primary to accent blue
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Implementasi pencarian
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Fungsi Pencarian Segera Hadir!', style: GoogleFonts.inter()), backgroundColor: Colors.blueAccent),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'new_bill') {
                _showAddBillDialog(); // Call the function to show add bill dialog
              } else if (value == 'settings') {
                // Logic for settings or other options
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fungsi Pengaturan Segera Hadir!', style: GoogleFonts.inter()), backgroundColor: Colors.orange),
                );
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'new_bill',
                child: Row(
                  children: [
                    Icon(Icons.add_circle_outline, color: primaryColor),
                    const SizedBox(width: 8),
                    Text('Tagihan Baru', style: GoogleFonts.inter(color: textColor)),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(Icons.settings_outlined, color: subTextColor),
                    const SizedBox(width: 8),
                    Text('Pengaturan', style: GoogleFonts.inter(color: textColor)),
                  ],
                ),
              ),
            ],
            color: cardColor, // Popup menu background color
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 8,
          ),
        ],
      ),
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor, // Keep this for the top part of the gradient
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: _buildSummaryCard(context, isDark),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildFilterChips(isDark),
          const SizedBox(height: 16),
          Expanded(
            child: filteredBills.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 80,
                          color: subTextColor,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Tidak ada tagihan',
                          style: GoogleFonts.inter(
                            color: subTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredBills.length,
                        itemBuilder: (context, index) {
                          final bill = filteredBills[index];
                          final isPaid = bill['status'] == 'Paid';
                          final isOverdue = bill['status'] == 'Overdue';

                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.3, 0),
                              end: Offset.zero,
                            ).animate(CurvedAnimation(
                              parent: _animationController,
                              curve: Interval(
                                index * 0.1,
                                (index * 0.1) + 0.3,
                                curve: Curves.easeOutCubic,
                              ),
                            )),
                            child: FadeTransition(
                              opacity: Tween<double>(
                                begin: 0,
                                end: 1,
                              ).animate(CurvedAnimation(
                                parent: _animationController,
                                curve: Interval(
                                  index * 0.1,
                                  (index * 0.1) + 0.3,
                                  curve: Curves.easeOut,
                                ),
                              )),
                              child: Card(
                                color: cardColor,
                                margin: const EdgeInsets.only(bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(
                                    color: isOverdue
                                        ? dangerColor.withOpacity(0.3)
                                        : Colors.transparent,
                                    width: isOverdue ? 2 : 0,
                                  ),
                                ),
                                elevation: 6,
                                shadowColor: isDark ? Colors.black.withOpacity(0.3) : Colors.black.withOpacity(0.1),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    gradient: isOverdue
                                        ? LinearGradient(
                                            colors: [
                                              isDark ? cardColor.withOpacity(0.9) : cardColor,
                                              dangerColor.withOpacity(0.05),
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          )
                                        : null,
                                  ),
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  bill['id'],
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color: subTextColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  bill['patient'],
                                                  style: GoogleFonts.inter(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: textColor,
                                                  ),
                                                ),
                                                Text(
                                                  'ID: ${bill['patientId']}',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color: subTextColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 6,
                                            ),
                                            decoration: BoxDecoration(
                                              color: getStatusColor(bill['status']).withOpacity(0.1),
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                color: getStatusColor(bill['status']).withOpacity(0.3),
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  getStatusIcon(bill['status']),
                                                  size: 16,
                                                  color: getStatusColor(bill['status']),
                                                ),
                                                const SizedBox(width: 4),
                                                Text(
                                                  getStatusText(bill['status']),
                                                  style: GoogleFonts.inter(
                                                    fontSize: 12,
                                                    color: getStatusColor(bill['status']),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Colors.grey[850]
                                              : const Color(0xFFF8F9FA),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(Icons.medical_services,
                                                    size: 16, color: primaryColor),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    bill['service'],
                                                    style: GoogleFonts.inter(
                                                      fontSize: 14,
                                                      color: textColor,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(Icons.person_pin,
                                                    size: 16, color: primaryColor),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    bill['doctor'],
                                                    style: GoogleFonts.inter(
                                                      fontSize: 13,
                                                      color: subTextColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(Icons.schedule,
                                                    size: 16, color: primaryColor),
                                                const SizedBox(width: 8),
                                                Text(
                                                  '${bill['date']} • ${bill['time']}',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 13,
                                                    color: subTextColor,
                                                  ),
                                                ),
                                                const Spacer(),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: primaryColor.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    bill['category'],
                                                    style: GoogleFonts.inter(
                                                      fontSize: 11,
                                                      color: primaryColor,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Total Tagihan',
                                                style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  color: subTextColor,
                                                ),
                                              ),
                                              Text(
                                                'Rp ${_formatCurrency(bill['amount'])}',
                                                style: GoogleFonts.inter(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: textColor,
                                                ),
                                              ),
                                              if (bill['paymentMethod'] != null)
                                                Text(
                                                  'via ${bill['paymentMethod']}',
                                                  style: GoogleFonts.inter(
                                                    fontSize: 11,
                                                    color: accentColor,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                            ],
                                          ),
                                          if (!isPaid)
                                            ElevatedButton.icon(
                                              onPressed: () => markAsPaid(bills.indexOf(bill)),
                                              icon: const Icon(Icons.check, size: 18),
                                              label: Text(
                                                'Tandai Lunas',
                                                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: primaryColor,
                                                foregroundColor: Colors.white,
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 12,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                elevation: 3,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      // FloatingActionButton removed - tagihan baru hanya tersedia di menu titik tiga
    );
  }
}