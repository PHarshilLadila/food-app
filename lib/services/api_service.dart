// import 'dart:convert';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:food_app/functionalities/home/model/canadian_meal_model.dart';
// import 'package:food_app/functionalities/home/model/dessert_model.dart';
// import 'package:food_app/functionalities/home/model/food_categories_model.dart';
// import 'package:food_app/functionalities/home/model/hot_coffee_model.dart';
// import 'package:food_app/functionalities/home/model/meal_model.dart';
// import 'package:food_app/functionalities/home/model/recipes_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:sentry_flutter/sentry_flutter.dart';

// class ApiService {
//   Dio dio = Dio();
//   final client = SentryHttpClient();

//   static const int timeOutDutration = 60;
//   final Map<String, String> headers = {
//     "Content-Type": "application/json",
//     "Accept": "application/json",
//     "Accept-Language": "en-US",
//   };

//   // ApiService._internal();
//   // static final ApiService _instance = ApiService._internal();
//   // static ApiService get instance => _instance;
//   // late final http.Client httpClient;
//   // late final SSlPinningManager sslPinningManager;
//   // factory ApiService(http.Client client) {
//   //   _instance.httpClient = client;
//   //   return _instance;
//   // }

//   Future<List<Category>> getCategory() async {
//     try {
//       await dotenv.load();
//       if (dotenv.load() == true) {
//         debugPrint("DONE");
//       }
//       String categoriesAPI = dotenv.env['MEALCATEGOTESAPI'] ?? '';
//       final String url =
//           categoriesAPI; //'https://www.themealdb.com/api/json/v1/1/categories.php';
//       final uri = Uri.parse(url);
//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);

//         List<Category> categories = (jsonData['categories'] as List)
//             .map(
//               (e) => Category.fromJson(e),
//             )
//             .toList();

//         return categories;
//       }
//       return [];
//     } catch (e) {
//       throw Exception('Error fetching Categories: $e');
//     }
//   }

//   Future<List<Meals>> getMeals() async {
//     try {
//       await dotenv.load();
//       if (dotenv.load() == true) {
//         debugPrint("DONE");
//       }
//       String getChickenMeal = dotenv.env['GETCHICKENMEALAPI'] ?? '';
//       final String url = getChickenMeal;
//       // "https://www.themealdb.com/api/json/v1/1/filter.php?i=chicken_breast";
//       final uri = Uri.parse(url);

//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);

//         List<Meals> meals = (jsonData['meals'] as List)
//             .map(
//               (e) => Meals.fromJson(e),
//             )
//             .toList();

//         return meals;
//       }
//       return [];
//     } catch (e) {
//       throw Exception("Erro fetching Meals: $e");
//     }
//   }

//   Future<List<CanadianMealModel>> getCanadianMeal() async {
//     try {
//       await dotenv.load();
//       if (dotenv.load() == true) {
//         debugPrint("DONE");
//       }
//       String getCanadianMeal = dotenv.env['GETCANADIANMEALAPI'] ?? '';
//       final String url = getCanadianMeal;
//       // 'https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian';
//       final uri = Uri.parse(url);
//       final response = await http.get(uri);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);

//         List<CanadianMealModel> canadianMealModel = (jsonData['meals'] as List)
//             .map((e) => CanadianMealModel.fromJson(e))
//             .toList();
//         return canadianMealModel;
//       }
//       return [];
//     } catch (e) {
//       throw Exception("Error on get canadian meal dara : $e");
//     }
//   }

//   Future<List<DessertModel>> getDessertMeal() async {
//     try {
//       await dotenv.load();
//       if (dotenv.load() == true) {
//         debugPrint("DONE");
//       }
//       String getDessertMeal = dotenv.env['GETDESSERTMEALAPI'] ?? '';
//       final String url = getDessertMeal;

//       //  "https://dummyjson.com/recipes/meal-type/snack";

//       final uri = Uri.parse(url);
//       final response = await client.get(uri);

//       if (response.statusCode == 200) {
//         final jsonData = jsonDecode(response.body);

//         List<DessertModel> dessertModel = (jsonData['recipes'] as List)
//             .map((e) => DessertModel.fromJson(e))
//             .toList();
//         return dessertModel;
//       }
//       return [];
//     } catch (e) {
//       throw Exception("Error on get Dessert Meals : $e");
//     }
//   }

//   Future<List<CoffeeModel>> getHotCoffeeData() async {
//     try {
//       await dotenv.load();
//       if (dotenv.load() == true) {
//         debugPrint("DONE");
//       }
//       String getHotCoffeeData = dotenv.env['GETHOTCOFFEEAPI'] ?? '';
//       final String url = getHotCoffeeData;
//       Response response = await dio.get(url);

//       if (response.statusCode == 200) {
//         List<dynamic> jsonData = response.data;

//         return jsonData.map((json) => CoffeeModel.fromJson(json)).toList();
//       } else {
//         debugPrint("Failed to load coffee data");
//         throw Exception('Failed to load coffee data');
//       }
//     } catch (e) {
//       debugPrint("Error fetching coffee data: $e");
//       throw Exception('Error fetching coffee data: $e');
//     }
//   }

