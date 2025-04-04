import 'package:flutter/material.dart';
import 'package:food_app/functionalities/rest%20api%20with%20dio/demo%20service/rest_api_service.dart';
import 'package:food_app/functionalities/rest%20api%20with%20dio/model/demo_model.dart';

class RestDemo extends ChangeNotifier {
  final apiService = RestApiService();
  List<Data> _demoData = [];
  List<Data> get demodata => _demoData;

  // ignore: prefer_final_fields
  List<Data> _addDemoData = [];
  List<Data> get addDemoData => _addDemoData;
  bool isLoading = false;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> getDemoData() async {
    isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      DemoModel demoModel = await apiService.getDemoData();
      _demoData = demoModel.data ?? [];
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
