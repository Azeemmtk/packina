import 'package:flutter/material.dart';
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
        image: imageUrl != null
            ? DecorationImage(
          image: NetworkImage(imageUrl!),
          fit: BoxFit.fill,
        )
            : null,
      ),
      child: imageUrl == null
          ? const Center(child: Text('No Image'))
          : null,
    );
  }
}