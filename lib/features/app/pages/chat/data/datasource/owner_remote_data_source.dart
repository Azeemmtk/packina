import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../../core/error/exceptions.dart';

abstract class OwnerRemoteDataSource {
  Future<Map<String, String>> getOwnerDetails(String userId, {String collection = 'hostel_owners'});
}

class OwnerRemoteDataSourceImpl implements OwnerRemoteDataSource {
  final FirebaseFirestore firestore;

  OwnerRemoteDataSourceImpl(this.firestore);

  @override
  Future<Map<String, String>> getOwnerDetails(String userId, {String collection = 'hostel_owners'}) async {
    print('------collection==$collection');
    try {
      final doc = await firestore.collection(collection).doc(userId).get();
      if (!doc.exists) {
        throw ServerException('$collection user not found');
      }
      print('doc$doc');
      final data = doc.data() as Map<String, dynamic>;
      print('data========$data');
      return {
        'displayName': data['displayName']?.toString() ?? 'Unknown',
        'photoURL': data['photoURL']?.toString() ?? '',
      };
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}