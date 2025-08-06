import 'package:flutter/material.dart';
import 'package:packina/features/auth/presentation/widgets/wave_clipper.dart';
import '../../../../core/constants/colors.dart';
import '../../../../core/utils/clip_shadow_path.dart';

class CurvedContainerWidget extends StatelessWidget {
  CurvedContainerWidget({
    super.key,
    required this.height,
    required this.title,
  });

  final double height;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipShadowPath(
          clipper: WaveClipper(),
          shadow: BoxShadow(
            color: Colors.black,
            offset: Offset(4, 4),
            blurRadius: 4,
            spreadRadius: 8,
          ),
          child: SizedBox(
            height: height,
            width: double.infinity,
            child: Image.asset('assets/images/Background.jpg',
                fit: BoxFit.cover),
          ),
        ),
        Positioned(
          left: 15,
          bottom: 50,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Positioned(
          left: 16,
          bottom: 45,
          child: SizedBox(
            width: 120,
            child: Divider(
              color: mainColor,
              thickness: 4,
              endIndent: 15,
            ),
          ),
        )
      ],
    );
  }
}
