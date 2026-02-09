import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HNANavbar extends StatelessWidget {
  const HNANavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 60,
            vertical: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Logo
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/hna.svg',
                    height: isMobile ? 40 : 50,
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              const Spacer(),

              if (isMobile)
                // Mobile Menu Button
                IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Color(0xFF002855),
                    size: 30,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                )
              else ...[
                // Desktop Navigation Links
                _NavLink(text: 'Home', isActive: true),
                _NavLink(text: 'About'),
                _NavLink(text: 'Services'),
                _NavLink(text: 'Team'),
                _NavLink(text: 'Contact'),
                const SizedBox(width: 30),
                // CTA Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF002855),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Get Consultation',
                    style: GoogleFonts.lato(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _NavLink extends StatefulWidget {
  final String text;
  final bool isActive;

  const _NavLink({required this.text, this.isActive = false});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          widget.text,
          style: GoogleFonts.lato(
            fontSize: 15,
            fontWeight: widget.isActive || _isHovered
                ? FontWeight.w700
                : FontWeight.w500,
            color: widget.isActive || _isHovered
                ? const Color(0xFF0089D0)
                : const Color(0xFF333333),
          ),
        ),
      ),
    );
  }
}
