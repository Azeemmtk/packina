import 'package:flutter/material.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/widgets/hostel_details/preview_image_container_widget.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/const.dart';
import '../../../../../../../core/widgets/title_text_widget.dart';
import 'contact_reach_widget.dart';

class DescriptionPreviewSection extends StatelessWidget {

  final HostelEntity hostel;

  const DescriptionPreviewSection({
    super.key,
    required this.hostel,
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
          hostel.description,
          style: const TextStyle(fontSize: 16),
        ),
        height20,
        ContactReachWidget(hostel: hostel,),
        height20,
        RichText(
          text: TextSpan(
            style: TextStyle(fontSize: 18, color: headingTextColor),
            children: [
              const TextSpan(
                text: 'Owner name: ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: hostel.ownerName.isEmpty ? 'Unknown' : hostel.ownerName,
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
                text: hostel.contactNumber,
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
              imageUrl: index < hostel.smallImageUrls.length ? hostel.smallImageUrls[index] : null,
            ),
          ),
        ),
        height20,
      ],
    );
  }
}