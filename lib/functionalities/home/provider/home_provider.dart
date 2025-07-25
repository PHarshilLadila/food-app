import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/functionalities/home/model/canadian_meal_model.dart';
import 'package:food_app/functionalities/home/model/dessert_model.dart';
import 'package:food_app/functionalities/home/model/food_categories_model.dart';
import 'package:food_app/functionalities/home/model/hot_coffee_model.dart';
import 'package:food_app/functionalities/home/model/meal_model.dart';
import 'package:food_app/functionalities/home/model/recipes_model.dart';
import 'package:food_app/services/api_service.dart';
import 'package:hive_flutter/adapters.dart';

class HomeProvider extends ChangeNotifier {
  final _service = ApiService();
  bool isLoading = false;
  bool isFavorite = true;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Category> _foodCategoriesModel = [];
  List<Category> get foodCategoriesModel => _foodCategoriesModel;

  List<Meals> _mealsModel = [];
  List<Meals> get mealsModel => _mealsModel;

  List<CanadianMealModel> _canadianMealModel = [];
  List<CanadianMealModel> get canadianMealModel => _canadianMealModel;

  List<DessertModel> _dessertModel = [];
  List<DessertModel> get dessertModel => _dessertModel;

  List<CoffeeModel> _coffees = [];
  List<CoffeeModel> get coffees => _coffees;

  List<CoffeeModel> _icedCoffee = [];
  List<CoffeeModel> get icedCoffee => _icedCoffee;

  List<Recipe> _dinnerMenu = [];
  List<Recipe> get dinnerMenu => _dinnerMenu;

  List<Recipe> _lunchMenu = [];
  List<Recipe> get lunchMenu => _lunchMenu;

  List<Recipe> _breakfastMenu = [];
  List<Recipe> get breakfastMenu => _breakfastMenu;

  // ** for search items **

  String _searchedQuery = "";
  String get searchQuery => _searchedQuery;
  Timer? _debounce;

  //variable for search dessert meals
  List<DessertModel> _searchResults = [];
  List<DessertModel> get searchResults => _searchResults;

  // variable for search coffee items
  List<CoffeeModel> _searchCoffeeResults = [];
  List<CoffeeModel> get searchCoffeeResults => _searchCoffeeResults;

  // variable for search canadian meals
  List<CanadianMealModel> _searchCanadianResults = [];
  List<CanadianMealModel> get searchCanadianResults => _searchCanadianResults;

  // ** search Functions **

