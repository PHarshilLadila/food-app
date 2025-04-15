// import 'package:flutter/material.dart';
// import 'package:food_app/functionalities/file%20operation/file_storage.dart';

// class OrderProvider extends ChangeNotifier {
//   List<Map<String, dynamic>> _oreders = [];
//   List<Map<String, dynamic>> get oreders => _oreders;

//   OrderProvider() {
//     loadOrders();
//   }

//   Future<void> loadOrders() async {
//     _oreders = await FileStorage.readOrderedHistory();
//     notifyListeners();
//   }

//   Future<void> addOrder(Map<String, dynamic>? data) async {
//     dynamic newOrder = {data};

//     _oreders.add(newOrder);
//     await FileStorage.saveOrdersHistory(_oreders);
//     notifyListeners();
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:food_app/functionalities/file%20operation/file_storage.dart';

// class OrderProvider extends ChangeNotifier {
//   List<Map<String, dynamic>> _oreders = [];
//   List<Map<String, dynamic>> get oreders => _oreders;

//   OrderProvider() {
//     loadOrders();
//   }

//   Future<void> loadOrders() async {
//     _oreders = await FileStorage.readOrderedHistory();
//     notifyListeners();
//   }

//   Future<void> addOrder(List<Map<String, dynamic>> data) async {
//     _oreders
//         .add(data as Map<String, dynamic>); // Add the order directly as a Map
//     await FileStorage.saveOrdersHistory(_oreders);
//     notifyListeners();
//   }
// }
