import 'package:flutter/material.dart';
import 'package:packina/app_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../../../core/constants/colors.dart';
import '../../../../../../../core/constants/const.dart';
import '../../../../../../../core/di/injection.dart';
import '../../../../chat/domain/usecases/create_chat_use_case.dart';
import '../../../../chat/domain/usecases/get_owner_details_use_case.dart';
import '../../../../chat/presentation/screens/individual_chat_screen.dart';
import '../../../domain/entity/hostel_entity.dart';

class ContactReachWidget extends StatelessWidget {
  const ContactReachWidget({
    super.key,
    required this.hostel,
  });

  final HostelEntity hostel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildContainer(
          text: 'Message',
          icon: Icons.message,
          onPressed: () async {
            AppState.isAdmin= true;
            final createChatUseCase = getIt<CreateChatUseCase>();
            final getOwnerDetailUseCase = getIt<GetOwnerDetailsUseCase>();

            // Fetch owner details
            final ownerResult = await getOwnerDetailUseCase(GetOwnerDetailsParams(userId: hostel.ownerId,));
            await ownerResult.fold(
                  (failure) async {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('1${failure.message}')),
                );
              },
                  (ownerDetails) async {
                    print(hostel.ownerId);
                final chatResult = await createChatUseCase(CreateChatParams(userId: hostel.ownerId));
                chatResult.fold(
                      (failure) => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('2${failure.message}')),
                  ),
                      (chatId) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndividualChatScreen(
                          chatId: chatId,
                          otherName: ownerDetails['displayName']!,
                          otherPhoto: ownerDetails['photoURL']!,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
        _buildContainer(
          text: 'Call',
          icon: Icons.call,
          onPressed: () async {
            final Uri telUri = Uri(scheme: 'tel', path: hostel.contactNumber);

            await launchUrl(
              telUri,
              mode: LaunchMode.externalApplication,
            );
          },
        ),
        _buildContainer(
          text: 'Direction',
          icon: Icons.location_on_outlined,
          onPressed: () async {
            final Uri googleMapsUrl = Uri.parse(
                'https://www.google.com/maps/dir/?api=1&destination=${hostel.latitude},${hostel.longitude}');

            await launchUrl(
              googleMapsUrl,
              mode: LaunchMode.externalApplication,
            );
          },
        ),
      ],
    );
  }

  Container _buildContainer({
    required IconData icon,
    required String text,
    required Function() onPressed,
  }) {
    return Container(
      width: width * 0.3 - 3,
      height: height * 0.2,
      decoration: BoxDecoration(
        color: textFieldColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
          onPressed: onPressed,
          icon: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: mainColor,
                size: 30,
              ),
              Text(
                text,
                style: TextStyle(color: mainColor, fontSize: 18),
              )
            ],
          )),
    );
  }
}