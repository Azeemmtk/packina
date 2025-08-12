part of 'hostel_bloc.dart';

@immutable
sealed class HostelState extends Equatable {
  const HostelState();

  @override
  List<Object?> get props => [];
}

final class HostelInitial extends HostelState {
  const HostelInitial();
}

final class HostelLoading extends HostelState {
  const HostelLoading();
}

final class HostelLoaded extends HostelState {
  final List<HostelEntity> hostels;
  const HostelLoaded(this.hostels);
}

final class HostelError extends HostelState {
  final String message;
  const HostelError(this.message);
}

final class HostelApproved extends HostelState {
  final String hostelId;

  const HostelApproved(this.hostelId);

  @override
  List<Object?> get props => [hostelId];
}

final class HostelRejected extends HostelState {
  final String hostelId;

  const HostelRejected(this.hostelId);

  @override
  List<Object?> get props => [hostelId];
}
