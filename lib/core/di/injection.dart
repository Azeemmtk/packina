import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart' as google_sign_in_package;
import 'package:packina/features/app/pages/chat/data/datasource/chat_remote_data_source.dart';
import 'package:packina/features/app/pages/chat/data/datasource/owner_remote_data_source.dart';
import 'package:packina/features/app/pages/chat/data/repository/chat_repository_impl.dart';
import 'package:packina/features/app/pages/chat/data/repository/owner_repository_impl.dart';
import 'package:packina/features/app/pages/chat/domain/repository/chat_repository.dart';
import 'package:packina/features/app/pages/chat/domain/repository/owner_repository.dart';
import 'package:packina/features/app/pages/chat/domain/usecases/create_chat_use_case.dart';
import 'package:packina/features/app/pages/chat/domain/usecases/get_chats_use_case.dart';
import 'package:packina/features/app/pages/chat/domain/usecases/get_messages_use_case.dart';
import 'package:packina/features/app/pages/chat/domain/usecases/get_owner_details_use_case.dart';
import 'package:packina/features/app/pages/chat/domain/usecases/send_message_use_case.dart';
import 'package:packina/features/app/pages/chat/presentation/providers/bloc/allchats/all_chat_bloc.dart';
import 'package:packina/features/app/pages/chat/presentation/providers/bloc/chat/chat_bloc.dart';
import 'package:packina/features/app/pages/home/data/datasource/dashboard_remote_data_source.dart';
import 'package:packina/features/app/pages/home/data/repository/dashboard_repository_impl.dart';
import 'package:packina/features/app/pages/home/domain/repository/dashboard_repository.dart';
import 'package:packina/features/app/pages/home/domain/usecases/fetch_dashboard_data_use_case.dart';
import 'package:packina/features/app/pages/home/presentation/provide/bloc/dashboard/dashboard_bloc.dart';
import 'package:packina/features/app/pages/manage_hostel/data/datasource/hostel_remote_data_source.dart';
import 'package:packina/features/app/pages/manage_hostel/data/datasource/review_remote_data_source.dart';
import 'package:packina/features/app/pages/manage_hostel/data/repository/hostel_repository_impl.dart';
import 'package:packina/features/app/pages/manage_hostel/data/repository/review_repository_impl.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/repository/hostel_repository.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/repository/review_repository.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/approve_hostel.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/get_hostel_data.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/get_review_use_case.dart';
import 'package:packina/features/app/pages/manage_hostel/domain/usecases/reject_hostel.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/provider/bloc/hostel_bloc.dart';
import 'package:packina/features/app/pages/manage_hostel/presentation/provider/bloc/review/review_bloc.dart';
import 'package:packina/features/app/pages/manage_report/data/datasource/report_data_source.dart';
import 'package:packina/features/app/pages/manage_report/data/repository/report_repository_impl.dart';
import 'package:packina/features/app/pages/manage_report/domain/repository/report_repository.dart';
import 'package:packina/features/app/pages/manage_report/domain/usecases/fetch_report_usecase.dart';
import 'package:packina/features/app/pages/manage_report/domain/usecases/update_report_status_usecase.dart';
import 'package:packina/features/app/pages/manage_report/presentation/provider/bloc/report/report_bloc.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  /// External Dependencies
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  /// Data Sources
  getIt.registerLazySingleton<HostelRemoteDataSource>(
    () => HostelRemoteDataSourceImpl(
      getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<ReviewRemoteDataSource>(
        () => ReviewRemoteDataSourceImpl(
      getIt<FirebaseFirestore>(),
    ),
  );

  getIt.registerLazySingleton<ChatRemoteDataSource>(
        () => ChatRemoteDataSourceImpl(
      getIt<FirebaseFirestore>(),
    ),
  );
  getIt.registerLazySingleton<OwnerRemoteDataSource>(
        () => OwnerRemoteDataSourceImpl(
      getIt<FirebaseFirestore>(),
    ),
  );

  //report
  getIt.registerLazySingleton<ReportDataSource>(
        () => ReportDataSourceImpl(
      firestore:  getIt<FirebaseFirestore>(),
    ),
  );

  //dashboard
  getIt.registerLazySingleton<DashboardRemoteDataSource>(
        () => DashboardRemoteDataSourceImpl(
      firestore:  getIt<FirebaseFirestore>(),
    ),
  );

  /// Repositories
  getIt.registerLazySingleton<HostelRepository>(
    () => HostelRepositoryImpl(
      getIt<HostelRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<ReviewRepository>(
        () => ReviewRepositoryImpl(
      getIt<ReviewRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(
      getIt<ChatRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<OwnerRepository>(
        () => OwnerRepositoryImpl(
      getIt<OwnerRemoteDataSource>(),
    ),
  );

  //report
  getIt.registerLazySingleton<ReportRepository>(
        () => ReportRepositoryImpl(
      dataSource: getIt<ReportDataSource>()
    ),
  );

  //dashboard
  getIt.registerLazySingleton<DashboardRepository>(
        () => DashboardRepositoryImpl(getIt<DashboardRemoteDataSource>()),
  );

  /// Use Cases
  getIt.registerLazySingleton(() => GetHostelData(getIt<HostelRepository>()));
  getIt.registerLazySingleton(() => ApproveHostel(getIt<HostelRepository>()));
  getIt.registerLazySingleton(() => RejectHostel(getIt<HostelRepository>()));

  getIt.registerLazySingleton(() => GetReviewsUseCase(getIt<ReviewRepository>()));

  getIt.registerLazySingleton(() => CreateChatUseCase(getIt<ChatRepository>()));
  getIt.registerLazySingleton(() => GetChatsUseCase(getIt<ChatRepository>()));
  getIt.registerLazySingleton(() => GetMessagesUseCase(getIt<ChatRepository>()));
  getIt.registerLazySingleton(() => GetOwnerDetailsUseCase(getIt<OwnerRepository>()));
  getIt.registerLazySingleton(() => SendMessageUseCase(getIt<ChatRepository>()));

  //report
  getIt.registerLazySingleton(() => FetchReportsUseCase(getIt<ReportRepository>()));

  getIt.registerLazySingleton(() => UpdateReportStatusUseCase(getIt<ReportRepository>()));

  //dashboard
  getIt.registerLazySingleton(() => FetchDashboardDataUseCase(getIt<DashboardRepository>()));




  /// BLoCs
  getIt.registerFactory(
    () => HostelBloc(
      getHostelData: getIt<GetHostelData>(),
      approveHostel: getIt<ApproveHostel>(),
      rejectHostel: getIt<RejectHostel>(),
    ),
  );
  getIt.registerFactory(
        () => ReviewBloc(
      getReviewsUseCase: getIt<GetReviewsUseCase>(),
    ),
  );

  getIt.registerFactory(
        () => AllChatBloc(
          getIt<GetChatsUseCase>(),
    ),
  );

  getIt.registerFactoryParam<ChatBloc, String, void>(
        (chatId, _) => ChatBloc(
      getMessagesUseCase: getIt<GetMessagesUseCase>(),
      sendMessageUseCase: getIt<SendMessageUseCase>(),
      chatId: chatId,
    ),
  );


  //report
  getIt.registerFactory(
        () => ReportBloc(
      fetchReportsUseCase: getIt<FetchReportsUseCase>(),
          updateReportStatusUseCase: getIt<UpdateReportStatusUseCase>()
    ),
  );

  //dashboard
  getIt.registerFactory(
        () => DashboardBloc(
        fetchAdminDashboardDataUseCase: getIt<FetchDashboardDataUseCase>()
    ),
  );

}
