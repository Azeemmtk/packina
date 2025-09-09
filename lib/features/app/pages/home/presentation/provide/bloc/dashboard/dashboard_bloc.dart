import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:packina/core/error/failures.dart';

import '../../../../domain/entity/dashboard_data.dart';
import '../../../../domain/usecases/fetch_dashboard_data_use_case.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FetchDashboardDataUseCase fetchAdminDashboardDataUseCase;

  DashboardBloc({required this.fetchAdminDashboardDataUseCase})
      : super(DashboardInitial()) {
    on<FetchDashboardData>(_onFetchAdminDashboardData);
  }

  Future<void> _onFetchAdminDashboardData(
      FetchDashboardData event, Emitter<DashboardState> emit) async {
    emit(DashboardLoading());
    final result = await fetchAdminDashboardDataUseCase();
    result.fold(
          (failure) => emit(DashboardError(_mapFailureToMessage(failure))),
          (adminDashboardData) => emit(DashboardLoaded(adminDashboardData)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error occurred';
      case AuthFailure:
        return 'Authentication error';
      default:
        return 'Unexpected error';
    }
  }
}