class CoffeeModel {
  String? title;
  String? description;
  List<String>? ingredients;
  String? image;
  num? price;
  int? id;
  bool isFavorite;

  CoffeeModel({
    this.title,
    this.description,
    this.ingredients,
    this.image,
    this.price,
    this.id,
    this.isFavorite = false,
  });

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      title: json['title'],
      description: json['description'],
      ingredients: json['ingredients'].cast<String>(),
      image: json['image'],
      price: json['price'],
      id: json['id'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  // CoffeeModel.fromJson(Map<String, dynamic> json) {
  //   title = json['title'];
  //   description = json['description'];
  //   ingredients = json['ingredients'].cast<String>();
  //   image = json['image'];
  //   price = json['price'];
  //   id = json['id'];
  //   isFavorite = json['isFavorite'] ?? false;
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['title'] = title;
  //   data['description'] = description;
  //   data['ingredients'] = ingredients;
  //   data['image'] = image;
  //   data['price'] = price;
  //   data['id'] = id;
  //   data['isFavorite'] = isFavorite;
  //   return data;
  // }
}
