import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/widgets/custom_app_bar_widget.dart';
import '../provider/bloc/report/report_bloc.dart';
import '../widgets/report_card_widget.dart';

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
                  return ReportCardWidget(report: reports[index]);
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
