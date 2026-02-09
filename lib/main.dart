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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const HNANavbar(),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: const Column(
                children: [
                  HeroSection(),
                  HeadlinesSection(), // Top News Headlines
                  AboutSection(),
                  PrinciplesSection(),
                  StatsSection(),
                  MissionSection(),
                  ServicesSection(),
                  FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
