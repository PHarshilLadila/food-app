import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/functionalities/file%20operation/file_storage.dart';
import 'package:hive/hive.dart';

class TrackOrderProvider with ChangeNotifier {
  List<Map<String, dynamic>> _oreders = [];
  List<Map<String, dynamic>> get oreders => _oreders;

  Future<void> loadOrders() async {
    final databaseBox = Hive.box('userProfile');
    var id = await databaseBox.get("userid");
    var data = FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('ordersDetails')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
    // : const Stream.empty(),

    _oreders = data.listen((event) {
      for (var doc in event.docs) {
        _oreders.add(doc.data());
      }
    }) as List<Map<String, dynamic>>;

    notifyListeners();
  }

  Future<void> addOrder(List<Map<String, dynamic>> data) async {
    _oreders.addAll(data); // Add each map in the list to the orders
    await FileStorage.saveOrdersHistory(_oreders);
    notifyListeners();
  }
}
