import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;

        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            vertical: 60,
            horizontal: isMobile ? 30 : 100,
          ),
          decoration: const BoxDecoration(color: Color(0xFF0D1B2A)),
          child: Column(
            children: [
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLogoSection(),
                        const SizedBox(height: 40),
                        _buildQuickLinksSection(),
                        const SizedBox(height: 40),
                        _buildServicesSection(),
                        const SizedBox(height: 40),
                        _buildContactSection(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 3, child: _buildLogoSection()),
                        const SizedBox(width: 60),
                        Expanded(flex: 2, child: _buildQuickLinksSection()),
                        Expanded(flex: 2, child: _buildServicesSection()),
                        Expanded(flex: 3, child: _buildContactSection()),
                      ],
                    ),
              const SizedBox(height: 50),
              Container(height: 1, color: Colors.white12),
              const SizedBox(height: 30),
              isMobile
                  ? Column(
                      children: [
                        Text(
                          '© 2024 HNA Law Chambers. All Rights Reserved.',
                          style: GoogleFonts.lato(
                            fontSize: 13,
                            color: Colors.white38,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _SocialIcon(icon: Icons.facebook),
                            _SocialIcon(icon: Icons.info),
                            _SocialIcon(icon: Icons.mail),
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '© 2024 HNA Law Chambers. All Rights Reserved.',
                          style: GoogleFonts.lato(
                            fontSize: 13,
                            color: Colors.white38,
                          ),
                        ),
                        Row(
                          children: [
                            _SocialIcon(icon: Icons.facebook),
                            _SocialIcon(icon: Icons.info),
                            _SocialIcon(icon: Icons.mail),
                          ],
                        ),
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HNA LAW CHAMBERS',
          style: GoogleFonts.playfairDisplay(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Providing expert legal solutions in GST, Customs, and indirect taxation with integrity, knowledge, and independence.',
          style: GoogleFonts.lato(
            fontSize: 14,
            height: 1.7,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        _FooterLink(text: 'Home'),
        _FooterLink(text: 'About Us'),
        _FooterLink(text: 'Services'),
        _FooterLink(text: 'Team'),
        _FooterLink(text: 'Contact'),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        _FooterLink(text: 'GST Advisory'),
        _FooterLink(text: 'Customs & Trade'),
        _FooterLink(text: 'Tax Litigation'),
        _FooterLink(text: 'Compliance Audit'),
      ],
    );
  }

  Widget _buildContactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        _ContactItem(
          icon: Icons.location_on,
          text: 'Bengaluru, Hyderabad, Chennai, Mumbai',
        ),
        const SizedBox(height: 12),
        _ContactItem(icon: Icons.email, text: 'info@hnalawchambers.com'),
        const SizedBox(height: 12),
        _ContactItem(icon: Icons.phone, text: '+91 9876543210'),
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;

  const _FooterLink({required this.text});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Text(
          widget.text,
          style: GoogleFonts.lato(
            fontSize: 14,
            color: _isHovered ? const Color(0xFF0089D0) : Colors.white60,
          ),
        ),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ContactItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF0089D0)),
        const SizedBox(width: 10),
        Flexible(
          child: Text(
            text,
            style: GoogleFonts.lato(fontSize: 14, color: Colors.white60),
          ),
        ),
      ],
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;

  const _SocialIcon({required this.icon});

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _isHovered
              ? const Color(0xFF0089D0)
              : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(widget.icon, size: 18, color: Colors.white),
      ),
    );
  }
}
