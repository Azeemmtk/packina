import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/occupant_entity.dart';
import '../../../../domain/usecases/get_occupant_by_hostel_id.dart';

part 'occupant_event.dart';
part 'occupant_state.dart';

class OccupantBloc extends Bloc<OccupantEvent, OccupantState> {
  final GetOccupantsByHostelId getOccupantsByHostelId;

  OccupantBloc({required this.getOccupantsByHostelId}) : super(OccupantInitial()) {
    on<FetchOccupants>((event, emit) async {
      emit(OccupantLoading());
      final result = await getOccupantsByHostelId(event.hostelId);
      result.fold(
            (failure) => emit(OccupantError(failure.message)),
            (occupants) => emit(OccupantLoaded(occupants)),
      );
    });
  }
}