//   Future<List<CoffeeModel>> getIcedCoffeeData() async {
//     try {
//       await dotenv.load();
//       if (dotenv.load() == true) {
//         debugPrint("DONE");
//       }
//       String getIcedCoffeeData = dotenv.env['GETICEDCOFFEEAPI'] ?? '';
//       final String url = getIcedCoffeeData;
//       Response response = await dio.get(url);

//       if (response.statusCode == 200) {
//         List<dynamic> jsonData = response.data;

//         return jsonData.map((json) => CoffeeModel.fromJson(json)).toList();
//       } else {
//         debugPrint("Failed to load coffee data");
//         throw Exception('Failed to load coffee data');
//       }
//     } catch (e) {
//       debugPrint("Error fetching coffee data: $e");
//       throw Exception('Error fetching coffee data: $e');
//     }
//   }

//   Future<List<Recipe>> getDinnerMenu() async {
//     try {
//       await dotenv.load();
//       if (dotenv.load() == true) {
//         debugPrint("DONE");
//       }
//       String getDinnerMenu = dotenv.env['GETDINNERMENUAPI'] ?? '';
//       final String url = getDinnerMenu;
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final pizzaModel = PizzaModel.fromJson(jsonDecode(response.body));
//         return pizzaModel.recipes;
//       } else {
//         throw Exception("Failed to load pizza data");
//       }
//     } catch (e) {
//       print("Error: $e");
//       throw Exception("Error fetching pizza data: $e");
//     }
//   }

//   Future<List<Recipe>> getLunchMenu() async {
//     try {
//       await dotenv.load();
//       if (dotenv.load() == true) {
//         debugPrint("DONE");
//       }
//       String getLunchMenu = dotenv.env['GETLUNCHMENUAPI'] ?? '';
//       final String url = getLunchMenu;
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final pizzaModel = PizzaModel.fromJson(jsonDecode(response.body));
//         return pizzaModel.recipes;
//       } else {
//         throw Exception("Failed to load Lunch data");
//       }
//     } catch (e) {
//       print("Error: $e");
//       throw Exception("Error fetching Lunch data: $e");
//     }
//   }

//   Future<List<Recipe>> getBreakFastMenu() async {
//     try {
//       await dotenv.load();
//       if (dotenv.load() == true) {
//         debugPrint("DONE");
//       }
//       String getBreakFastMenu = dotenv.env['GETBREAKFASTMENUAPI'] ?? '';
//       debugPrint("This is the getBreakFastMenu api: $getBreakFastMenu");

