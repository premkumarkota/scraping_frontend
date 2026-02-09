import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MissionSection extends StatelessWidget {
  const MissionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 100,
            horizontal: isMobile ? 30 : 100,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF002855), // Fallback color
            image: DecorationImage(
              image: const AssetImage(
                'assets/images/services_main.webp',
              ), // Reusing this for background texture
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                const Color(
                  0xFF001F3F,
                ).withOpacity(0.9), // Heavy dark blue overlay
                BlendMode.srcOver,
              ),
            ),
          ),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Content (Text)
                    _buildTextSection(isMobile: true),
                    const SizedBox(height: 60),
                    // Right Content (White Card)
                    _buildCardSection(isMobile: true),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Content (Text)
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: _buildTextSection(isMobile: false),
                      ),
                    ),

                    // Right Content (White Card)
                    Expanded(
                      flex: 1,
                      child: _buildCardSection(isMobile: false),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildTextSection({required bool isMobile}) {
    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          "We're Dedicated to Providing the Best Guidance.",
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.playfairDisplay(
            fontSize: isMobile ? 36 : 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            height: 1.2,
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1),
        const SizedBox(height: 30),
        Text(
          'At H N A Law Chambers, our priority is to ensure that you receive top-notch guidance every step of the way. With our expertise and commitment, rest assured you\'re in capable hands.',
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
          style: GoogleFonts.lato(
            fontSize: 16,
            color: Colors.white70,
            height: 1.6,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 800.ms),
        const SizedBox(height: 50),
        // Optional: Add a button if needed as per general design language
      ],
    );
  }

  Widget _buildCardSection({required bool isMobile}) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 30 : 60),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFEDF7FC), // Light blue bg
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'OUR MISSION',
              style: GoogleFonts.lato(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0089D0),
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 25),
          Text(
            'Pursuing Excellence Through Commitment',
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
            style: GoogleFonts.playfairDisplay(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF002855),
              height: 1.2,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            'We achieve this through:',
            style: GoogleFonts.lato(
              fontSize: 15,
              color: const Color(0xFF666666),
            ),
          ),
          const SizedBox(height: 40),

          // Progress Bars
          _buildProgressItem('Consistent, high-quality services', 'Excellence'),
          _buildProgressItem('Practical problem-solving', 'Problem Solving'),
          _buildProgressItem('Responsibility and versatility', 'Adaptability'),
          _buildProgressItem('Developing knowledgeable leaders', 'Leadership'),
        ],
      ),
    ).animate().slideX(begin: 0.1, duration: 800.ms);
  }

  Widget _buildProgressItem(String label, String tag) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: GoogleFonts.lato(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Stack(
            alignment: Alignment.centerRight,
            children: [
              // Bar background line
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Filled Bar (simulated full for visual match)
              LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                    height: 8,
                    width: constraints
                        .maxWidth, // Full width as per design implication
                    decoration: BoxDecoration(
                      color: const Color(0xFF0089D0),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                },
              ),
              // Tag floating on the right
              Transform.translate(
                offset: const Offset(0, -18), // Move up slightly
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0089D0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: GoogleFonts.lato(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ).animate().scale(delay: 500.ms, duration: 400.ms),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
