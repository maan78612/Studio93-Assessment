import 'package:assessment_studio_93/constants/app/app_constants.dart';
import 'package:assessment_studio_93/controller/app_controller.dart';
import 'package:assessment_studio_93/model/meal_model.dart';
import 'package:assessment_studio_93/ui/MealScreen/widgets.dart';
import 'package:assessment_studio_93/ui/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppController>(
        builder: ((appController) => Scaffold(
              backgroundColor: AppConfig.colors.offWhite,
              appBar: SharedWidget().customAppBar("Meal",false),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                          List.generate(appController.mealList.length, (index) {
                        MealData mealData = appController.mealList[index];
                        return MealScreenWidgets().mealCard(
                            mealData: mealData, appController: appController);
                      }),
                    ),
                  ),
                ),
              ),
            )));
  }
}
