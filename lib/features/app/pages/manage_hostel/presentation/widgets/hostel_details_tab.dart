import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packina/core/constants/const.dart';
import 'package:packina/core/utils/enums.dart';
import 'package:packina/core/widgets/custom_green_button_widget.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/provider/bloc/hostel_bloc.dart';
import '../provider/bloc/occupant/occupant_bloc.dart';
import 'hostel_details/description_preview_section.dart';
import 'hostel_details/hostel_facility_name_section.dart';
import 'hostel_details/review_room_section.dart';
import '../../../../../../core/di/injection.dart';

class HostelDetailsTab extends StatelessWidget {
  const HostelDetailsTab({
    super.key,
    required this.hostel,
  });

  final HostelEntity hostel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OccupantBloc>()..add(FetchOccupants(hostel.id)),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HostelFacilityNameSection(hostel: hostel),
              DescriptionPreviewSection(hostel: hostel),
              ReviewRoomSection(hostel: hostel),
              height20,
              Card(
                elevation: 2,
                child: ExpansionTile(
                  title: Text(
                    'Occupants',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    BlocBuilder<OccupantBloc, OccupantState>(
                      builder: (context, state) {
                        if (state is OccupantLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is OccupantLoaded) {
                          if (state.occupants.isEmpty) {
                            return Padding(
                              padding: EdgeInsets.all(16),
                              child: Text('No occupants found.'),
                            );
                          }
                          return Column(
                            children: state.occupants.map((occupant) {
                              return ListTile(
                                leading: occupant.profileImageUrl != null
                                    ? CircleAvatar(
                                  backgroundImage: NetworkImage(occupant.profileImageUrl!),
                                )
                                    : CircleAvatar(child: Icon(Icons.person)),
                                title: Text(occupant.name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Age: ${occupant.age}'),
                                    Text('Phone: ${occupant.phone}'),
                                    Text('Room Type: ${occupant.roomType}'),
                                    Text('Rent Paid: ${occupant.rentPaid ? 'Yes' : 'No'}'),
                                    if (occupant.adminAction != null)
                                      Text('Admin Action: ${occupant.adminAction}'),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        } else if (state is OccupantError) {
                          return Padding(
                            padding: EdgeInsets.all(16),
                            child: Text('Error: ${state.message}'),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
              height20,
              CustomGreenButtonWidget(
                name: 'Approve',
                onPressed: () {
                  if (hostel.status != Status.approved) {
                    context.read<HostelBloc>().add(HostelApprove(hostel.id));
                  }
                },
              ),
              height20,
              CustomGreenButtonWidget(
                name: 'Reject',
                color: Colors.redAccent,
                onPressed: () {
                  if (hostel.status != Status.rejected) {
                    context.read<HostelBloc>().add(HostelReject(hostel.id));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}