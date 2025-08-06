import 'package:flutter/material.dart';
import 'package:packina/features/app/pages/manage_hostel/data/model/hostel_model.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/widgets/hostel_details/review_container.dart';
import '../../../../../../../core/constants/const.dart';
import '../../../../../../../core/widgets/title_text_widget.dart';
import 'available_room_widget.dart';

class ReviewRoomSection extends StatelessWidget {
  const ReviewRoomSection({
    super.key,
    required this.hostel,
  });

  final HostelEntity hostel;

  // 'type': 'Ac',
  // 'count': 7,
  // 'rate': 2500.0,

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleTextWidget(title: 'Review and rating'),
        height10,
        const ReviewContainer(),
        height10,
        const ReviewContainer(),
        height20,
        const TitleTextWidget(title: 'Rooms'),
        height10,
        ...hostel.rooms.map((room) => AvailableRoomWidget(
              type: room['type'],
              count: room['count'],
              rate: room['rate'],
            )),
        height5,
        height20,
      ],
    );
  }
}
