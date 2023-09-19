import 'package:assessment_studio_93/model/food_items_model.dart';
import 'package:assessment_studio_93/model/meal_model.dart';
import 'package:flutter/material.dart';

class MealServices {
  static List<MealData> populateMealList() {
    List<MealData> mealData = [
      MealData(
        id: '1',
        title: 'Meal One',
        logo: Icons.wb_twilight,
      ),
      MealData(
        id: '2',
        title: 'Meal Two',
        logo: Icons.file_copy_rounded,
      ),
      MealData(
        id: '3',
        title: 'Meal Three',
        logo: Icons.sunny,
      ),
      MealData(
        id: '4',
        title: 'Meal Four',
        logo: Icons.sunny_snowing,
      ),
      MealData(
        id: '5',
        title: 'Meal Five',
        logo: Icons.nightlight,
      ),
      MealData(
        id: '6',
        title: 'Meal Six',
        logo: Icons.nights_stay,
      ),
    ];
    return mealData;
  }

  static List<FoodItems> populateAllFoodItems() {
    List<FoodItems> allFoodItems = [
      FoodItems(id: '1', name: 'Spicy Bacon Cheese Toast', calories: 300),
      FoodItems(id: '2', name: 'Almond Milk', calories: 100),
      FoodItems(id: '3', name: 'Cheese Cake', calories: 313),
      FoodItems(id: '4', name: 'Chicken Steak', calories: 245),
      FoodItems(id: '5', name: 'Salad', calories: 100),
      FoodItems(id: '6', name: 'Boil Eggs', calories: 97),
      FoodItems(id: '7', name: 'Pizza', calories: 500),
      FoodItems(id: '8', name: 'Waffles', calories: 130),
      FoodItems(id: '9', name: 'Noodles (spaghetti)', calories: 159),
    ];

    return allFoodItems;
  }
}
