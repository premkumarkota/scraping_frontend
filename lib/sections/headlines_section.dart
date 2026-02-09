import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/law_update.dart';
import '../services/api_service.dart';

class HeadlinesSection extends StatefulWidget {
  const HeadlinesSection({super.key});

  @override
  State<HeadlinesSection> createState() => _HeadlinesSectionState();
}

class _HeadlinesSectionState extends State<HeadlinesSection> {
  List<LawUpdate> _updates = [];
  bool _isLoading = true;
  bool _showAllArticles = false;

  @override
  void initState() {
    super.initState();
    _fetchUpdates();
  }

  Future<void> _fetchUpdates() async {
    ApiService.triggerScrape();
    final updates = await ApiService.getUpdates(limit: 50);

    if (mounted) {
      setState(() {
        _updates = updates;
        _isLoading = false;
      });
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes}m ago';
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String _getSourceName(int sourceId) {
    switch (sourceId) {
      case 1:
        return 'TaxTMI';
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: 80,
        horizontal: isMobile ? 20 : 100,
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 20),
          _buildMarqueeStrip(),
          const SizedBox(height: 50),
          _isLoading
              ? _buildLoadingState()
              : _updates.isEmpty
              ? _buildEmptyState()
              : _buildHeadlinesGrid(isMobile),
          if (!_isLoading && _updates.isNotEmpty) ...[
            const SizedBox(height: 50),
            _showAllArticles ? _buildShowLessButton() : _buildReadMoreButton(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
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
          'TOP NEWS',
          style: GoogleFonts.lato(
            letterSpacing: 3,
            color: const Color(0xFF0089D0),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ).animate().fadeIn(delay: 200.ms),
        const SizedBox(height: 15),
        Text(
          'Legal Headlines',
          textAlign: TextAlign.center,
          style: GoogleFonts.playfairDisplay(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0D1B2A),
          ),
        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
        const SizedBox(height: 15),
        SizedBox(
          width: 600,
          child: Text(
            'Stay updated with the latest legal news, tax updates, and court rulings from trusted sources.',
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 16,
              height: 1.6,
              color: const Color(0xFF666666),
            ),
          ),
        ).animate().fadeIn(delay: 400.ms),
      ],
    );
  }

  Widget _buildMarqueeStrip() {
    if (_updates.isEmpty) return const SizedBox.shrink();

    return Container(
      height: 50,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF002855), Color(0xFF0089D0)],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _MarqueeWidget(
          children: _updates.take(10).map((update) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      _getSourceName(update.sourceId),
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    update.title.length > 60
                        ? '${update.title.substring(0, 60)}...'
                        : update.title,
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: Colors.white54,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.1);
  }

  Widget _buildLoadingState() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFF0089D0)),
          const SizedBox(height: 20),
          Text(
            'Loading headlines...',
            style: GoogleFonts.lato(
              color: const Color(0xFF666666),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.newspaper, size: 60, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No headlines available',
            style: GoogleFonts.lato(
              color: const Color(0xFF666666),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadlinesGrid(bool isMobile) {
    final displayCount = _showAllArticles
        ? _updates.length
        : 5.clamp(0, _updates.length);
    final displayedUpdates = _updates.take(displayCount).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = isMobile
            ? constraints.maxWidth
            : (constraints.maxWidth - 48) / 3;

        return Wrap(
          spacing: 24,
          runSpacing: 24,
          children: displayedUpdates.asMap().entries.map((entry) {
            return SizedBox(
              width: isMobile ? double.infinity : cardWidth,
              child: _buildHeadlineCard(entry.value, entry.key),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildHeadlineCard(LawUpdate update, int index) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/article', arguments: update);
        },
        child:
            AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/article',
                            arguments: update,
                          );
                        },
                        hoverColor: const Color(0xFFF8F9FA),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Source badge and time
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getSourceColor(
                                        update.sourceId,
                                      ).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _getSourceColor(
                                          update.sourceId,
                                        ).withOpacity(0.3),
                                      ),
                                    ),
                                    child: Text(
                                      _getSourceName(update.sourceId),
                                      style: GoogleFonts.lato(
                                        color: _getSourceColor(update.sourceId),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Icons.schedule,
                                          size: 14,
                                          color: Color(0xFF888888),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          _getTimeAgo(update.scrapedAt),
                                          style: GoogleFonts.lato(
                                            color: const Color(0xFF888888),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              // Title
                              Text(
                                update.title,
                                style: GoogleFonts.lato(
                                  color: const Color(0xFF1A1A1A),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),
                              // Read more link
                              Row(
                                children: [
                                  Text(
                                    'Read more',
                                    style: GoogleFonts.lato(
                                      color: const Color(0xFF0089D0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.arrow_forward,
                                    size: 16,
                                    color: Color(0xFF0089D0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .animate(delay: Duration(milliseconds: 100 * index))
                .fadeIn(duration: 500.ms)
                .slideX(begin: index.isEven ? -0.1 : 0.1),
      ),
    );
  }

  Widget _buildReadMoreButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showAllArticles = true;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF002855), Color(0xFF0089D0)],
            ),
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0089D0).withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Read More Articles',
                style: GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.9, 0.9)),
    );
  }

  Widget _buildShowLessButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _showAllArticles = false;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: const Color(0xFF002855), width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF002855).withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Show Less',
                style: GoogleFonts.lato(
                  color: const Color(0xFF002855),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF002855).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Color(0xFF002855),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: 200.ms).scale(begin: const Offset(0.9, 0.9)),
    );
  }
}

// Marquee Widget for scrolling headlines
class _MarqueeWidget extends StatefulWidget {
  final List<Widget> children;

  const _MarqueeWidget({required this.children});

  @override
  State<_MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<_MarqueeWidget>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 200),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startMarquee();
    });
  }

  void _startMarquee() {
    if (!mounted) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll <= 0) return;

    _animationController.addListener(() {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_animationController.value * maxScroll);
      }
    });

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _scrollController.jumpTo(0);
        _animationController.reset();
        _animationController.forward();
      }
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          ...widget.children,
          ...widget.children, // Duplicate for continuous loop effect
        ],
      ),
    );
  }
}
