import 'package:flutter_test/flutter_test.dart';
import 'package:food_app/functionalities/home/model/hot_coffee_model.dart';

void main() {
  group("Hot Coffee Unit Test", () {
    test("Hot Coffee Should Have Name", () {
      final hotCoffee = CoffeeModel(
        title: "Late",
        isFavorite: true,
        price: 2.5,
      );
      expect(hotCoffee.title, "Late");
    });
    test("Hot Coffee Should Have Price", () {
      final hotCoffee = CoffeeModel(
        title: "Espresso",
        isFavorite: false,
        price: 3.0,
      );
      expect(hotCoffee.price, 3.0);
    });
    test("Hot Coffee Should Have Favorite Status", () {
      final hotCoffee = CoffeeModel(
        title: "Cappuccino",
        isFavorite: true,
        price: 4.0,
      );
      expect(hotCoffee.isFavorite, true);
    });
    test("Hot Coffee Should Have Ingredients", () {
      final hotCoffee = CoffeeModel(
        title: "Mocha",
        ingredients: ["Coffee", "Chocolate", "Milk"],
        price: 3.5,
      );
      expect(hotCoffee.ingredients, ["Coffee", "Chocolate", "Milk"]);
    });
    test("Hot Coffee Should Have Image", () {
      final hotCoffee = CoffeeModel(
        title: "Americano",
        image: "assets/images/americano.png",
        price: 2.0,
      );
      expect(hotCoffee.image, "assets/images/americano.png");
    });
    test("Hot Coffee Should Have Description", () {
      final hotCoffee = CoffeeModel(
        title: "Latte",
        description: "A delicious coffee drink with milk.",
        price: 3.0,
      );
      expect(hotCoffee.description, "A delicious coffee drink with milk.");
    });
    test("Hot Coffee Should Have ID", () {
      final hotCoffee = CoffeeModel(
        title: "Flat White",
        id: 1,
        price: 3.5,
      );
      expect(hotCoffee.id, 1);
    });
  });
}
