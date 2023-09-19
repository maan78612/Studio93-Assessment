import 'package:assessment_studio_93/constants/app/app_constants.dart';
import 'package:assessment_studio_93/constants/app/styles.dart';
import 'package:assessment_studio_93/controller/app_controller.dart';
import 'package:assessment_studio_93/model/food_items_model.dart';
import 'package:assessment_studio_93/model/meal_model.dart';
import 'package:assessment_studio_93/ui/addFoodItems/add_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MealScreenWidgets {
  Widget mealCard(
      {required MealData mealData, required AppController appController}) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: Get.width * 0.9,
          margin: EdgeInsets.only(bottom: 14.h),
          decoration: BoxDecoration(
              color: AppConfig.colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12.sp))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              mealInfo(mealData, appController),
              if ((mealData.foodItems ?? []).isNotEmpty)
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(8.sp),
                  padding: EdgeInsets.all(8.sp),
                  decoration: BoxDecoration(
                    color: AppConfig.colors.offWhite,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12.sp),
                        bottomRight: Radius.circular(12.sp)),
                  ),
                  child: foodItemList(
                      mealData: mealData, appController: appController),
                )
            ],
          ),
        ),
        addIcon(mealData),
      ],
    );
  }

  /*============== List of FOOD ITEMS ================*/
  Widget foodItemList(
      {required MealData mealData, required AppController appController}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(mealData.foodItems?.length ?? 0, (index) {
            FoodItems? foodItem = mealData.foodItems?[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "${foodItem?.name ?? ""}",
                          style: latoBold.copyWith(
                              fontSize: 16.sp, color: Color(0xffada9a6)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${foodItem?.calories.toString()} Cals",
                        style: latoBold.copyWith(
                            fontSize: 14.sp, color: AppConfig.colors.black),
                      ),
                      SizedBox(width: 15),
                      GestureDetector(
                          onTap: () {
                            if (mealData.isEdit) {
                              appController.removeFoodItem(
                                  meal: mealData, foodItem: foodItem);
                            }
                          },
                          child: Icon(
                              mealData.isEdit
                                  ? Icons.cancel
                                  : Icons.arrow_circle_right,
                              color: mealData.isEdit
                                  ? AppConfig.colors.red
                                  : AppConfig.colors.black,
                              size: 20.sp)),
                    ],
                  ),
                ),
                Divider(color: AppConfig.colors.white, thickness: 2)
              ],
            );
          }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.sp),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Total",
                  style: latoBold.copyWith(
                      fontSize: 16.sp, color: AppConfig.colors.green),
                ),
              ),
              SizedBox(width: 10),
              Text(
                "${mealData.totalCalories} Cals",
                style: latoBold.copyWith(
                    fontSize: 14.sp, color: AppConfig.colors.green),
              ),
              SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget mealInfo(MealData mealData, AppController appController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50.sp,
          width: 50.sp,
          margin: EdgeInsets.all(8.sp),
          decoration: BoxDecoration(
              color: AppConfig.colors.offWhite,
              borderRadius: BorderRadius.all(Radius.circular(10.sp))),
          child: Icon(
            mealData.logo,
            color: AppConfig.colors.black,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${mealData.title}",
              style: latoBold.copyWith(
                  fontSize: 16.sp, color: AppConfig.colors.black),
            ),
            (mealData.foodItems ?? []).isEmpty
                ? noProductWidget()
                : mealData.isEdit
                    ? saveButton(appController, mealData)
                    : Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: Row(
                          children: [
                            editButton(appController, mealData),
                            SizedBox(width: 10.w),
                            favButton(appController, mealData)
                          ],
                        ),
                      ),
          ],
        )
      ],
    );
  }

  /*================= Favorite Button ======================*/
  Widget favButton(AppController appController, MealData mealData) {
    return GestureDetector(
        onTap: () {
          appController.setFav(mealData);
        },
        child: Icon(
            mealData.isFav ? Icons.bookmark : Icons.bookmark_border_outlined,
            color: AppConfig.colors.black,
            size: 20.sp));
  }

  /*================= Edit Button ======================*/
  Widget editButton(AppController appController, MealData mealData) {
    return GestureDetector(
      onTap: () {
        appController.setEdit(mealData);
      },
      child: Container(
        child: Text("Edit",
            style: latoRegular.copyWith(color: AppConfig.colors.black)),
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 1.sp),
        decoration: BoxDecoration(
            color: AppConfig.colors.white,
            border: Border.all(color: AppConfig.colors.black, width: 1.5.sp),
            borderRadius: BorderRadius.all(Radius.circular(12.sp))),
      ),
    );
  }

  /*================= Save Button ======================*/
  Widget saveButton(AppController appController, MealData mealData) {
    return GestureDetector(
      onTap: () {
        appController.setEdit(mealData);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: Container(
          child: Text("Save",
              style: latoRegular.copyWith(color: AppConfig.colors.green)),
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 1.sp),
          decoration: BoxDecoration(
              color: AppConfig.colors.white,
              border: Border.all(color: AppConfig.colors.green, width: 1.5.sp),
              borderRadius: BorderRadius.all(Radius.circular(12.sp))),
        ),
      ),
    );
  }

  Container noProductWidget() {
    return Container(
      child: Text(
        "No Products",
        style: latoRegular.copyWith(color: AppConfig.colors.white),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 2.sp),
      margin: EdgeInsets.only(top: 8.h),
      decoration: BoxDecoration(
          color: AppConfig.colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12.sp))),
    );
  }

  Widget addIcon(MealData mealData) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddFoodItems(mealData: mealData));
      },
      child: Container(
        height: 60.sp,
        width: 50.sp,
        decoration: BoxDecoration(
          color: AppConfig.colors.black,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(16.sp),
              bottomLeft: Radius.circular(16.sp)),
          boxShadow: [
            BoxShadow(
              color: AppConfig.colors.offWhite,
              blurRadius: 0,
              spreadRadius: 2,
              offset: Offset(-2, 2), // Shadow position
            ),
          ],
        ),
        child: Icon(
          Icons.add,
          color: AppConfig.colors.white,
        ),
      ),
    );
  }
}
