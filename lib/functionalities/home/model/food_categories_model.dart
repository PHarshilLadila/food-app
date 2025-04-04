class Category {
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Category({
    this.idCategory,
    this.strCategory,
    this.strCategoryThumb,
    this.strCategoryDescription,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      idCategory: json['idCategory'],
      strCategory: json['strCategory'],
      strCategoryThumb: json['strCategoryThumb'],
      strCategoryDescription: json['strCategoryDescription'],
    );
  }
}
