import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pos_application/features/home/presentation/home_components/parts/food_item.dart';
import 'package:pos_application/features/menu/domain/menu_repository.dart';

class SetCartFoodItemBloc extends Cubit<List<FoodItem>> {
  List<FoodItem> allFoodItem = [];

  SetCartFoodItemBloc(super.initialState);

  void setFoodItem(List<FoodItem> foodItem) {
    List<FoodItem> updatedFoodItems = [];
    allFoodItem.clear();
    updatedFoodItems.addAll(foodItem);
    allFoodItem = updatedFoodItems;
    emit(updatedFoodItems);
  }

  Future<void> addProductCart(FoodItem foodItem,
      {String method = "set"}) async {
    Map<String, dynamic> data = {
      "menu_id": foodItem.id,
      "quantity": 1,
      "method": method
    };
    ConcreteCartDataRepository concreteCartDataRepository =
        ConcreteCartDataRepository();

    await concreteCartDataRepository.adjustCart(data);
  }

  void removeFoodItemFromCart(int index) {
    allFoodItem.removeAt(index);
    List<FoodItem> updatedFoodItems = List.from(allFoodItem);
    allFoodItem = List.from(updatedFoodItems);
    emit(updatedFoodItems);
  }

  void clearCart() {
    List<FoodItem> updatedFoodItems = List.from(allFoodItem);
    updatedFoodItems.clear();
    allFoodItem = List.from(updatedFoodItems);
    emit(updatedFoodItems);
  }

  void removeFoodItem(FoodItem foodItem) async {
    List<FoodItem> updatedFoodItems = List.from(allFoodItem);
    var existingFoodItem =
        updatedFoodItems.where((item) => item.id == foodItem.id).isEmpty;

    if (!existingFoodItem) {
      var foodItemTmp =
          updatedFoodItems.firstWhere((item) => item.id == foodItem.id);
      if (foodItemTmp.quantity > 0) {
        await addProductCart(foodItemTmp, method: "substract");
        foodItemTmp.quantity = foodItem.quantity;

        if (foodItemTmp.quantity == 0) {
          updatedFoodItems.remove(foodItemTmp);
        }
      } else {
        updatedFoodItems.remove(foodItemTmp);
      }
    }

    allFoodItem = List.from(updatedFoodItems);
    emit(updatedFoodItems);
  }

  void addFoodItem(FoodItem foodItem) async {
    List<FoodItem> updatedFoodItems = List.from(allFoodItem);

    var existingFoodItem =
        updatedFoodItems.where((item) => item.id == foodItem.id).isEmpty;

    if (!existingFoodItem) {
      var foodItemTmp =
          updatedFoodItems.firstWhere((item) => item.id == foodItem.id);
      foodItemTmp.quantity = foodItem.quantity;

      foodItemTmp.imageUrl = foodItem.imageUrl;
      await addProductCart(foodItemTmp, method: "add");
    } else {
      foodItem.quantity = 1;
      updatedFoodItems.add(foodItem);
      await addProductCart(foodItem);
    }
    allFoodItem = List.from(updatedFoodItems);
    emit(updatedFoodItems);
  }
}
