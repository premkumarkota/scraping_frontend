import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/law_update.dart';

class ArticleDetailScreen extends StatelessWidget {
  final LawUpdate article;

  const ArticleDetailScreen({super.key, required this.article});

  String _formatDate(DateTime dateTime) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[dateTime.month - 1]} ${dateTime.day}, ${dateTime.year}';
  }

  String _getSourceName(int sourceId) {
    switch (sourceId) {
      case 1:
        return 'Tax Management India';
      case 2:
        return 'A2Z Taxcorp';
      case 3:
        return 'LiveLaw';
      default:
        return 'Legal News';
    }
  }

  Color _getSourceColor(int sourceId) {
    switch (sourceId) {
      case 1:
        return const Color(0xFFE91E63);
      case 2:
        return const Color(0xFF2196F3);
      case 3:
        return const Color(0xFFFF9800);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Bar
            _buildHeader(context, isMobile),

            // Article Content
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 900),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 20 : 40,
                    vertical: 50,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Source and Date
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _getSourceColor(
                                article.sourceId,
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: _getSourceColor(
                                  article.sourceId,
                                ).withOpacity(0.3),
                              ),
                            ),
                            child: Text(
                              _getSourceName(article.sourceId),
                              style: GoogleFonts.lato(
                                color: _getSourceColor(article.sourceId),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today_rounded,
                                  size: 16,
                                  color: Color(0xFF666666),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  _formatDate(article.scrapedAt),
                                  style: GoogleFonts.lato(
                                    color: const Color(0xFF666666),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ).animate().fadeIn(duration: 400.ms),

                      const SizedBox(height: 30),

                      // Title
                      Text(
                            article.title,
                            style: GoogleFonts.playfairDisplay(
                              color: const Color(0xFF1A1A1A),
                              fontSize: isMobile ? 28 : 38,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 100.ms, duration: 400.ms)
                          .slideY(begin: 0.1),

                      const SizedBox(height: 30),

                      // Blue accent bar
                      Container(
                            width: 80,
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF002855), Color(0xFF0089D0)],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          )
                          .animate()
                          .fadeIn(delay: 200.ms)
                          .scale(begin: const Offset(0, 1)),

                      const SizedBox(height: 40),

                      // Article content
                      SelectableText(
                        article.content.isNotEmpty
                            ? article.content
                            : 'Content not available. Click the button below to read the original article.',
                        style: GoogleFonts.lato(
                          color: const Color(0xFF444444),
                          fontSize: 17,
                          height: 1.9,
                          letterSpacing: 0.2,
                        ),
                      ).animate().fadeIn(delay: 300.ms, duration: 500.ms),

                      const SizedBox(height: 60),

                      // Read original button
                      Center(
                        child:
                            MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap: () => _launchUrl(article.link),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 40,
                                        vertical: 18,
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF002855),
                                            Color(0xFF0089D0),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(
                                              0xFF0089D0,
                                            ).withOpacity(0.3),
                                            blurRadius: 20,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.open_in_new_rounded,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            'Read Original Article',
                                            style: GoogleFonts.lato(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                                .animate()
                                .fadeIn(delay: 400.ms)
                                .scale(begin: const Offset(0.95, 0.95)),
                      ),

                      const SizedBox(height: 60),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 60,
        vertical: 20,
      ),
      decoration: const BoxDecoration(color: Color(0xFF002855)),
      child: Row(
        children: [
          // Back button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          // Title
          Text(
            'Article',
            style: GoogleFonts.playfairDisplay(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // External link button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => _launchUrl(article.link),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.open_in_new_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Original Source',
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1);
  }
}
