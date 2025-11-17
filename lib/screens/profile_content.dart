import 'package:flutter/material.dart';

// Placeholder for profile page content
class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person,
            size: 80,
            color: const Color(0xFF616161),
          ),
          const SizedBox(height: 20),
          const Text(
            'Profile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF131416),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Profile feature coming soon!',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF616161),
            ),
          ),
        ],
      ),
    );
  }
}
