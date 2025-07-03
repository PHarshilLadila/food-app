// ignore_for_file: constant_identifier_names

enum Difficulty { EASY, MEDIUM }

enum MealType { BREAKFAST, DINNER, LUNCH, SNACKS }

Difficulty difficultyFromString(String value) {
  return Difficulty.values.firstWhere(
    (e) => e.toString().split('.').last.toUpperCase() == value.toUpperCase(),
    orElse: () => Difficulty.EASY, // fallback
  );
}

// Difficulty difficultyFromString(String value) => Difficulty.values.firstWhere(
//     (e) => e.toString().split('.').last.toUpperCase() == value.toUpperCase());

MealType mealTypeFromString(String value) {
  return MealType.values.firstWhere(
    (e) => e.toString().split('.').last.toUpperCase() == value.toUpperCase(),
    orElse: () => MealType.LUNCH, // fallback
  );
}

// MealType mealTypeFromString(String value) => MealType.values.firstWhere(
//     (e) => e.toString().split('.').last.toUpperCase() == value.toUpperCase());

class PizzaModel {
  List<Recipe> recipes;
  int total;
  int skip;
  int limit;

  PizzaModel({
    required this.recipes,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory PizzaModel.fromJson(Map<String, dynamic> json) => PizzaModel(
        recipes:
            List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );
}

class Recipe {
  int id;
  String name;
  List<String> ingredients;
  List<String> instructions;
  int prepTimeMinutes;
  int cookTimeMinutes;
  int servings;
  Difficulty difficulty;
  String cuisine;
  int caloriesPerServing;
  List<String> tags;
  int userId;
  String image;
  double rating;
  int reviewCount;
  List<MealType> mealType;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.caloriesPerServing,
    required this.tags,
    required this.userId,
    required this.image,
    required this.rating,
    required this.reviewCount,
    required this.mealType,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        id: json["id"],
        name: json["name"],
        ingredients: List<String>.from(json["ingredients"]),
        instructions: List<String>.from(json["instructions"]),
        prepTimeMinutes: json["prepTimeMinutes"],
        cookTimeMinutes: json["cookTimeMinutes"],
        servings: json["servings"],
        difficulty: difficultyFromString(json["difficulty"]),
        cuisine: json["cuisine"],
        caloriesPerServing: json["caloriesPerServing"],
        tags: List<String>.from(json["tags"]),
        userId: json["userId"],
        image: json["image"],
        rating: json["rating"].toDouble(),
        reviewCount: json["reviewCount"],
        mealType: List<String>.from(json["mealType"])
            .map(mealTypeFromString)
            .toList(),
      );
}
