import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart' as google_sign_in_package;
import 'package:packina/features/app/pages/manage_hostel/data/datasource/hostel_remote_data_source.dart';
import 'package:packina/features/app/pages/manage_hostel/data/repository/hostel_repository_impl.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/repository/hostel_repository.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/approve_hostel.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/get_hostel_data.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/reject_hostel.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/provider/bloc/hostel_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // External Dependencies
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // Data Sources
  getIt.registerLazySingleton<HostelRemoteDataSource>(
    () => HostelRemoteDataSourceImpl(
      getIt<FirebaseFirestore>(),
    ),
  );

  // Repositories
  getIt.registerLazySingleton<HostelRepository>(
    () => HostelRepositoryImpl(
      getIt<HostelRemoteDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(() => GetHostelData(getIt<HostelRepository>()));
  getIt.registerLazySingleton(() => ApproveHostel(getIt<HostelRepository>()));
  getIt.registerLazySingleton(() => RejectHostel(getIt<HostelRepository>()));

  // BLoCs
  getIt.registerFactory(
    () => HostelBloc(
      getHostelData: getIt<GetHostelData>(),
      approveHostel: getIt<ApproveHostel>(),
      rejectHostel: getIt<RejectHostel>(),
    ),
  );
}
