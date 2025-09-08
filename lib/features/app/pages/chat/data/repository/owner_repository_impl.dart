import 'package:dartz/dartz.dart';
import '../../../../../../core/error/exceptions.dart';
import '../../../../../../core/error/failures.dart';
import '../../domain/repository/owner_repository.dart';
import '../datasource/owner_remote_data_source.dart';

class OwnerRepositoryImpl implements OwnerRepository {
  final OwnerRemoteDataSource remoteDataSource;

  OwnerRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Map<String, String>>> getOwnerDetails(String ownerId, {String collection = 'hostel_owners'}) async {
    try {
      final result = await remoteDataSource.getOwnerDetails(ownerId,collection: collection);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}