  void clearSearch() {
    _searchedQuery = '';
    _searchResults = [];
    _searchCoffeeResults = [];
    _searchCanadianResults = [];
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchedQuery = query;
    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      filterDessertResults();
      filterCoffeeResults();
      filterCanadianResults();
      notifyListeners();
    });
  }

  void filterDessertResults() {
    if (_searchedQuery.isEmpty) {
      _searchResults = [];
    } else {
      _searchResults = _dessertModel
          .where((desserts) =>
              desserts.name!
                  .toLowerCase()
                  .contains(_searchedQuery.toLowerCase()) ||
              desserts.cuisine!
                  .toLowerCase()
                  .contains(_searchedQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterCoffeeResults() {
    if (_searchCoffeeResults.isEmpty) {
      _searchCoffeeResults = [];
    } else {
      _searchCoffeeResults = _coffees
          .where((coffee) =>
              coffee.title!
                  .toLowerCase()
                  .contains(_searchedQuery.toLowerCase()) ||
              coffee.description!
                  .toLowerCase()
                  .contains(_searchedQuery.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  void filterCanadianResults() {
    if (_searchCanadianResults.isEmpty) {
      _searchCanadianResults = [];
    } else {
      _searchCanadianResults = canadianMealModel
          .where(
            (canadian) => canadian.strMeal!
                .toLowerCase()
                .contains(_searchedQuery.toLowerCase()),
          )
          .toList();
    }
    notifyListeners();
  }

  // ** main Functions **

  Future<void> getAllCategories() async {
    isLoading = true;
    notifyListeners();

    try {
      _foodCategoriesModel = await _service.getCategory();
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getMeals() async {
    isLoading = true;
    notifyListeners();

    try {
      _mealsModel = await _service.getMeals();
      var favoriteBox = Hive.box('favoriteMeals');

      for (var meal in _mealsModel) {
        if (favoriteBox.containsKey(meal.idMeal)) {
          meal.isFavorite = true;
        }
      }
    } catch (e) {
      debugPrint("Error fetching meals: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getCanadianMeal() async {
    isLoading = true;
    notifyListeners();

    try {
      _canadianMealModel = await _service.getCanadianMeal();
      var favoriteBox = Hive.box('favoriteMeals');

      for (var meal in _canadianMealModel) {
        if (favoriteBox.containsKey(meal.idMeal)) {
          meal.isFavorite = true;
        }
      }
    } catch (e) {
      debugPrint("Error fetching Canadian meals: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getDessertMeal() async {
    isLoading = true;
    notifyListeners();

    try {
      _dessertModel = await _service.getDessertMeal();
      var favoriteBox = Hive.box('favoriteMeals');

      for (var meal in _dessertModel) {
        if (favoriteBox.containsKey(meal.id)) {
          meal.isFavorite = true;
        }
      }
    } catch (e) {
      debugPrint("Error fetching Dessert meals: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchHotCoffeeData() async {
    isLoading = true;
    _errorMessage = "";
    notifyListeners();
    try {
      _coffees = await _service.getHotCoffeeData();
      var favoriteBox = Hive.box('favoriteMeals');

      for (var meal in _coffees) {
        if (favoriteBox.containsKey(meal.id)) {
          meal.isFavorite = true;
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchIcedCoffeeData() async {
    isLoading = true;
    _errorMessage = "";
    notifyListeners();
    try {
      _icedCoffee = await _service.getIcedCoffeeData();
      var favoriteBox = Hive.box('favoriteMeals');

      for (var meal in _icedCoffee) {
        if (favoriteBox.containsKey(meal.id)) {
          meal.isFavorite = true;
        }
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadDinnerData() async {
    isLoading = true;
    notifyListeners();

    try {
      _dinnerMenu = await _service.getDinnerMenu();
    } catch (e) {
      debugPrint("Provider Error: $e");
      _dinnerMenu = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadLunchData() async {
    isLoading = true;
    notifyListeners();

    try {
      _lunchMenu = await _service.getLunchMenu();
    } catch (e) {
      debugPrint("Provider Error: $e");
      _lunchMenu = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadBreakFastData() async {
    isLoading = true;
    notifyListeners();

    try {
      _breakfastMenu = await _service.getBreakFastMenu();
    } catch (e) {
      debugPrint("Provider Error: $e");
      _breakfastMenu = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addToCart(String itemId, String itemName, String itemImage,
      String itemDescription, double itemPrice, String restroName) async {
    final databaseBox = Hive.box('userProfile');
    var userUid = await databaseBox.get('userid');

    try {
      var cartRef =
          firestore.collection("users").doc(userUid).collection("cart");

      var cartItem = await cartRef.where("itemId", isEqualTo: itemId).get();

      if (cartItem.docs.isNotEmpty) {
        var existingDoc = cartItem.docs.first;
        int currentQuantity = existingDoc["quantity"];
        await cartRef.doc(existingDoc.id).update({
          "quantity": currentQuantity + 1,
        });
      } else {
        await cartRef.add({
          "itemId": itemId,
          "itemName": itemName,
          "itemImage": itemImage,
          "itemDescription": itemDescription,
          "itemPrice": itemPrice,
          "quantity": 1,
          "restroName": restroName,
          "timestamp": FieldValue.serverTimestamp(),
        });
      }
      notifyListeners();
    } catch (e) {
      debugPrint("Error adding to cart: $e");
    }
  }

  Future<void> toggleFavoriteStatus(String mealId, String mealPrice,
      String restroName, String restroImg) async {
    final databaseBox = Hive.box('userProfile');
    var userUid = await databaseBox.get('userid');
    var favoriteBox = Hive.box('favoriteMeals');

    try {
      var favCollection = firestore
          .collection("users")
          .doc(userUid)
          .collection("favoriteItems");

      var existingFav =
          await favCollection.where("mealId", isEqualTo: mealId).get();

      int mealIndex = _mealsModel.indexWhere((meal) => meal.idMeal == mealId);
      int dessertIndex = _dessertModel.indexWhere(
          (desserId) => desserId.id.toString() == (mealId.toString()));
      int canadianIndex = _canadianMealModel
          .indexWhere((canadian) => canadian.idMeal == mealId.toString());
      int hotCoffeeIndex = _coffees
          .indexWhere((coffee) => coffee.id?.toString() == mealId.toString());
      int icedCoffeeIndex = _icedCoffee
          .indexWhere((coffee) => coffee.id?.toString() == mealId.toString());

      if (mealIndex != -1) {
        _mealsModel[mealIndex].isFavorite = !_mealsModel[mealIndex].isFavorite;
      } else if (dessertIndex != -1) {
        _dessertModel[dessertIndex].isFavorite =
            !_dessertModel[dessertIndex].isFavorite;
      } else if (canadianIndex != -1) {
        _canadianMealModel[canadianIndex].isFavorite =
            !_canadianMealModel[canadianIndex].isFavorite;
      } else if (hotCoffeeIndex != 1) {
        _coffees[hotCoffeeIndex].isFavorite =
            !_coffees[hotCoffeeIndex].isFavorite;
      } else if (icedCoffeeIndex != 1) {
        _icedCoffee[icedCoffeeIndex].isFavorite =
            !_icedCoffee[icedCoffeeIndex].isFavorite;
      } else if (mealIndex == -1) {
        debugPrint(
          "is not found in any list, mealIndex: $mealIndex, dessertIndex: $dessertIndex, canadianIndex: $canadianIndex, hotCoffeeIndex: $hotCoffeeIndex, icedCoffeeIndex: $icedCoffeeIndex",
        );
      }

      if (existingFav.docs.isNotEmpty) {
        for (var doc in existingFav.docs) {
          await favCollection.doc(doc.id).delete();
        }
        favoriteBox.delete(mealId);
      } else {
        String? mealName = mealIndex != -1
            ? _mealsModel[mealIndex].strMeal
            : dessertIndex != -1
                ? _dessertModel[dessertIndex].name
                : canadianIndex != -1
                    ? _canadianMealModel[canadianIndex].strMeal
                    : hotCoffeeIndex != -1
                        ? _coffees[hotCoffeeIndex].title
                        : _icedCoffee[icedCoffeeIndex].title!;

        String? mealImage = mealIndex != -1
            ? _mealsModel[mealIndex].strMealThumb
            : dessertIndex != -1
                ? _dessertModel[dessertIndex].image
                : canadianIndex != -1
                    ? _canadianMealModel[canadianIndex].strMealThumb
                    : hotCoffeeIndex != -1
                        ? _coffees[hotCoffeeIndex].image
                        : _icedCoffee[icedCoffeeIndex].image;

        await favCollection.add({
          "mealId": mealId,
          "mealname": mealName,
          "mealImage": mealImage,
          "isFavorite": true,
          "mealPrice": mealPrice,
          "restroName": restroName,
          "restroImg": restroImg,
          "timestamp": FieldValue.serverTimestamp(),
        });

        favoriteBox.put(mealId, {
          "mealId": mealId,
          "mealname": mealName,
          "mealImage": mealImage,
          "isFavorite": true,
          "mealPrice": mealPrice,
          "restroName": restroName,
          "restroImg": restroImg,
        });
      }

      notifyListeners();
    } catch (e) {
      debugPrint("Error updating favorite status: $e");
    }
  }
}
