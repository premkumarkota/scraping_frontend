import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Text Content
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dash and Title
                Container(
                  width: 30,
                  height: 4,
                  color: const Color(0xFF0089D0), // Blue Dash
                  margin: const EdgeInsets.only(bottom: 15),
                ),
                Text(
                  'What We Do', // Fixed typo matching design
                  style: GoogleFonts.lato(
                    letterSpacing: 1.5,
                    color: const Color(0xFF0089D0),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ).animate().slideX(begin: -0.2),
                const SizedBox(height: 20),
                Text(
                  'Transforming Legal Solutions for\nYour Success',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0D1B2A), // Dark Navy
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'H N A Law Chambers, was established with an aim to provide effective solutions to our clients backed by our core values of integrity, knowledge and independence (GST, Customs, Foreign Trade Policy and erstwhile Central Excise, Service Tax and Value Added Tax).',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    height: 1.8,
                    color: const Color(0xFF555555),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Our partners have experience of 10+ years in the field of indirect taxation. The firm has offices in Bengaluru, Hyderabad, Vizag, Chennai, Raipur, Kolkata, Mumbai, Pune, Gurgaon, Ahmedabad. The firm also serves clientele from various industries such as manufacturing, information technology, public sector undertakings, Governmental authorities etc.',
                  style: GoogleFonts.lato(
                    fontSize: 16,
                    height: 1.8,
                    color: const Color(0xFF555555),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 80), // Specing between columns
          // Right: Image with Special Styling
          Expanded(
            flex: 4,
            child: SizedBox(
              height: 500,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  // The Blue Rectangle Decoration (Behind)
                  Positioned(
                    left: 20,
                    bottom: 40,
                    child: Container(
                      width: 250,
                      height: 300,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4285F4), // Bright Blue
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  // The Circular Image (Front)
                  Padding(
                    padding: const EdgeInsets.only(right: 20, bottom: 20),
                    child: Container(
                      width: 420,
                      height: 420,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ), // White border
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/about.webp',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  // Decorative Gradient Bubbles (Simulating the bg effect)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF4285F4).withOpacity(0.4),
                            const Color(0xFF4285F4).withOpacity(0.0),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).animate().slideX(begin: -0.1, duration: 800.ms),
          ),
        ],
      ),
    );
  }
}
