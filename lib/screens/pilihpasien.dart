import 'package:flutter/material.dart';
import '../models/pasien_transaksi.dart';
import '../widgets/pasien_service.dart';
import 'pasien_profile_page.dart';

class PasienSelectionPage extends StatefulWidget {
  const PasienSelectionPage({Key? key}) : super(key: key);

  @override
  State<PasienSelectionPage> createState() => _PasienSelectionPageState();
}

class _PasienSelectionPageState extends State<PasienSelectionPage> {
  List<Pasien> pasienList = [];
  bool isLoading = true;

  final String baseUrl = "http://192.168.1.38:8080/";

  @override
  void initState() {
    super.initState();
    _loadPasienList();
  }

  Future<void> _loadPasienList() async {
    try {
      final data = await PasienService.getAllPasien();
      setState(() {
        pasienList = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memuat daftar pasien: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pilih Pasien")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : pasienList.isEmpty
              ? const Center(child: Text("Tidak ada pasien terdaftar"))
              : ListView.builder(
                  itemCount: pasienList.length,
                  itemBuilder: (context, index) {
                    final pasien = pasienList[index];

                    // ✅ perbaiki URL foto
                    final fotoUrl = pasien.foto.isNotEmpty
                        ? (pasien.foto.startsWith("http")
                            ? pasien.foto
                            : "$baseUrl${pasien.foto}")
                        : "";

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: fotoUrl.isNotEmpty
                            ? NetworkImage(fotoUrl)
                            : const AssetImage("assets/nailong.png")
                                as ImageProvider,
                      ),
                      title: Text(pasien.name),
                      subtitle: Text(pasien.nik),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // ✅ navigasi ke halaman profile
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PasienProfilePage(
                              pasienId: pasien.id!,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
