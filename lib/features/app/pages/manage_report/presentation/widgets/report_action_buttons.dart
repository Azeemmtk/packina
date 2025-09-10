import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/widgets/custom_green_button_widget.dart';
import '../../../chat/domain/usecases/create_chat_use_case.dart';
import '../../../chat/domain/usecases/get_owner_details_use_case.dart';
import '../../../chat/presentation/screens/individual_chat_screen.dart';
import '../../domain/entity/report_entity.dart';
import '../provider/bloc/report/report_bloc.dart';

class ReportActionButtons extends StatelessWidget {
  final ReportEntity report;

  const ReportActionButtons({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Chat with Owner
          CustomGreenButtonWidget(
            name: 'Chat with Owner',
            onPressed: () async {
              final createChatUseCase = getIt<CreateChatUseCase>();
              final getOwnerDetailUseCase = getIt<GetOwnerDetailsUseCase>();

              final ownerResult = await getOwnerDetailUseCase(
                GetOwnerDetailsParams(
                  userId: report.ownerId,
                  collection: 'hostel_owners',
                ),
              );
              await ownerResult.fold(
                    (failure) async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed: ${failure.message}')),
                  );
                },
                    (ownerDetails) async {
                  final chatResult = await createChatUseCase(
                    CreateChatParams(userId: report.ownerId),
                  );
                  chatResult.fold(
                        (failure) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed: ${failure.message}')),
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
          const SizedBox(height: 12.0),

          // Chat with Occupant
          CustomGreenButtonWidget(
            name: 'Chat with Occupant',
            onPressed: () async {
              final createChatUseCase = getIt<CreateChatUseCase>();
              final getOwnerDetailUseCase = getIt<GetOwnerDetailsUseCase>();

              final occupantResult = await getOwnerDetailUseCase(
                GetOwnerDetailsParams(
                  userId: report.senderId,
                  collection: 'users',
                ),
              );
              await occupantResult.fold(
                    (failure) async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed: ${failure.message}')),
                  );
                },
                    (occupantDetails) async {
                  final chatResult = await createChatUseCase(
                    CreateChatParams(userId: report.senderId, collection: 'users'),
                  );
                  chatResult.fold(
                        (failure) => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed: ${failure.message}')),
                    ),
                        (chatId) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IndividualChatScreen(
                            chatId: chatId,
                            otherName: occupantDetails['displayName']!,
                            otherPhoto: occupantDetails['photoURL']!,
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),

          // Mark as Resolved
          if (report.status == 'pending')
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: CustomGreenButtonWidget(
                name: 'Mark as Resolved',
                onPressed: () {
                  final updatedReport = ReportEntity(
                    id: report.id,
                    message: report.message,
                    imageUrl: report.imageUrl,
                    senderId: report.senderId,
                    hostelId: report.hostelId,
                    ownerId: report.ownerId,
                    createdAt: report.createdAt,
                    status: 'resolved',
                    adminAction: 'Marked as resolved on ${DateTime.now()}',
                  );
                  context.read<ReportBloc>().add(
                    SubmitReportEvent(report: updatedReport),
                  );
                },
              ),
            ),

          // Block Hostel
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: CustomGreenButtonWidget(
              name: 'Block Hostel',
              onPressed: () {
                context.read<ReportBloc>().add(
                  BlockHostelEvent(hostelId: report.hostelId),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}