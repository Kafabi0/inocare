import 'package:flutter/material.dart';
import '../models/pasien_transaksi.dart';
import '../widgets/pasien_service.dart';

class PasienProfilePage extends StatefulWidget {
  final int pasienId; // ID pasien yang mau dilihat

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Gagal memuat data pasien: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (pasienData == null) {
      return const Scaffold(
        body: Center(child: Text("Data pasien tidak ditemukan")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Profil Pasien")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Foto profil
            CircleAvatar(
              radius: 60,
              backgroundImage:
                  pasienData!.foto.isNotEmpty
                      ? NetworkImage(
                        pasienData!.foto.startsWith("http")
                            ? pasienData!.foto
                            : "http://192.168.1.38:8080/${pasienData!.foto.replaceAll("\\", "/")}", // ✅ tambahin base URL & ganti backslash
                      )
                      : const AssetImage("assets/nailong.png")
                          as ImageProvider,
            ),

            const SizedBox(height: 16),

            // Nama
            Text(
              pasienData!.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Informasi pasien
            _buildInfoTile("NIK", pasienData!.nik, Icons.badge),
            _buildInfoTile(
              "Jenis Kelamin",
              pasienData!.jenisKelamin,
              Icons.people,
            ),
            _buildInfoTile(
              "Tanggal Lahir",
              pasienData!.tanggalLahir,
              Icons.cake,
            ),
            _buildInfoTile("Alamat", pasienData!.alamat, Icons.location_on),
            _buildInfoTile("No. Telepon", pasienData!.noTelp, Icons.phone),
            _buildInfoTile("Email", pasienData!.email, Icons.email),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(label),
        subtitle: Text(value.isNotEmpty ? value : "-"),
      ),
    );
  }
}
