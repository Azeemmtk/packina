import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:packina/core/utils/enums.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/provider/bloc/hostel_bloc.dart';
import '../../../../../../core/constants/colors.dart';
import '../../../../../../core/constants/const.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../../../core/widgets/custom_green_button_widget.dart';
import '../../../../../../core/widgets/title_text_widget.dart';
import '../../../chat/domain/usecases/create_chat_use_case.dart';
import '../../../chat/domain/usecases/get_owner_details_use_case.dart';
import '../../../chat/presentation/screens/individual_chat_screen.dart';
import '../provider/bloc/review/review_bloc.dart';
import '../widgets/hostel_details/description_preview_section.dart';
import '../widgets/hostel_details/hostel_facility_name_section.dart';
import '../widgets/hostel_details/review_container.dart';
import '../widgets/hostel_details/review_room_section.dart';

class HostelDetailScreen extends StatelessWidget {
  const HostelDetailScreen({
    super.key,
    required this.hostel,
  });

  final HostelEntity hostel;

  void _navigateToChat(BuildContext context, String initialMessage) async {
    final createChatUseCase = getIt<CreateChatUseCase>();
    final getOwnerDetailUseCase = getIt<GetOwnerDetailsUseCase>();

    // Fetch owner details
    final ownerResult = await getOwnerDetailUseCase(GetOwnerDetailsParams(userId: hostel.ownerId));
    await ownerResult.fold(
          (failure) async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching owner details: ${failure.message}')),
        );
      },
          (ownerDetails) async {
        final chatResult = await createChatUseCase(CreateChatParams(userId: hostel.ownerId));
        chatResult.fold(
              (failure) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating chat: ${failure.message}')),
          ),
              (chatId) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IndividualChatScreen(
                  chatId: chatId,
                  otherName: ownerDetails['displayName'] ?? 'Unknown',
                  otherPhoto: ownerDetails['photoURL'] ?? '',
                  initialMessage: initialMessage,
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HostelBloc, HostelState>(
      listener: (context, state) {
        if (state is HostelApproved && state.hostelId == hostel.id) {
          // Do not pop the screen; instead, navigate to chat
          context.read<HostelBloc>().add(FetchHostelsData());
          _navigateToChat(context, 'Your hostel has been approved');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hostel approved successfully')),
          );
        } else if (state is HostelRejected && state.hostelId == hostel.id) {
          // Do not pop the screen; instead, navigate to chat
          context.read<HostelBloc>().add(FetchHostelsData());
          _navigateToChat(context, 'Your hostel has been rejected due to');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hostel rejected successfully')),
          );
        } else if (state is HostelError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: BlocProvider(
        create: (context) => getIt<ReviewBloc>()..add(FetchReviews(hostel.id)),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBarWidget(
                title: hostel.name,
              ),
            ),
            body: Column(
              children: [
                TabBar(
                  tabs: const [
                    Tab(text: 'Details'),
                    Tab(text: 'Review & Rating'),
                  ],
                  labelColor: headingTextColor,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: mainColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                height20,
                Expanded(
                  child: TabBarView(children: [
                    SingleChildScrollView(
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
                    SingleChildScrollView(
                      padding: EdgeInsets.all(padding),
                      child: Builder(
                        builder: (blocContext) => BlocConsumer<ReviewBloc, ReviewState>(
                          listener: (context, state) {
                            if (state is ReviewAdded) {
                              // Refresh reviews after adding a new one
                              blocContext.read<ReviewBloc>().add(FetchReviews(hostel.id));
                            }
                          },
                          builder: (context, state) {
                            print('Current ReviewBloc state: $state'); // Debugging
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                height20,
                                const TitleTextWidget(title: 'Review and rating'),
                                height10,
                                if (state is ReviewLoading)
                                  const Center(child: CircularProgressIndicator())
                                else if (state is ReviewLoaded)
                                  state.reviews.isNotEmpty
                                      ? Column(
                                    children: state.reviews
                                        .map((review) => ReviewContainer(review: review))
                                        .toList(),
                                  )
                                      : const Center(child: Text('No reviews yet'))
                                else if (state is ReviewError)
                                    Center(child: Text('Error: ${state.message}'))
                                  else
                                    const Center(child: Text('No reviews yet')),
                                height20,
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}