import 'package:flutter/material.dart';
import '../screens/lab.dart';
class DashboardReporting extends StatelessWidget {
  const DashboardReporting({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {
        "title": "Diklat",
        "icon": Icons.school,
        "color": Colors.indigo,
        "page": const DummyPage(title: "Diklat")
      },
      {
        "title": "Kepegawaian",
        "icon": Icons.group,
        "color": Colors.blueGrey,
        "page": const DummyPage(title: "Kepegawaian")
      },
      {
        "title": "Rekam Medis",
        "icon": Icons.folder_shared,
        "color": Colors.deepPurple,
        "page": const DummyPage(title: "Rekam Medis")
      },
      {
        "title": "Lab",
        "icon": Icons.bloodtype,
        "color": Colors.redAccent,
        "page": const LabPage()
      },
      
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard & Reporting"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // jumlah kolom
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item["page"]),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: item["color"].withOpacity(0.1),
                      child: Icon(item["icon"], color: item["color"], size: 30),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item["title"],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

/// Halaman dummy untuk contoh navigasi
class DummyPage extends StatelessWidget {
  final String title;
  const DummyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          "Ini halaman $title",
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
