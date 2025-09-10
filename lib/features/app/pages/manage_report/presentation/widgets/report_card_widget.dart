import 'package:flutter/material.dart';
import 'package:packina/features/app/pages/manage_report/presentation/widgets/report_action_buttons.dart';
import '../../domain/entity/report_entity.dart';

class ReportCardWidget extends StatelessWidget {
  final ReportEntity report;

  const ReportCardWidget({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
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
            // Left side: Report details
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
                  if (report.imageUrl != null) const SizedBox(height: 12.0),
                  Text(
                    'Message:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(report.message, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12.0),
                  Text(
                    'Status:',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(report.status, style: Theme.of(context).textTheme.bodyMedium),
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
                          Text(report.adminAction!, style: Theme.of(context).textTheme.bodyMedium),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),

            // Right side: Action Buttons
            ReportActionButtons(report: report),
          ],
        ),
      ),
    );
  }
}
