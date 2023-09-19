import 'package:assessment_studio_93/constants/app/app_constants.dart';
import 'package:assessment_studio_93/constants/app/styles.dart';
import 'package:assessment_studio_93/controller/app_controller.dart';
import 'package:assessment_studio_93/model/food_items_model.dart';
import 'package:assessment_studio_93/model/meal_model.dart';
import 'package:assessment_studio_93/ui/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddFoodItems extends StatefulWidget {
  MealData mealData;

  AddFoodItems({required this.mealData, Key? key}) : super(key: key);

  @override
  State<AddFoodItems> createState() => _AddFoodItemsState();
}

var appController = Get.put(AppController());

class _AddFoodItemsState extends State<AddFoodItems> {
  @override
  void initState() {
    appController.selectedFoodItems = [];
    print(appController.selectedFoodItems.length);


    widget.mealData.foodItems?.forEach((element) {
      appController.selectedFoodItems.add(element);
    });

    super.initState();
  }

  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
      builder: ((appController) => Scaffold(
            backgroundColor: AppConfig.colors.offWhite,
            appBar: SharedWidget().customAppBar("Add Food Items", true),
            body: SafeArea(
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: ListView(
                              children: List.generate(
                                  appController.allFoodItems.length, (index) {
                            FoodItems foodItem =
                                appController.allFoodItems[index];
                            return GestureDetector(
                              onTap: () {
                                appController.addFoodItem(
                                    context: context, foodItem: foodItem);
                              },
                              child: Card(
                                color: appController.checkFoodItemSelection(
                                  foodItem: foodItem,
                                )
                                    ? AppConfig.colors.grey
                                    : AppConfig.colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(16.sp),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${foodItem.name ?? ""}",
                                          style: latoBold.copyWith(
                                              fontSize: 16.sp,
                                              color: appController
                                                      .checkFoodItemSelection(
                                                foodItem: foodItem,
                                              )
                                                  ? AppConfig.colors.white
                                                  : Color(0xffada9a6)),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "${foodItem.calories.toString()} Cals",
                                        style: latoBold.copyWith(
                                            fontSize: 14.sp,
                                            color: AppConfig.colors.black),
                                      ),
                                      SizedBox(width: 15),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            appController.saveButtonItems(widget.mealData);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                AppConfig.colors.black),
                          ),
                          child: Text(
                            "Save",
                            style: latoBlack.copyWith(fontSize: 14.sp),
                          ))
                    ]),
              ),
            ),
          )),
    );
  }
}
