import 'package:flutter/material.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/widgets/hostel_details/preview_image_container_widget.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/const.dart';
import '../../../../../../../core/widgets/title_text_widget.dart';

class DescriptionPreviewSection extends StatelessWidget {
  final String description;
  final String ownerName;
  final String contactNumber;
  final List<String> smallImageUrls;

  const DescriptionPreviewSection({
    super.key,
    required this.description,
    required this.ownerName,
    required this.contactNumber,
    required this.smallImageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        height20,
        const TitleTextWidget(title: 'Description'),
        height10,
        Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
        height10,
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 18, color: headingTextColor),
            children: [
              const TextSpan(
                text: 'Owner name: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ownerName.isEmpty ? 'Unknown' : ownerName,
                style: TextStyle(color: customGrey),
              ),
            ],
          ),
        ),
        height5,
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 18, color: headingTextColor),
            children: [
              const TextSpan(
                text: 'Contact: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: contactNumber,
                style: TextStyle(color: customGrey),
              ),
            ],
          ),
        ),
        height20,
        const TitleTextWidget(title: 'Preview'),
        height10,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            3,
                (index) => PreviewImageContainerWidget(
              imageUrl: index < smallImageUrls.length ? smallImageUrls[index] : null,
            ),
          ),
        ),
        height20,
      ],
    );
  }
}