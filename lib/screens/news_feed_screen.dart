import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/law_update.dart';
import '../services/api_service.dart';
import 'article_detail_screen.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen>
    with TickerProviderStateMixin {
  List<LawUpdate> _updates = [];
  bool _isLoading = true;
  bool _isScraping = false;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _initializeData();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _initializeData() async {
    // First, fetch existing updates
    await _fetchUpdates();

    // Then trigger a background scrape (won't block UI)
    _triggerBackgroundScrape();
  }

  Future<void> _fetchUpdates() async {
    setState(() => _isLoading = true);

    final updates = await ApiService.getUpdates(limit: 100);

    setState(() {
      _updates = updates;
      _isLoading = false;
    });
  }

  Future<void> _triggerBackgroundScrape() async {
    setState(() => _isScraping = true);

    await ApiService.triggerScrape();

    // Wait a bit then refresh
    await Future.delayed(const Duration(seconds: 5));

    setState(() => _isScraping = false);

    // Refresh the list
    _fetchUpdates();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: _isLoading
                  ? _buildLoadingState()
                  : _updates.isEmpty
                  ? _buildEmptyState()
                  : _buildNewsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF1A237E).withOpacity(0.8),
            const Color(0xFF0D47A1).withOpacity(0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.gavel_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOP NEWS',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'Headlines',
                        style: GoogleFonts.playfairDisplay(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  if (_isScraping)
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(
                              0.2 + (_pulseController.value * 0.3),
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.green.withOpacity(0.5),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.green.shade300,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Updating...',
                                style: GoogleFonts.poppins(
                                  color: Colors.green.shade300,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  const SizedBox(width: 12),
                  IconButton(
                    onPressed: _fetchUpdates,
                    icon: const Icon(Icons.refresh_rounded),
                    color: Colors.white70,
                    tooltip: 'Refresh',
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              children: [
                Icon(Icons.article_outlined, color: Colors.white60, size: 18),
                const SizedBox(width: 10),
                Text(
                  '${_updates.length} Articles',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _isScraping ? Colors.orange : Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _isScraping ? 'Fetching new articles' : 'Live',
                  style: GoogleFonts.poppins(
                    color: _isScraping
                        ? Colors.orange.shade300
                        : Colors.green.shade300,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(color: Color(0xFF00BCD4)),
          const SizedBox(height: 20),
          Text(
            'Loading headlines...',
            style: GoogleFonts.poppins(color: Colors.white60, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.newspaper, size: 80, color: Colors.white24),
          const SizedBox(height: 20),
          Text(
            'No articles yet',
            style: GoogleFonts.poppins(
              color: Colors.white60,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Pull to refresh or wait for updates',
            style: GoogleFonts.poppins(color: Colors.white38, fontSize: 14),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: _triggerBackgroundScrape,
            icon: const Icon(Icons.refresh),
            label: const Text('Fetch Articles'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00BCD4),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsList() {
    return RefreshIndicator(
      onRefresh: _fetchUpdates,
      color: const Color(0xFF00BCD4),
      backgroundColor: const Color(0xFF1A1F38),
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: _updates.length,
        itemBuilder: (context, index) {
          final update = _updates[index];
          return _buildNewsCard(update, index);
        },
      ),
    );
  }

  Widget _buildNewsCard(LawUpdate update, int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 400 + (index * 50)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ArticleDetailScreen(article: update),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position:
                                Tween<Offset>(
                                  begin: const Offset(0.1, 0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOutCubic,
                                  ),
                                ),
                            child: child,
                          ),
                        );
                      },
                  transitionDuration: const Duration(milliseconds: 300),
                ),
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [const Color(0xFF1A1F38), const Color(0xFF252942)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: _getSourceColor(
                            update.sourceId,
                          ).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getSourceName(update.sourceId),
                          style: GoogleFonts.poppins(
                            color: _getSourceColor(update.sourceId),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.access_time_rounded,
                        size: 14,
                        color: Colors.white38,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getTimeAgo(update.scrapedAt),
                        style: GoogleFonts.poppins(
                          color: Colors.white38,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    update.title,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Read more',
                        style: GoogleFonts.poppins(
                          color: const Color(0xFF00BCD4),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                        color: Color(0xFF00BCD4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
        return const Color(0xFFE91E63); // Pink
      case 2:
        return const Color(0xFF4CAF50); // Green
      case 3:
        return const Color(0xFFFF9800); // Orange
      default:
        return const Color(0xFF2196F3); // Blue
    }
  }
}
