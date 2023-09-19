import 'package:assessment_studio_93/constants/app/app_constants.dart';
import 'package:assessment_studio_93/model/food_items_model.dart';
import 'package:assessment_studio_93/model/meal_model.dart';
import 'package:assessment_studio_93/services/getMealData.dart';
import 'package:assessment_studio_93/utilities/app_utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AppController extends GetxController {
  bool isLoading = false;
  List<MealData> mealList = [];
  List<FoodItems> allFoodItems = [];

  /* When we initialize controller fetch data*/
  @override
  void onInit() {
    fetchMealData();
    fetchAllFoodItems();
    super.onInit();
  }

  void startLoader() {
    isLoading = true;
    debugPrint("start loading app controller");
    update();
  }

  void stopLoader() {
    isLoading = false;
    debugPrint("stop loading app controller");
    update();
  }

  /* Fetch meal data from Services and store in  List<MenuData> mealList */

  void fetchMealData() {
    mealList = MealServices.populateMealList();

    update();
  }

  /* Fetch meal data from Services and store in  List<FoodItems> allFoodItems = [] */
  void fetchAllFoodItems() {
    allFoodItems = MealServices.populateAllFoodItems();

    update();
  }

  void removeFoodItem({required MealData meal, required FoodItems? foodItem}) {
    meal.foodItems?.remove(foodItem);
    meal.totalCalories=calculateTotalCalories(meal);
    update();
  }

  double calculateTotalCalories(MealData meal) {

    double total = 0;
    meal.foodItems?.forEach((food) {
      total = total + (food.calories ?? 0);
    });
    return total;
  }

  void setFav(MealData mealData) {
    mealData.isFav = !mealData.isFav;
    if (mealData.isFav) {
      AppUtility.toast(
          msg: "Added to Favorites", bgColor: AppConfig.colors.green);
    } else {
      AppUtility.toast(
          msg: "Removed From Favorites", bgColor: AppConfig.colors.red);
    }

    update();
  }

  void setEdit(MealData mealData) {
    mealData.isEdit = !mealData.isEdit;

    update();
  }

  /*======================== select Food Items===============*/
  List<FoodItems> selectedFoodItems = [];

  Future<void> addFoodItem({
    required BuildContext context,
    required FoodItems foodItem,
  }) async {
    bool checkSelection = checkFoodItemSelection(foodItem: foodItem);
    if (checkSelection) {
      selectedFoodItems.removeWhere((element) => element.id == foodItem.id);
    } else {
      bool check = await AppUtility.showConfirmationDialog(context,
          "You want to add ${foodItem.name} containing ${foodItem.calories} Cals");
      if (check) {
        print(foodItem.toJson());

        selectedFoodItems = [...selectedFoodItems, foodItem];
      }
    }
    update();
  }

  void saveButtonItems(MealData mealData) {
    print("meal id is ${mealData.id}");
    mealData.foodItems = [];
    print(mealData.foodItems?.length);

    mealData.foodItems?.addAll(selectedFoodItems);
    mealData.totalCalories=calculateTotalCalories(mealData);
    Get.back();
    update();
  }

  bool checkFoodItemSelection({
    required FoodItems foodItem,
  }) {
    for (FoodItems element in selectedFoodItems) {
      if (element.id == foodItem.id) {
        return true;
      }
    }

    return false;
  }
}
