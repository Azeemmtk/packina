import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:packina/features/app/pages/manage_hostel/data/model/hostel_model.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/entity/hostel_entity.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/approve_hostel.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/get_hostel_data.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/reject_hostel.dart';

part 'hostel_event.dart';
part 'hostel_state.dart';

class HostelBloc extends Bloc<HostelEvent, HostelState> {
  final GetHostelData getHostelData;
  final ApproveHostel approveHostel;
  final RejectHostel rejectHostel;

  HostelBloc({required this.getHostelData, required this.approveHostel, required this.rejectHostel })
      : super(HostelInitial()) {
    on<FetchHostelsData>((event, emit) async {
      emit(HostelLoading());
      final result = await getHostelData();
      result.fold(
        (failure) => emit(HostelError(failure.message)),
        (hostels) => emit(HostelLoaded(hostels)),
      );
    });
    on<HostelApprove>(
      (event, emit) async {
        emit(HostelLoading());
        final result = await approveHostel(event.hostelId);
        result.fold(
          (failure) => emit(HostelError(failure.message)),
          (_) => emit(HostelApproved(event.hostelId)),
        );
      },
    );
    on<HostelReject>(
      (event, emit) async {
        emit(HostelLoading());
        final result = await rejectHostel(event.hostelId);
        result.fold(
          (failure) => emit(HostelError(failure.message)),
          (_) => emit(HostelRejected(event.hostelId)),
        );
      },
    );
  }
}
