import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/hover_widgets.dart';

class PrinciplesSection extends StatelessWidget {
  const PrinciplesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 100,
            horizontal: isMobile ? 30 : 100,
          ),
          color: Colors.white,
          child: Column(
            children: [
              Text(
                'GUIDING PRINCIPLES',
                style: GoogleFonts.lato(
                  letterSpacing: 2,
                  color: const Color(0xFF0089D0),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'For Excellence in Legal Practice',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: isMobile ? 28 : 36,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF002855),
                ),
              ),
              const SizedBox(height: 60),
              Wrap(
                spacing: 30,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: [
                  _buildCard(
                    'Integrity',
                    'Doing the right things in a fair & ethical manner.',
                    FontAwesomeIcons.scaleBalanced,
                  ),
                  _buildCard(
                    'Knowledge',
                    'Acquire and share subject expertise continuously.',
                    FontAwesomeIcons.bookOpen,
                  ),
                  _buildCard(
                    'Independence',
                    'Being Unbiased.',
                    FontAwesomeIcons.handshake,
                  ),
                  _buildCard(
                    'Innovation',
                    'Thinking originally & differently. Out of the box approach.',
                    FontAwesomeIcons.lightbulb,
                  ),
                  _buildCard(
                    'Passion',
                    'Inspired to make a difference.',
                    FontAwesomeIcons.fire,
                  ),
                  _buildCard(
                    'Social Responsibility',
                    'Focus on education and training of community.',
                    FontAwesomeIcons.users,
                  ),
                ].animate(interval: 100.ms).fadeIn().slideY(begin: 0.2),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCard(String title, String desc, IconData icon) {
    return HoverScale(
      scale: 1.03,
      duration: 300.ms,
      child: Container(
        width: 350,
        height: 250,
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF002855).withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 36, color: const Color(0xFF0089D0)),
            const SizedBox(height: 25),
            Text(
              title,
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF002855),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              desc,
              style: GoogleFonts.lato(
                fontSize: 15,
                color: const Color(0xFF666666),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
