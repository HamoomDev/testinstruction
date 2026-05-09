import 'package:get/get.dart';
import '../controllers/food_log_controller.dart';

class FoodLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FoodLogController>(() => FoodLogController());
  }
}
