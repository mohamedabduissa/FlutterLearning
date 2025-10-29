import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

// --- 2. Service / Repository ---
class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late final CollectionReference _usersRef;

  FirestoreService() {
    _usersRef = _db
        .collection('users')
        .withConverter<AppUser>(
          fromFirestore: (snapshots, _) => AppUser.fromFirestore(snapshots),
          toFirestore: (appUser, _) => appUser.toJson(),
        );
  }

  Future<void> setUserData(AppUser user) {
    return _usersRef.doc(user.uid).set(user);
  }

  Future<AppUser?> getUserData(String uid) async {
    final doc = await _usersRef.doc(uid).get();
    return doc.data() as AppUser?;
  }

  Stream<AppUser?> getUserDataStream(String uid) {
    return _usersRef.doc(uid).snapshots().map((doc) => doc.data() as AppUser?);
  }

  Stream<QuerySnapshot> getSomeHomeData() {
    return _db.collection('items').snapshots();
  }
}
