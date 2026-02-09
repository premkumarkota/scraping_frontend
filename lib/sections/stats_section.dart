import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
      color: const Color(0xFF002855),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStat('26', 'YEARS OF EXPERTISE'),
          Container(
            height: 80,
            width: 1,
            color: Colors.white24,
            margin: const EdgeInsets.symmetric(horizontal: 50),
          ),
          _buildStat('10+', 'INDIAN CITIES'),
          Container(
            height: 80,
            width: 1,
            color: Colors.white24,
            margin: const EdgeInsets.symmetric(horizontal: 50),
          ),
          _buildStat('500+', 'CLIENTS SERVED'),
          Container(
            height: 80,
            width: 1,
            color: Colors.white24,
            margin: const EdgeInsets.symmetric(horizontal: 50),
          ),
          _buildStat('15+', 'LEGAL EXPERTS'),
        ],
      ),
    );
  }

  Widget _buildStat(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: GoogleFonts.playfairDisplay(
            fontSize: 65,
            fontWeight: FontWeight.bold,
            color: Colors.white, // White text on dark blue
          ),
        ),
        const SizedBox(height: 10),
        Text(
          label,
          style: GoogleFonts.lato(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            letterSpacing: 2,
            color: const Color(0xFF0089D0), // Accent blue
          ),
        ),
      ],
    );
  }
}
