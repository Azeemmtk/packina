part of 'occupant_bloc.dart';

@immutable
sealed class OccupantState extends Equatable {
  const OccupantState();

  @override
  List<Object?> get props => [];
}

final class OccupantInitial extends OccupantState {
  const OccupantInitial();
}

final class OccupantLoading extends OccupantState {
  const OccupantLoading();
}

final class OccupantLoaded extends OccupantState {
  final List<OccupantEntity> occupants;

  const OccupantLoaded(this.occupants);

  @override
  List<Object?> get props => [occupants];
}

final class OccupantError extends OccupantState {
  final String message;

  const OccupantError(this.message);

  @override
  List<Object?> get props => [message];
}