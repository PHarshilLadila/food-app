import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_app/functionalities/home/model/canadian_meal_model.dart';
import 'package:food_app/functionalities/home/model/dessert_model.dart';
import 'package:food_app/functionalities/home/model/food_categories_model.dart';
import 'package:food_app/functionalities/home/model/hot_coffee_model.dart';
import 'package:food_app/functionalities/home/model/meal_model.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class ApiService {
  Dio dio = Dio();
  final client = SentryHttpClient();

  Future<List<Category>> getCategory() async {
    try {
      const url = 'https://www.themealdb.com/api/json/v1/1/categories.php';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        List<Category> categories = (jsonData['categories'] as List)
            .map(
              (e) => Category.fromJson(e),
            )
            .toList();

        return categories;
      }
      return [];
    } catch (e) {
      throw Exception('Error fetching Categories: $e');
    }
  }

  Future<List<Meals>> getMeals() async {
    try {
      const url =
          "https://www.themealdb.com/api/json/v1/1/filter.php?i=chicken_breast";
      final uri = Uri.parse(url);

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        List<Meals> meals = (jsonData['meals'] as List)
            .map(
              (e) => Meals.fromJson(e),
            )
            .toList();

        return meals;
      }
      return [];
    } catch (e) {
      throw Exception("Erro fetching Meals: $e");
    }
  }

  Future<List<CanadianMealModel>> getCanadianMeal() async {
    try {
      const url =
          'https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian';
      final uri = Uri.parse(url);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        List<CanadianMealModel> canadianMealModel = (jsonData['meals'] as List)
            .map((e) => CanadianMealModel.fromJson(e))
            .toList();
        return canadianMealModel;
      }
      return [];
    } catch (e) {
      throw Exception("Error on get canadian meal dara : $e");
    }
  }

  Future<List<DessertModel>> getDessertMeal() async {
    try {
      const url = "https://dummyjson.com/recipes/meal-type/snack";

      final uri = Uri.parse(url);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        List<DessertModel> dessertModel = (jsonData['recipes'] as List)
            .map((e) => DessertModel.fromJson(e))
            .toList();
        return dessertModel;
      }
      return [];
    } catch (e) {
      throw Exception("Error on get Dessert Meals : $e");
    }
  }

  Future<List<CoffeeModel>> getHotCoffeeData() async {
    try {
      Response response =
          await dio.get("https://api.sampleapis.com/coffee/hot");

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;

        return jsonData.map((json) => CoffeeModel.fromJson(json)).toList();
      } else {
        debugPrint("Failed to load coffee data");
        throw Exception('Failed to load coffee data');
      }
    } catch (e) {
      debugPrint("Error fetching coffee data: $e");
      throw Exception('Error fetching coffee data: $e');
    }
  }

  Future<List<CoffeeModel>> getIcedCoffeeData() async {
    try {
      Response response =
          await dio.get("https://api.sampleapis.com/coffee/iced");

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;

        return jsonData.map((json) => CoffeeModel.fromJson(json)).toList();
      } else {
        debugPrint("Failed to load coffee data");
        throw Exception('Failed to load coffee data');
      }
    } catch (e) {
      debugPrint("Error fetching coffee data: $e");
      throw Exception('Error fetching coffee data: $e');
    }
  }
}
