import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/const.dart';

class PreviewImageContainerWidget extends StatelessWidget {
  final String? imageUrl;

  const PreviewImageContainerWidget({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.3 - 3,
      height: height * 0.3,
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: imageUrl == null
          ? const Center(child: Text('No Image'))
          : ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          imageUrl!,
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              // Image loaded → fade in
              return AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 300),
                child: child,
              );
            }

            // Show shimmer while loading
            return Shimmer.fromColors(
              baseColor: secondaryColor,
              highlightColor: mainColor,
              direction: ShimmerDirection.ltr,
              child: Container(
                width: width * 0.3 - 3,
                height: height * 0.3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: textFieldColor,
            child: const Center(child: Text('No Image')),
          ),
        ),
      ),
    );
  }
}