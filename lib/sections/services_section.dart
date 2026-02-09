import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

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
          color: const Color(0xFFF8F9FA),
          child: Column(
            children: [
              // Header
              Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF0089D0),
                  borderRadius: BorderRadius.circular(2),
                ),
              ).animate().scale(duration: 500.ms),
              const SizedBox(height: 20),
              Text(
                'OUR SERVICES',
                style: GoogleFonts.lato(
                  letterSpacing: 3,
                  color: const Color(0xFF0089D0),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 15),
              Text(
                'Legal Expertise You Can Trust',
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0D1B2A),
                ),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
              const SizedBox(height: 60),
              // Services Grid
              Wrap(
                spacing: 30,
                runSpacing: 30,
                alignment: WrapAlignment.center,
                children: [
                  _ServiceCard(
                    icon: Icons.account_balance,
                    title: 'GST Advisory',
                    description:
                        'Comprehensive GST compliance, registration, returns filing, and advisory services.',
                    index: 0,
                  ),
                  _ServiceCard(
                    icon: Icons.local_shipping,
                    title: 'Customs & Trade',
                    description:
                        'Expert guidance on customs procedures, trade policies, and import-export regulations.',
                    index: 1,
                  ),
                  _ServiceCard(
                    icon: Icons.document_scanner,
                    title: 'Tax Litigation',
                    description:
                        'Representation before appellate authorities, tribunals, and courts for tax disputes.',
                    index: 2,
                  ),
                  _ServiceCard(
                    icon: Icons.policy,
                    title: 'Compliance Audit',
                    description:
                        'Thorough audit services to ensure regulatory compliance and risk mitigation.',
                    index: 3,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final int index;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.index,
  });

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child:
          AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 280,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: _isHovered ? const Color(0xFF002855) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(_isHovered ? 0.15 : 0.05),
                      blurRadius: _isHovered ? 20 : 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: _isHovered
                            ? Colors.white.withOpacity(0.1)
                            : const Color(0xFF0089D0).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        widget.icon,
                        size: 30,
                        color: _isHovered
                            ? Colors.white
                            : const Color(0xFF0089D0),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _isHovered
                            ? Colors.white
                            : const Color(0xFF0D1B2A),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.description,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        height: 1.6,
                        color: _isHovered
                            ? Colors.white70
                            : const Color(0xFF666666),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Learn More',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _isHovered
                                ? Colors.white
                                : const Color(0xFF0089D0),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: _isHovered
                              ? Colors.white
                              : const Color(0xFF0089D0),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              .animate(delay: Duration(milliseconds: 100 * widget.index))
              .fadeIn(duration: 500.ms)
              .slideY(begin: 0.2),
    );
  }
}
