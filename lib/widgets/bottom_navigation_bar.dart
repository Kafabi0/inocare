import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF0D6EFD),
      unselectedItemColor: Colors.grey[600],
      items: [
        _buildBarItem(FontAwesomeIcons.house, 'Home', 0),
        _buildBarItem(FontAwesomeIcons.notesMedical, 'Health Records', 1),
        _buildBarItem(FontAwesomeIcons.solidBell, 'Notifications', 2),
        _buildBarItem(FontAwesomeIcons.gear, 'Settings', 3),
      ],
    );
  }

  BottomNavigationBarItem _buildBarItem(
    IconData icon,
    String label,
    int index,
  ) {
    return BottomNavigationBarItem(
      label: label,
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            height: 4,
            width: currentIndex == index ? 24 : 0,
            decoration: BoxDecoration(
              color: const Color(0xFF0D6EFD),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 4),
          FaIcon(icon, size: 20),
        ],
      ),
    );
  }
}
