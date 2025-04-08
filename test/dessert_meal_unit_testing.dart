import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';

import 'package:food_app/functionalities/home/model/dessert_model.dart';

@GenerateMocks([http.Client])
void main() {
  group('Dessert Meal Unit Testing', () {
    test('Dessert Meal should have a name', () {
      final dessertMeal = DessertModel(
        name: 'Chocolate Cake',
        mealType: ['Dessert'],
        difficulty: 'Easy',
      );
      expect(dessertMeal.name, 'Chocolate Cake');
    });

    test('Dessert Meal should have a meal type list', () {
      final dessertMeal = DessertModel(
        name: 'Ice Cream',
        mealType: ['Snack', 'Dessert'],
        difficulty: 'Medium',
      );
      expect(dessertMeal.mealType, ['Snack', 'Dessert']);
    });

    test('Dessert Meal should have a difficulty level', () {
      final dessertMeal = DessertModel(
        name: 'Pudding',
        mealType: ['Dessert'],
        difficulty: 'Easy',
      );
      expect(dessertMeal.difficulty, 'Easy');
    });
  });
}
