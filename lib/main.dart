import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'sections/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/principles_section.dart';
import 'sections/stats_section.dart';
import 'sections/mission_section.dart';
import 'sections/services_section.dart';
import 'sections/headlines_section.dart';
import 'sections/footer_section.dart';
import 'screens/article_detail_screen.dart';
import 'models/law_update.dart';

void main() {
  runApp(const HNALawApp());
}

class HNALawApp extends StatelessWidget {
  const HNALawApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HNA LAW CHAMBERS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF002855),
          primary: const Color(0xFF002855),
          secondary: const Color(0xFF0089D0),
        ),
        textTheme: GoogleFonts.latoTextTheme(),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        // Named routes
        switch (settings.name) {
          case '/':
            return _createRoute(const LandingPage());
          case '/article':
            final article = settings.arguments as LawUpdate;
            return _createRoute(ArticleDetailScreen(article: article));
          default:
            return _createRoute(const LandingPage());
        }
      },
    );
  }

  // Custom page route with fade transition for web feel
  Route<dynamic> _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  Key _refreshKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildMobileDrawer(context),
      body: Column(
        children: [
          const HNANavbar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Force a rebuild of the content by updating the key
                setState(() {
                  _refreshKey = UniqueKey();
                });
                await Future.delayed(const Duration(seconds: 1));
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const HeroSection(),
                    HeadlinesSection(
                      key: _refreshKey,
                    ), // Force rebuild on refresh
                    const AboutSection(),
                    const PrinciplesSection(),
                    const StatsSection(),
                    const MissionSection(),
                    const ServicesSection(),
                    const FooterSection(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF002855)),
            child: Center(
              child: Text(
                'HNA LAW',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          _buildDrawerItem('Home', onTap: () => Navigator.pop(context)),
          _buildDrawerItem('About', onTap: () => Navigator.pop(context)),
          _buildDrawerItem('Services', onTap: () => Navigator.pop(context)),
          _buildDrawerItem('Team', onTap: () => Navigator.pop(context)),
          _buildDrawerItem('Contact', onTap: () => Navigator.pop(context)),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(String title, {required VoidCallback onTap}) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.lato(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF333333),
        ),
      ),
      onTap: onTap,
    );
  }
}
