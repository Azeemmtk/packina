part of 'report_bloc.dart';

abstract class ReportState extends Equatable {
  const ReportState();

  @override
  List<Object> get props => [];
}

class ReportInitial extends ReportState {}

class ReportLoading extends ReportState {}

class ReportSubmitted extends ReportState {}

class ReportLoaded extends ReportState {
  final List<ReportEntity> reports;

  const ReportLoaded({required this.reports});

  @override
  List<Object> get props => [reports];
}

class ReportError extends ReportState {
  final String message;

  const ReportError({required this.message});

  @override
  List<Object> get props => [message];
}