class DessertModel {
  int? id;
  String? name;
  List<String>? ingredients;
  List<String>? instructions;
  int? prepTimeMinutes;
  int? cookTimeMinutes;
  int? servings;
  String? difficulty;
  String? cuisine;
  int? caloriesPerServing;
  List<String>? tags;
  int? userId;
  String? image;
  double? rating;
  int? reviewCount;
  List<String>? mealType;
  bool isFavorite;

  DessertModel({
    this.id,
    this.name,
    this.ingredients,
    this.instructions,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.difficulty,
    this.cuisine,
    this.caloriesPerServing,
    this.tags,
    this.userId,
    this.image,
    this.rating,
    this.reviewCount,
    this.mealType,
    this.isFavorite = false,
  });

  factory DessertModel.fromJson(Map<String, dynamic> json) {
    return DessertModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      ingredients:
          (json['ingredients'] as List<dynamic>?)?.cast<String>() ?? [],
      instructions:
          (json['instructions'] as List<dynamic>?)?.cast<String>() ?? [],
      prepTimeMinutes: json['prepTimeMinutes'] as int?,
      cookTimeMinutes: json['cookTimeMinutes'] as int?,
      servings: json['servings'] as int?,
      difficulty: json['difficulty'] as String?,
      cuisine: json['cuisine'] as String?,
      caloriesPerServing: json['caloriesPerServing'] as int?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
      userId: json['userId'] as int?,
      image: json['image'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      reviewCount: json['reviewCount'] as int?,
      mealType: (json['mealType'] as List<dynamic>?)?.cast<String>() ?? [],
      isFavorite: json['isFavorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ingredients': ingredients,
      'instructions': instructions,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'difficulty': difficulty,
      'cuisine': cuisine,
      'caloriesPerServing': caloriesPerServing,
      'tags': tags,
      'userId': userId,
      'image': image,
      'rating': rating,
      'reviewCount': reviewCount,
      'mealType': mealType,
      'isFavorite': isFavorite,
    };
  }
}
