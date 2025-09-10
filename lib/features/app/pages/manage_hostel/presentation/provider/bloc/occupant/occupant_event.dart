part of 'occupant_bloc.dart';

@immutable
sealed class OccupantEvent extends Equatable {
  const OccupantEvent();

  @override
  List<Object?> get props => [];
}

final class FetchOccupants extends OccupantEvent {
  final String hostelId;

  const FetchOccupants(this.hostelId);

  @override
  List<Object?> get props => [hostelId];
}