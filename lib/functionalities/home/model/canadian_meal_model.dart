class CanadianMealModel {
  String? strMeal;
  String? strMealThumb;
  String? idMeal;
  bool isFavorite;

  CanadianMealModel({
    this.strMeal,
    this.strMealThumb,
    this.idMeal,
    this.isFavorite = false,
  });

  factory CanadianMealModel.fromJson(Map<String, dynamic> json) {
    return CanadianMealModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
