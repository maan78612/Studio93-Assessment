import 'package:assessment_studio_93/constants/app/app_constants.dart';
import 'package:assessment_studio_93/controller/app_controller.dart';
import 'package:assessment_studio_93/ui/MealScreen/meal_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;


  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _animation = Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero)
        .animate(_animationController);
    _animationController.forward().whenComplete(() {
      navigateToNext();
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SlideTransition(
          position: _animation,
          child: Container(
            height: Get.height,
            width: Get.width,
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image(
                height: Get.height,
                width: Get.width,
                image: AssetImage(
                  AppConfig.images.logo,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onInit() async {
    Get.offAll(() => const MealScreen());
  }

  Future<void> navigateToNext() async {
    Future.delayed(const Duration(seconds: 2), () async {
      await onInit();
    });
  }
}
