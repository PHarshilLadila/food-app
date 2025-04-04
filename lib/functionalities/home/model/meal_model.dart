class Meals {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;
  bool isFavorite; // Add this property

  Meals({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
    this.isFavorite = false, // Default to false
  });

  factory Meals.fromJson(Map<String, dynamic> json) {
    return Meals(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
