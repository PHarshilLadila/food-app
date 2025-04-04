import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FileStorage {
  static Future<File> getOrderFile() async {
    final directory = await getApplicationDocumentsDirectory();

    return File("${directory.path}/order_history.json");
  }

  static Future<void> saveOrdersHistory(
      List<Map<String, dynamic>> orederData) async {
    final file = await getOrderFile();

    await file.writeAsString(jsonEncode(orederData));
  }

  static Future<List<Map<String, dynamic>>> readOrderedHistory() async {
    try {
      final file = await getOrderFile();
      if (!await file.exists()) {
        return [];
      }
      final content = await file.readAsString();
      return List<Map<String, dynamic>>.from(jsonDecode(content));
    } catch (e) {
      debugPrint("error on read the order history");
      throw Exception("error on read the order history : $e");
    }
  }

  static Future<void> deleteitems(int id) async {}
}