//       final String url = getBreakFastMenu;
//       final response = await http.get(Uri.parse(url));
//       if (response.statusCode == 200) {
//         final pizzaModel = PizzaModel.fromJson(jsonDecode(response.body));
//         return pizzaModel.recipes;
//       } else {
//         throw Exception("Failed to load Lunch data");
//       }
//     } catch (e) {
//       print("Error: $e");
//       throw Exception("Error fetching Lunch data: $e");
//     }
//   }
// }
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_app/functionalities/home/model/canadian_meal_model.dart';
import 'package:food_app/functionalities/home/model/dessert_model.dart';
import 'package:food_app/functionalities/home/model/food_categories_model.dart';
import 'package:food_app/functionalities/home/model/hot_coffee_model.dart';
import 'package:food_app/functionalities/home/model/meal_model.dart';
import 'package:food_app/functionalities/home/model/recipes_model.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class ApiService {
  Dio dio = Dio();
  final client = SentryHttpClient();

  static const int timeOutDutration = 60;
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Accept-Language": "en-US",
  };

  // Initialize the environment variables once
  Future<void> initialize() async {
    await dotenv.load();
    debugPrint("Environment variables loaded");
  }

  Future<List<Category>> getCategory() async {
    try {
      final String? categoriesAPI = dotenv.env['MEALCATEGORIESAPI'];
      if (categoriesAPI == null || categoriesAPI.isEmpty) {
        throw Exception('MEALCATEGORIESAPI is not configured');
      }

      final uri = Uri.parse(categoriesAPI);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Category> categories = (jsonData['categories'] as List)
            .map((e) => Category.fromJson(e))
            .toList();
        return categories;
      }
      throw Exception(
          'Failed to load categories with status: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching Categories: $e');
    }
  }

  Future<List<Meals>> getMeals() async {
    try {
      final String? getChickenMeal = dotenv.env['GETCHICKENMEALAPI'];
      if (getChickenMeal == null || getChickenMeal.isEmpty) {
        throw Exception('GETCHICKENMEALAPI is not configured');
      }

      final uri = Uri.parse(getChickenMeal);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<Meals> meals =
            (jsonData['meals'] as List).map((e) => Meals.fromJson(e)).toList();
        return meals;
      }
      throw Exception(
          'Failed to load meals with status: ${response.statusCode}');
    } catch (e) {
      throw Exception("Error fetching Meals: $e");
    }
  }

  Future<List<CanadianMealModel>> getCanadianMeal() async {
    try {
      final String? getCanadianMeal = dotenv.env['GETCANADIANMEALAPI'];
      if (getCanadianMeal == null || getCanadianMeal.isEmpty) {
        throw Exception('GETCANADIANMEALAPI is not configured');
      }

      final uri = Uri.parse(getCanadianMeal);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<CanadianMealModel> canadianMeals = (jsonData['meals'] as List)
            .map((e) => CanadianMealModel.fromJson(e))
            .toList();
        return canadianMeals;
      }
      throw Exception(
          'Failed to load Canadian meals with status: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching Canadian meals: $e');
    }
  }

  Future<List<DessertModel>> getDessertMeal() async {
    try {
      final String? getDessertMeal = dotenv.env['GETDESSERTMEALAPI'];
      if (getDessertMeal == null || getDessertMeal.isEmpty) {
        throw Exception('GETDESSERTMEALAPI is not configured');
      }

      final uri = Uri.parse(getDessertMeal);
      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        List<DessertModel> desserts = (jsonData['recipes'] as List)
            .map((e) => DessertModel.fromJson(e))
            .toList();
        return desserts;
      }
      throw Exception(
          'Failed to load desserts with status: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching desserts: $e');
    }
  }

  Future<List<CoffeeModel>> getHotCoffeeData() async {
    try {
      final String? getHotCoffeeData = dotenv.env['GETHOTCOFFEEAPI'];
      if (getHotCoffeeData == null || getHotCoffeeData.isEmpty) {
        throw Exception('GETHOTCOFFEEAPI is not configured');
      }

      final response = await dio.get(getHotCoffeeData);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((json) => CoffeeModel.fromJson(json)).toList();
      }
      throw Exception(
          'Failed to load hot coffee data with status: ${response.statusCode}');
    } catch (e) {
      debugPrint("Error fetching hot coffee data: $e");
      throw Exception('Error fetching hot coffee data: $e');
    }
  }

  Future<List<CoffeeModel>> getIcedCoffeeData() async {
    try {
      final String? getIcedCoffeeData = dotenv.env['GETICEDCOFFEEAPI'];
      if (getIcedCoffeeData == null || getIcedCoffeeData.isEmpty) {
        throw Exception('GETICEDCOFFEEAPI is not configured');
      }

      final response = await dio.get(getIcedCoffeeData);

      if (response.statusCode == 200) {
        List<dynamic> jsonData = response.data;
        return jsonData.map((json) => CoffeeModel.fromJson(json)).toList();
      }
      throw Exception(
          'Failed to load iced coffee data with status: ${response.statusCode}');
    } catch (e) {
      debugPrint("Error fetching iced coffee data: $e");
      throw Exception('Error fetching iced coffee data: $e');
    }
  }

  Future<List<Recipe>> getDinnerMenu() async {
    try {
      final String? getDinnerMenu = dotenv.env['GETDINNERMENUAPI'];
      if (getDinnerMenu == null || getDinnerMenu.isEmpty) {
        throw Exception('GETDINNERMENUAPI is not configured');
      }

      final response = await http.get(Uri.parse(getDinnerMenu));
      if (response.statusCode == 200) {
        final pizzaModel = PizzaModel.fromJson(jsonDecode(response.body));
        return pizzaModel.recipes;
      }
      throw Exception(
          'Failed to load dinner menu with status: ${response.statusCode}');
    } catch (e) {
      debugPrint("Error fetching dinner menu: $e");
      throw Exception('Error fetching dinner menu: $e');
    }
  }

  Future<List<Recipe>> getLunchMenu() async {
    try {
      final String? getLunchMenu = dotenv.env['GETLUNCHMENUAPI'];
      if (getLunchMenu == null || getLunchMenu.isEmpty) {
        throw Exception('GETLUNCHMENUAPI is not configured');
      }

      final response = await http.get(Uri.parse(getLunchMenu));
      if (response.statusCode == 200) {
        final pizzaModel = PizzaModel.fromJson(jsonDecode(response.body));
        return pizzaModel.recipes;
      }
      throw Exception(
          'Failed to load lunch menu with status: ${response.statusCode}');
    } catch (e) {
      debugPrint("Error fetching lunch menu: $e");
      throw Exception('Error fetching lunch menu: $e');
    }
  }

  Future<List<Recipe>> getBreakFastMenu() async {
    try {
      final String? getBreakFastMenu = dotenv.env['GETBREAKFASTMENUAPI'];
      if (getBreakFastMenu == null || getBreakFastMenu.isEmpty) {
        throw Exception('GETBREAKFASTMENUAPI is not configured');
      }

      debugPrint("Breakfast menu API: $getBreakFastMenu");
      final response = await http.get(Uri.parse(getBreakFastMenu));
      if (response.statusCode == 200) {
        final pizzaModel = PizzaModel.fromJson(jsonDecode(response.body));
        return pizzaModel.recipes;
      }
      throw Exception(
          'Failed to load breakfast menu with status: ${response.statusCode}');
    } catch (e) {
      debugPrint("Error fetching breakfast menu: $e");
      throw Exception('Error fetching breakfast menu: $e');
    }
  }
}
