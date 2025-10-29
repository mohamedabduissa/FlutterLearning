import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../services/firestore_service.dart';

class HomeController with ChangeNotifier {
  final FirestoreService _firestoreService;

  HomeController(this._firestoreService);

  Stream<QuerySnapshot> get itemsStream => _firestoreService.getSomeHomeData();
}
