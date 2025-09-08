import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../../domain/entity/report_entity.dart';
import '../../../../domain/usecases/fetch_report_usecase.dart';
import '../../../../domain/usecases/update_report_status_usecase.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final FetchReportsUseCase fetchReportsUseCase;
  final UpdateReportStatusUseCase updateReportStatusUseCase;

  ReportBloc({
    required this.fetchReportsUseCase,
    required this.updateReportStatusUseCase,
  }) : super(ReportInitial()) {
    on<FetchReportsEvent>(_onFetchReports);
    on<SubmitReportEvent>(_onSubmitReport);
  }

  Future<void> _onFetchReports(FetchReportsEvent event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    final result = await fetchReportsUseCase();
    emit(result.fold(
          (failure) => ReportError(message: failure.message),
          (reports) => ReportLoaded(reports: reports),
    ));
  }

  Future<void> _onSubmitReport(SubmitReportEvent event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    final result = await updateReportStatusUseCase(
      UpdateReportStatusParams(reportId: event.report.id!, status: 'resolved'),
    );
    emit(result.fold(
          (failure) => ReportError(message: failure.message),
          (success) {
        if (success) {
          add(FetchReportsEvent()); // Refresh the list after successful update
          return ReportSubmitted();
        }
        return ReportError(message: 'Failed to update report status');
      },
    ));
  }
}