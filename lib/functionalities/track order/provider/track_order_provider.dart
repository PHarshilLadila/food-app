// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:food_app/functionalities/file%20operation/file_storage.dart';
// import 'package:hive/hive.dart';

// class TrackOrderProvider with ChangeNotifier {
//   List<Map<String, dynamic>> _oreders = [];
//   List<Map<String, dynamic>> get oreders => _oreders;

//   Future<void> loadOrders() async {
//     final databaseBox = Hive.box('userProfile');
//     var id = await databaseBox.get("userid");
//     var data = FirebaseFirestore.instance
//         .collection('users')
//         .doc(id)
//         .collection('ordersDetails')
//         .orderBy('timestamp', descending: true)
//         .limit(1)
//         .snapshots();
//     // : const Stream.empty(),

//     _oreders = data.listen((event) {
//       for (var doc in event.docs) {
//         _oreders.add(doc.data());
//       }
//     }) as List<Map<String, dynamic>>;

//     notifyListeners();
//   }

//   Future<void> addOrder(List<Map<String, dynamic>> data) async {
//     _oreders.addAll(data); // Add each map in the list to the orders
//     await FileStorage.saveOrdersHistory(_oreders);
//     notifyListeners();
//   }
// }
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

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('ordersDetails')
          .orderBy('timestamp', descending: false)
          .get();

      _oreders = querySnapshot.docs.map((doc) {
        final data = doc.data();
        if (data['timestamp'] is Timestamp) {
          data['timestamp'] =
              (data['timestamp'] as Timestamp).toDate().toString();
        }
        return data;
      }).toList();

      notifyListeners();
    } catch (e) {
      debugPrint("Error loading orders: $e");
    }
  }

  Future<void> addOrder(List<Map<String, dynamic>> data) async {
    try {
      _oreders.addAll(data);

      final sanitizedOrders = _oreders.map((order) {
        final sanitizedOrder = Map<String, dynamic>.from(order);
        if (sanitizedOrder['timestamp'] is Timestamp) {
          sanitizedOrder['timestamp'] =
              (sanitizedOrder['timestamp'] as Timestamp).toDate().toString();
        }
        return sanitizedOrder;
      }).toList();

      // Save to local storage
      await FileStorage.saveOrdersHistory(sanitizedOrders);

      notifyListeners();
    } catch (e) {
      debugPrint("Error adding order: $e");
    }
  }
}
