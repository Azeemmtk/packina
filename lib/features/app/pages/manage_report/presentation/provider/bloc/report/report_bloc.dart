import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import '../../../../domain/entity/report_entity.dart';
import '../../../../domain/usecases/block_hostel_use_case.dart';
import '../../../../domain/usecases/fetch_report_usecase.dart';
import '../../../../domain/usecases/update_report_status_usecase.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final FetchReportsUseCase fetchReportsUseCase;
  final UpdateReportStatusUseCase updateReportStatusUseCase;
  final BlockHostelUseCase blockHostelUseCase;

  ReportBloc({
    required this.fetchReportsUseCase,
    required this.updateReportStatusUseCase,
    required this.blockHostelUseCase,
  }) : super(ReportInitial()) {
    on<FetchReportsEvent>(_onFetchReports);
    on<SubmitReportEvent>(_onSubmitReport);
    on<BlockHostelEvent>(_onBlockHostel);
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
      UpdateReportStatusParams(reportId: event.report.id!, status: event.report.status, action: event.report.adminAction!),
    );
    emit(result.fold(
          (failure) => ReportError(message: failure.message),
          (success) {
        if (success) {
          add(FetchReportsEvent());
          return ReportSubmitted();
        }
        return ReportError(message: 'Failed to update report status');
      },
    ));
  }

  Future<void> _onBlockHostel(BlockHostelEvent event, Emitter<ReportState> emit) async {
    emit(ReportLoading());
    final result = await blockHostelUseCase(
      BlockHostelParams(hostelId: event.hostelId),
    );
    emit(result.fold(
          (failure) => ReportError(message: failure.message),
          (success) {
        if (success) {
          add(FetchReportsEvent());
          return ReportSubmitted();
        }
        return ReportError(message: 'Failed to block hostel');
      },
    ));
  }
}