import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:food_app/functionalities/rest%20api%20with%20dio/model/demo_model.dart';

class RestApiService {
  final String baseUrl = "https://dummy.restapiexample.com/api/v1";
  Dio dio = Dio();

  Future<DemoModel> getDemoData() async {
    try {
      Response response = await dio.get("$baseUrl/employees");

      if (response.statusCode == 200) {
        return DemoModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load demo data");
      }
    } catch (e) {
      debugPrint("$e");
      throw Exception("Error fetching demo data: $e");
    }
  }

  Future<bool> addData(String id, String name, String salary, String age,
      String profileimg) async {
    try {
      Response response = await dio.post(
        "$baseUrl/create",
        data: {
          "id": int.tryParse(id) ?? 0,
          "employee_name": name,
          "employee_salary": int.tryParse(salary) ?? 0,
          "employee_age": int.tryParse(age) ?? 0,
          "profile_image": profileimg,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Data added successfully: ${response.data}");
        return true;
      } else {
        debugPrint("Failed to add data: ${response.data}");
        return false;
      }
    } catch (e) {
      throw Exception("Error adding Demo Data: $e");
    }
  }
}
