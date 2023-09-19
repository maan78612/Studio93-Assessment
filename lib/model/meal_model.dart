import 'package:assessment_studio_93/model/food_items_model.dart';
import 'package:flutter/material.dart';

class MealData {
  String? id;
  String? title;
  IconData? logo;
  bool isEdit;
  bool isFav;
  double totalCalories;
  List<FoodItems>? foodItems;

  MealData({
    required this.id,
    required this.title,
    required this.logo,
    this.isEdit = false,
    this.isFav = false,
    this.foodItems ,
    this.totalCalories = 0,
  });


}
