import 'package:flutter/material.dart';
import 'package:inocare/screens/pasien_edit_page.dart';
import '../models/pasien_transaksi.dart';
import '../widgets/pasien_service.dart';

class PasienProfilePage extends StatefulWidget {
  final int pasienId;

  const PasienProfilePage({Key? key, required this.pasienId}) : super(key: key);

  @override
  _PasienProfilePageState createState() => _PasienProfilePageState();
}

class _PasienProfilePageState extends State<PasienProfilePage> {
  Pasien? pasienData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPasien();
  }

  Future<void> _loadPasien() async {
    try {
      final data = await PasienService.getPasienById(widget.pasienId);
      setState(() {
        pasienData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memuat data pasien: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Profil Pasien"),
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (pasienData == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Profil Pasien"),
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                "Data pasien tidak ditemukan",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Profil Pasien"),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PasienEditPage(pasienId: pasienData!.id),
                ),
              );

              if (updated == true) {
                _loadPasien();
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan foto profil
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              padding: const EdgeInsets.only(bottom: 40, top: 20),
              child: Column(
                children: [
                  // Foto profil dengan border
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: pasienData!.foto.isNotEmpty
                          ? NetworkImage(
                              pasienData!.foto.startsWith("http")
                                  ? pasienData!.foto
                                  : "http://192.168.1.38:8080/${pasienData!.foto.replaceAll("\\", "/")}",
                            )
                          : const AssetImage("assets/nailong.png")
                              as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Nama pasien
                  Text(
                    pasienData!.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  
                  // NIK sebagai subtitle
                  Text(
                    "NIK: ${pasienData!.nik}",
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Informasi detail
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Informasi Pasien",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  _buildInfoCard("Jenis Kelamin", pasienData!.jenisKelamin, Icons.people),
                  _buildInfoCard("Tanggal Lahir", pasienData!.tanggalLahir, Icons.cake),
                  _buildInfoCard("Alamat", pasienData!.alamat, Icons.location_on),
                  _buildInfoCard("No. Telepon", pasienData!.noTelp, Icons.phone),
                  _buildInfoCard("Email", pasienData!.email, Icons.email),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: Colors.blue[600],
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value.isNotEmpty ? value : "-",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}