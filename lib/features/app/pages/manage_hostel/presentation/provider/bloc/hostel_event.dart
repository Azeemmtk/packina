part of 'hostel_bloc.dart';

@immutable
sealed class HostelEvent extends Equatable {
  const HostelEvent();

  @override
  List<Object?> get props => [];
}

final class FetchHostelsData extends HostelEvent {}

final class HostelApprove extends HostelEvent {
  final String hostelId;

  const HostelApprove(this.hostelId);

  @override
  List<Object?> get props => [hostelId];
}

final class HostelReject extends HostelEvent {
  final String hostelId;

  const HostelReject(this.hostelId);

  @override
  List<Object?> get props => [hostelId];
}
