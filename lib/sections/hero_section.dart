import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF002855), Color(0xFF0D1B2A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Opacity(
              opacity: 0.05,
              child: Image.asset(
                'assets/images/hero.png',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Row(
              children: [
                // Left content
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0089D0).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          'Trusted Legal Partners',
                          style: GoogleFonts.lato(
                            color: const Color(0xFF4FC3F7),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.2),
                      const SizedBox(height: 25),
                      Text(
                        'Expert Legal Solutions\nFor Your Business',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.2,
                        ),
                      ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                      const SizedBox(height: 25),
                      SizedBox(
                        width: 500,
                        child: Text(
                          'H N A Law Chambers provides comprehensive legal services in GST, Customs, Foreign Trade Policy, and indirect taxation with over 10+ years of expertise.',
                          style: GoogleFonts.lato(
                            fontSize: 17,
                            color: Colors.white70,
                            height: 1.7,
                          ),
                        ),
                      ).animate().fadeIn(delay: 600.ms),
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0089D0),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 35,
                                vertical: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Schedule Consultation',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white54),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 35,
                                vertical: 18,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              'Our Services',
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.3),
                    ],
                  ),
                ),
                // Right image
                Expanded(
                  flex: 4,
                  child:
                      Center(
                            child: Image.asset(
                              'assets/images/hero_3d.png',
                              height: 450,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.gavel,
                                size: 200,
                                color: Colors.white24,
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 500.ms)
                          .scale(begin: const Offset(0.9, 0.9)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
