import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../../../../../../core/widgets/custom_green_button_widget.dart';
import '../../../chat/domain/usecases/create_chat_use_case.dart';
import '../../../chat/domain/usecases/get_owner_details_use_case.dart';
import '../../../chat/presentation/screens/individual_chat_screen.dart';
import '../../domain/entity/report_entity.dart';
import '../provider/bloc/report/report_bloc.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReportBloc>()..add(FetchReportsEvent()),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBarWidget(title: 'Reports'),
        ),
        body: BlocBuilder<ReportBloc, ReportState>(
          builder: (context, state) {
            if (state is ReportLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReportLoaded) {
              final reports = state.reports;
              if (reports.isEmpty) {
                return const Center(child: Text('No reports available'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: reports.length,
                itemBuilder: (context, index) {
                  final report = reports[index];
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (report.imageUrl != null)
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      report.imageUrl!,
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                if (report.imageUrl != null)
                                  const SizedBox(height: 12.0),
                                Text(
                                  'Message:',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  report.message,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 12.0),
                                Text(
                                  'Status:',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  report.status,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                if (report.adminAction != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Admin Action:',
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          report.adminAction!,
                                          style: Theme.of(context).textTheme.bodyMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          // Right side: Buttons
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
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
                                          SnackBar(
                                            content: Text('Failed to fetch owner details: ${failure.message}'),
                                          ),
                                        );
                                      },
                                          (ownerDetails) async {
                                        final chatResult = await createChatUseCase(
                                          CreateChatParams(userId: report.ownerId),
                                        );
                                        chatResult.fold(
                                              (failure) => ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Failed to create chat: ${failure.message}'),
                                            ),
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
                                          SnackBar(
                                            content: Text('Failed to fetch occupant details: ${failure.message}'),
                                          ),
                                        );
                                      },
                                          (occupantDetails) async {
                                        final chatResult = await createChatUseCase(
                                          CreateChatParams(
                                            userId: report.senderId,
                                            collection: 'users',
                                          ),
                                        );
                                        chatResult.fold(
                                              (failure) => ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Failed to create chat: ${failure.message}'),
                                            ),
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is ReportError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const Center(child: Text('No reports available'));
          },
        ),
      ),
    );
  }
}