import 'package:flutter/material.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';
import '../../../../../../../core/constants/const.dart';
import '../../../../../../../core/widgets/title_text_widget.dart';
import 'available_room_widget.dart';
import 'review_container.dart';

class ReviewRoomSection extends StatelessWidget {
  const ReviewRoomSection({
    super.key,
    required this.hostel,
  });

  final HostelEntity hostel;

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

        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 800) {
              int crossAxisCount = (constraints.maxWidth ~/ 300).clamp(2, 6);

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: height * 0.3,
                ),
                itemCount: hostel.rooms.length,
                itemBuilder: (context, index) {
                  return AvailableRoomWidget(room: hostel.rooms[index]);
                },
              );
            } else {
              return Column(
                children: hostel.rooms
                    .map((room) => AvailableRoomWidget(room: room))
                    .toList(),
              );
            }
          },
        ),
        height5,
        height20,
      ],
    );
  }
}
