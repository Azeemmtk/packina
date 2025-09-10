import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  late AnimationController _loadingController;

  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _loadingFadeAnimation;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _textController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _loadingController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeInOut));
    _logoScaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(CurvedAnimation(parent: _logoController, curve: Curves.elasticOut));
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));
    _textSlideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic));
    _loadingFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _loadingController, curve: Curves.easeIn));

    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const WelcomeScreen()));
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSize(context);
    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    _logoController.forward();
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) _textController.forward();
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) _loadingController.forward();
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _loadingController.dispose();
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.3)],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SplashLogoWidget(controller: _logoController, fade: _logoFadeAnimation, scale: _logoScaleAnimation),
                SplashTextWidget(controller: _textController, fade: _textFadeAnimation, slide: _textSlideAnimation),
                const SizedBox(height: 10),
                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Text(
                    'Find Your Perfect Stay',
                    style: GoogleFonts.poppins(
                      fontSize: 25,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SplashLoadingWidget(controller: _loadingController, fade: _loadingFadeAnimation),
              ],
            ),
          ),

          // Version Text
          SplashVersionWidget(controller: _textController, fade: _textFadeAnimation),
        ],
      ),
    );
  }
}
