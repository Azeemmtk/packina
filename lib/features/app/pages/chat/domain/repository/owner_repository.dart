import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failures.dart';


abstract class OwnerRepository {
  Future<Either<Failure, Map<String, String>>> getOwnerDetails(String ownerId, {String collection = 'hostel_owners'});
}