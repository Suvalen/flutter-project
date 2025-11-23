import 'package:flutter/material.dart';
import '../widgets/settings_icon_button.dart';

// Placeholder for search page content
class SearchContent extends StatelessWidget {
  const SearchContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                size: 80,
                color: const Color(0xFF616161),
              ),
              const SizedBox(height: 20),
              const Text(
                'Search',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF131416),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Search feature coming soon!',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF616161),
                ),
              ),
            ],
          ),
        ),
        // Settings icon button
        const SettingsIconButton(),
      ],
    );
  }
}
