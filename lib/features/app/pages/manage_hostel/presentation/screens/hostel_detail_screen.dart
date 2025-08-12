import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/provider/bloc/hostel_bloc.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../../../core/widgets/custom_green_button_widget.dart';
import '../widgets/hostel_details/description_preview_section.dart';
import '../widgets/hostel_details/hostel_facility_name_section.dart';
import '../widgets/hostel_details/review_room_section.dart';

class HostelDetailScreen extends StatelessWidget {
  const HostelDetailScreen({
    super.key,
    required this.hostel,
  });

  final HostelEntity hostel;

  @override
  Widget build(BuildContext context) {
    return BlocListener<HostelBloc, HostelState>(
      listener: (context, state) {
        if (state is HostelApproved && state.hostelId == hostel.id) {
          Navigator.pop(context);
          context.read<HostelBloc>().add(FetchHostelsData());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hostel approved successfully')),
          );
        } else if (state is HostelRejected && state.hostelId == hostel.id) {
          Navigator.pop(context);
          context.read<HostelBloc>().add(FetchHostelsData());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hostel rejected successfully')),
          );
        } else if (state is HostelError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            CustomAppBarWidget(
              title: 'hostel name',
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HostelFacilityNameSection(hostel: hostel),
                      DescriptionPreviewSection(
                        hostel: hostel,
                      ),
                      ReviewRoomSection(hostel: hostel),
                      Row(
                        children: [],
                      ),
                      height20,
                      CustomGreenButtonWidget(
                        name: 'Approve',
                        onPressed: () {
                          if (!hostel.approved) {
                            context
                                .read<HostelBloc>()
                                .add(HostelApprove(hostel.id));
                          }
                        },
                      ),
                      height20,
                      CustomGreenButtonWidget(
                        name: 'Reject',
                        color: Colors.redAccent,
                        onPressed: () {
                          if (hostel.approved) {
                            context
                                .read<HostelBloc>()
                                .add(HostelReject(hostel.id));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
