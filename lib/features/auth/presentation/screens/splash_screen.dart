import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:packina/core/constants/colors.dart';
import 'package:packina/features/auth/presentation/screens/welcome_screen.dart';
import '../../../../core/constants/const.dart';
import '../widgets/splash/splash_loading_widget.dart';
import '../widgets/splash/splash_logo_widget.dart';
import '../widgets/splash/splash_text_widget.dart';
import '../widgets/splash/splash_version_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _accentController;

  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _accentFade;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _accentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeIn),
    );

    _textSlideAnimation = Tween<Offset>(begin: const Offset(0, 0.35), end: Offset.zero).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    _accentFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _accentController, curve: Curves.easeIn),
    );

    // Start the sequence reliably without Timer race
    _runSequence();
  }

  Future<void> _runSequence() async {
    //Logo animate in
    await _logoController.forward();

    //Small pause for polish
    await Future.delayed(const Duration(milliseconds: 150));

    // Text animate in
    await _textController.forward();

    // Show subtle accent: shimmer/progress fade-in
    _accentController.repeat(reverse: true);
    await Future.delayed(const Duration(milliseconds: 600));

    // Navigate with a professional fade route
    if (!mounted) return;
    await _navigateToWelcome();
  }

  Future<void> _navigateToWelcome() async {
    await Navigator.of(context).pushReplacement(_fadeRoute(const WelcomeScreen())); // [web:10][web:2]
  }

  PageRouteBuilder _fadeRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, animation, __) => FadeTransition(opacity: animation, child: page),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSize(context);
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _accentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getSize(context);
    return Scaffold(
      body: Stack(
        children: [
          // Background
          SizedBox.expand(
            child: Stack(
              children: [
                Image.asset(
                  'assets/images/Background.jpg',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Container(
                  color: Colors.white.withOpacity(0.85),
                ),
              ],
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SplashLogoWidget(
                  controller: _logoController,
                  fade: _logoFadeAnimation,
                  scale: _logoScaleAnimation,
                ),
                height20,
                SplashTextWidget(
                  controller: _textController,
                  fade: _textFadeAnimation,
                  slide: _textSlideAnimation,
                ),
                height10,
                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Text(
                    'Find Your Perfect Stay',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: mainColor.withOpacity(0.9),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.35),
                          offset: const Offset(2, 2),
                          blurRadius: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                height20,
                // Subtle, professional activity cue
                FadeTransition(
                  opacity: _accentFade,
                  child: SizedBox(
                    height: 4,
                    width: 120,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: LinearProgressIndicator(
                        minHeight: 4,
                        backgroundColor: mainColor.withOpacity(0.15),
                        color: mainColor.withOpacity(0.9),
                      ),
                    ),
                  ),
                ),
                height10,
                // Optional version text widget if desired
                // const SplashVersionWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
